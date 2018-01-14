const fs       = require('fs');
const projFile = '../data/projects.json';

module.exports = class Utils {
  loadProjects() { return JSON.parse(fs.readFileSync(projFile)); }

  saveData(data) { fs.writeFileSync(projFile, JSON.stringify(data, null, '\t')); }

  findProjectById(pid) {
    var data = this.loadProjects();
    return data.projects.filter((p) => {
      return p.id == pid;
    });
  }

  addProject(projectDesc) {
    var data = this.loadProjects();
    var newId = Math.max(...data.projects.map((p) => { return p.id; })) + 1;
    var newProject = {
      "id": newId,
      "project": {
        "week": (newId + 1).toString(),
        "desc": projectDesc,
        "hours": 0
      }
    };
    console.log(data.projects);
    data.projects.push(newProject);
    this.saveData(data);
    return newProject;
  }

  updateDataWithProject(project) {
    var data = this.loadProjects();
    data.projects.forEach((p, idx) => {
      if(p.id == project.id) {
        data.projects[idx] = project;
      }
    });
    return data;
  }

  deleteProject(project) {
    var data = this.loadProjects();
    var idx = data.projects.indexOf(project);
    data.projects.splice(idx, 1);
    return data;
  }

  validateCreateBody(body) {
    if(!Object.keys(body).includes("desc")) {
      throw "Expected object with 'desc' key/value pair";
    }
    return body.desc;
  }

  validateUpdateBody(body) {
    var keys = Object.keys(body);
    var projectKeys = ['week', 'desc', 'hours'];
    if(!(keys.length == 1 && keys[0] == 'project')) {
      throw "Expected object containing a   'project': {}   key/value pair";
    } else {
      Object.keys(body.project).forEach((k) => {
        if (!projectKeys.includes(k)) {
          throw `Unexpected key in project object: '${k}'`;
        }
      });
    }
    return;
  }
};
