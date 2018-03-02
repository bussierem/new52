import React, { Component } from 'react';
import {Modal,Button} from 'react-bootstrap';
import Form from 'react-jsonschema-form';

class CreateCombatant extends Component{
  constructor(props){
    super(props);
    this.handleShow = this.handleShow.bind(this);
    this.handleClose = this.handleClose.bind(this);
    this.state = {
      show:false
    }
  }
  handleClose(){
    this.setState({show:false});
  }
  handleShow(){
    this.setState({show:true});
  }
  render(){
    return this.state.show ? 
    <Modal.Dialog show={this.state.show}>
      <Modal.Header>
        <Modal.Title>Create {this.props.schema.title}</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form schema={this.props.schema}/>
      </Modal.Body>
      <Modal.Footer>
        <Button onClick = {this.handleClose}> Close </Button>
        <Button> Add </Button>
      </Modal.Footer>
    </Modal.Dialog> :
    <Button onClick = {this.handleShow}> Create {this.props.schema.title} </Button>;
  }
}

export default CreateCombatant;