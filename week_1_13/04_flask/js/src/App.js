import React, { Component } from 'react';
import {Grid,Row,Col,Panel} from 'react-bootstrap';
import {Accordion} from 'react-accessible-accordion';
import './libs/react-accessible-accordion.css';
import './libs/bootstrap.min.css';
import './App.css';

import BeingList from './BeingList'
import CreateCombatant from './CreateCombatant';
const Api = require('./Api');
const SchemaLoader = require('./SchemaLoader');

class App extends Component {
  constructor(props){
    super(props);
    const allSchemas = SchemaLoader("Player","Enemy");
    this.state = {
      players:[],
      enemies:[],
      round:-1,
      allSchemas
    };
    /*const battle = Api.getBattle().then((response)=>{
      console.log(response);
      response.json().then((battle)=>{
         this.setState({
            players:battle.steps[0].players,
            enemies:battle.steps[0].enemies
         });
      });
    });*/
  }
  render() {
    return (
      <div className="app">
      <div className='pageHeader'>
        <h2>Battle Simulator <small> v 0.00001 </small></h2>
      </div>
      <Grid>
      <Row className='row' id='headerRow'>
      <Col xs={12}>
      <Panel defaultExpanded>
      <Panel.Title toggle>
        <h3> Actions </h3>
      </Panel.Title>
      <Panel.Collapse>
      <Panel.Body>
        <CreateCombatant schema={this.state.allSchemas["Player"]}/>
        <CreateCombatant schema={this.state.allSchemas["Enemy"]}/>
      </Panel.Body>
      </Panel.Collapse>
      </Panel>
      </Col>
      </Row>
			<Row className='row' id='topRow'>
				<Col sm = {6} className='col'>
          <BeingList beings={this.state.players} type="Players"/>     
				</Col>
				<Col sm = {6} className='col'>
					<BeingList beings={this.state.enemies} type="Enemies"/>
				</Col>
			</Row>
			<Row className='row' id='bottomRow'>
          <h3> Round </h3>
				 <Col xs={4} className='pull-left'>
					<h3>Player</h3>
				</Col>
        <Col xs={4} className='center'>
					<h3>Battle</h3>
				</Col>
        <Col xs={4} className ='pull-right'>
					<h3>Enemy</h3>
				</Col>
			</Row>
		</Grid>
      </div>
    );
  }
}

export default App;
