import React, { Component } from 'react';
import './App.css';
import { Form, Label, Input, Button, ListGroup, ListGroupItem, Badge, Progress } from 'reactstrap';

import data from './projects.json';

var jsonfile = require('jsonfile');

class ProjectList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: data.projects
    };
    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
  }

  componentDidMount() {
    this.TimerId = setInterval(
      () => {this.setState({projects: data.projects})},
      500
    );
  }

  componentWillUnmount() {
    clearInterval(this.TimerID);
  }

  saveData() {
    console.error('TODO:  IMPLEMENT SAVING');
  }

  updateData() {
    this.setState({projects: data.projects});
  }

  addHoursToProject(name, hours) {
    var idx = this.state.projects.findIndex((p) => {
      return p.id === parseInt(name);
    });
    var projectList = this.state.projects;
    projectList[idx].project.hours += hours;
    this.setState({projects: projectList});
    this.saveData();
  }

  add(e) {
    this.addHoursToProject(e.target.name, 1);
  }

  subtract(e) {
    this.addHoursToProject(e.target.name, -1);
  }

  render() {
    const projectList = this.state.projects.map((p) => (
      <ListGroupItem key={p.id.toString()}>
        Week {p.project.week}:  {p.project.desc}
        <Badge pill>{p.project.hours}</Badge>
        <Button outline color="primary" size="sm" name={p.id} onClick={this.add}>+</Button>
        <Button outline color="secondary" size="sm" name={p.id} onClick={this.subtract}>-</Button>
        <Progress striped value={(parseInt(p.project.hours) / 8) * 100}>{p.project.hours}</Progress>
      </ListGroupItem>
    ));
    return (
      <div className="List">
        <ListGroup>
          {projectList}
          <ListGroupItem key="999">
            <AddProject />
          </ListGroupItem>
        </ListGroup>
      </div>
    )
  }
}

class AddProject extends Component {
  constructor(props) {
    super(props);
    this.state = {
      showForm: false,
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
    var newId = Math.max(...data.projects.map((p) => { return p.id; })) + 1;
    var newProject = {
      "id": newId,
      "project": {
        "week": (newId + 1).toString(),
        "desc": this.state.value,
        "hours": 0
      }
    }
    data.projects.push(newProject);
    this.setState({showForm: !this.state.showForm})
  }

  addProject(e) {
    e.preventDefault();
    this.setState({showForm: !this.state.showForm});
  }

  render() {
    return (
      <div>
        {this.state.showForm &&
          <div className="Form">
            <Form inline>
              <Label for="project">Project:</Label>
              <Input type="text" name="project" id="project" onChange={this.changed}/>
              <Button onClick={this.submit}>Add Project</Button>
            </Form>
          </div>
        }
        <Button disabled={this.state.showForm} onClick={this.addProject}>Add Project</Button>
      </div>
    );
  }
}

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <h1 className="App-title">New 52 Project</h1>
        </header>
        <ProjectList />
      </div>
    );
  }
}

export default App;
