import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import data from './projects.json';

class ProjectList extends Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: data.projects
    };
  }

  render() {
    const projectList = this.state.projects.map((project) => (
      <li id="project">
        Week {project.week} ({project.dateRange}): {project.project}  [Hours Spent: {project.hours}]
      </li>
    ));
    return (
      <ol id="projectList">{projectList}</ol>
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
