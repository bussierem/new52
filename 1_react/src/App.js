import React, { Component } from 'react';
import './App.css';
import { Button, ListGroup, ListGroupItem, Badge, Progress } from 'reactstrap';

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

  saveData() {
    console.error('TODO:  IMPLEMENT SAVING');
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
        Week {p.project.week} ({p.project.dateRange}): {p.project.desc}
        <Badge pill>{p.project.hours}</Badge>
        <Button outline color="primary" size="sm" name={p.id} onClick={this.add}>+</Button>
        <Button outline color="secondary" size="sm" name={p.id} onClick={this.subtract}>-</Button>
        <br />
        <Progress striped value={(parseInt(p.project.hours) / 8) * 100}>{p.project.hours}</Progress>
      </ListGroupItem>
    ));
    return (
      <div className="List">
        <ListGroup>{projectList}</ListGroup>
      </div>
    )
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
