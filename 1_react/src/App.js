import React, { Component } from 'react';
import './App.css';
import { Form, Label, Input, Button, ListGroup, ListGroupItem, Badge, Progress } from 'reactstrap';

class ProjectList extends Component {
  constructor(props) {
    super(props);
    this.state = {};
    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
    this.delete = this.delete.bind(this);
  }

  componentDidMount() {
  }

  componentWillUnmount() {
  }

  saveData() {
  }

  addHoursToProject(name, hours) {
    this.props.onBtnClick(name, hours);
  }

  add(e) {
    this.addHoursToProject(e.target.name, 1);
  }

  subtract(e) {
    this.addHoursToProject(e.target.name, -1);
  }

  delete(e) {
    this.props.onDelete(e.target.name);
  }

  render() {
    var projectList = this.props.projects.map((p) => (
      <div className="project">
        <ListGroupItem key={p.id.toString()} >
          <div className="ListDesc">
          <Button className="delete" color="danger" size="sm" name={p.id.toString()} onClick={this.delete}>X</Button>
          Week {p.project.week}:  {p.project.desc}
          <Button className="counter" outline color="success" size="sm" name={p.id.toString()} onClick={this.add}>+</Button>
          <Button className="counter" outline color="danger" size="sm" name={p.id.toString()} onClick={this.subtract}>-</Button>
          </div>
          <Progress striped value={(parseInt(p.project.hours, 10) / 8) * 100}>{p.project.hours}</Progress>
        </ListGroupItem>
      </div>
    ));
    return (
      <div className="List">
        <ListGroup>
          {projectList}
        </ListGroup>
      </div>
    )
  }
}

class AddProject extends Component {
  constructor(props) {
    super(props);
    this.state = {
      value: ''
    };
    this.changed = this.changed.bind(this);
    this.submit = this.submit.bind(this);
    this.addProject = this.addProject.bind(this);
  }

  changed(e) {
    this.setState({value: e.target.value});
  }

  submit() {
    var newId = Math.max(...this.props.projects.map((p) => { return p.id; })) + 1;
    var newProject = {
      "id": newId,
      "project": {
        "week": (newId + 1).toString(),
        "desc": this.state.value,
        "hours": 0
      }
    };
    this.props.onSubmit(newProject)
  }

  addProject(e) {
    e.preventDefault();
    this.props.onAddProject();
  }

  render() {
    return (
      <div>
        {this.props.showForm &&
          <div className="Form">
            <Form inline>
              <Label for="project">Project:</Label>
              <Input type="text" name="project" id="project" onChange={this.changed}/>
              <Button onClick={this.submit}>Add Project</Button>
            </Form>
          </div>
        }
        <Button disabled={this.props.showForm} onClick={this.addProject}>
          Add Project
        </Button>
      </div>
    );
  }
}

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showForm: false,
      projects: []
    };
    this.getProjects = this.getProjects.bind(this);
    this.addHoursToProject = this.addHoursToProject.bind(this);
    this.createProject = this.createProject.bind(this);
    this.showProjectForm = this.showProjectForm.bind(this);
    this.deleteProject = this.deleteProject.bind(this);
  }

  componentDidMount() {
    this.getProjects();
  }

  getProjects() {
    var response;
    fetch(`http://localhost:3001/projects`)
      .then((response) => {
        if(response.status !== 200) {
          console.warn(response.status);
          return;
        }
        response.json().then((data) => {
          response = data;
          this.setState({projects: data});
        });
      });
    return response;
  }

  addHoursToProject(name, hours) {
    this.setState((prevState, props) => {
      var projectList = prevState.projects.map((p) => ({
        ...p,
        project: {
          ...p.project,
          hours: p.project.hours += ((p.id === parseInt(name, 10)) ? hours : 0),
        },
      }));
      return {projects: projectList};
    }, () => {
      var url = `http://localhost:3001/projects/`+ name;
      fetch(url, {
        method: 'put',
        headers: new Headers({
          'Content-Type': 'application/json'
        }),
        body: JSON.stringify(this.state.projects[parseInt(name, 10)])
      });
    });
  }

  createProject(project) {
    this.setState((prevState, props) => ({
      projects: [
        ...prevState.projects,
        project,
      ],
      showForm: !prevState.showForm
    }), () => {
      fetch(`http://localhost:3001/projects`, {
        method: 'post',
        headers: new Headers({
          'Content-Type': 'application/json'
        }),
        body: JSON.stringify(project)
      });
    });
  }

  showProjectForm() {
    this.setState({showForm: !this.state.showForm});
  }

  deleteProject(name) {
    var idx = this.state.projects.find((p) => {
      return name === p.id.toString();
    });
    this.setState((prevState, props) => {
      prevState.projects = prevState.projects.slice(idx, 1);
      return { projects: prevState.projects };
    }, () => {
      fetch(`http://localhost:3001/projects/` + name, {
        method: 'delete',
      });
    });
  }

  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">New 52 Project</h1>
        </header>
        <ProjectList
          projects={this.state.projects}
          onBtnClick={this.addHoursToProject}
          onDelete={this.deleteProject}
        />
        <AddProject
          onSubmit={this.createProject}
          showForm={this.state.showForm}
          projects={this.state.projects}
          onAddProject={this.showProjectForm}
        />
      </div>
    );
  }
}

export default App;
