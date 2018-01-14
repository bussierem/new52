const express = require('express');
const Utils   = require('./utils.js');
const utils   = new Utils();

// ROUTES
var router = express.Router();

router.get('/', (req, res) => {
  res.json({ message: 'Welcome to the API!' });
});

// ID-based Routes
router.route('/project/:pid')
  // Get Project
  .get((req, res) => {
    var pid = req.params.pid;
    console.log(`GET: /api/project/${pid}`);
    var result = utils.findProjectById(pid);
    if (result.length > 1) {
      res.status(500).json({ message: `ERROR:  Found duplicate IDs:\n${result}` });
    } else {
      res.json(result[0]);
    }
  })
  // Update Project
  // EXPECTED BODY:
  //   "Project" object with any updated properties and their values
  .put((req, res) => {
    try {
      utils.validateUpdateBody(req.body);
      var project = utils.findProjectById(req.params.pid)[0];
      Object.keys(req.body.project).forEach((p) => {
        project.project[p] = req.body.project[p];
      });
      var newData = utils.updateDataWithProject(project);
      utils.saveData(newData);
      console.log(`PUT: /api/project/${req.params.pid}`);
      res.json({ message: `Project [${req.params.pid}] updated!` });
    } catch(e) {
      console.log(`ERROR: ${e}`);
      res.json({ message: `ERROR: ${e}` });
    }
  })
  // Delete Project
  .delete((req, res) => {
    var project = utils.findProjectById(req.params.pid)[0];
    var newData = utils.deleteProject(project);
    utils.saveData(newData);
    console.log(`DELETE: /api/project/${req.params.pid}`);
    res.json({ message: `Project [${req.params.pid}] deleted!` });
  });

// Generic Routes
router.route('/projects')
  // Get all projects
  .get((req, res) => {
    var projects = utils.loadProjects();
    console.log('GET: /api/projects');
    res.json(projects);
  })
  // Create Project
  // EXPECTED BODY:
  //   { "desc": "Some Description for the new Project" }
  .post((req, res) => {
    console.log('POST: /api/projects');
    try {
      var desc = utils.validateCreateBody(req.body);
      console.log(desc);
      var project = utils.addProject(desc);
      res.json(project);
    } catch (e) {
      console.log(`ERROR:  ${e}`);
      res.json({ message: `ERROR: ${e}` });
    }
  });

module.exports = router;
