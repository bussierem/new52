import React, { Component } from 'react';
import {Panel} from 'react-bootstrap';
import {Accordion,AccordionItem,AccordionItemTitle,AccordionItemBody} from 'react-accessible-accordion';

class BeingList extends Component{
	
	constructor(props){
		super(props);
	}
	
	render(){
		return <Panel defaultExpanded>
    <Panel.Title toggle>
      <h3> {this.props.type || "No type specified :^ ("} </h3>
    </Panel.Title>
    <Panel.Collapse>
    <Panel.Body>
      <Accordion accordion={false}>
      {
        (this.props.beings || []).map(being=>{
          return <AccordionItem>
            <AccordionItemTitle>
              <h4>{being.name || "No name specified :^ ("}</h4>
            </AccordionItemTitle>
              <AccordionItemBody>
                {Object.keys(being || {}).filter(key=>key!=='name').map(attrName=>{
                  return <p>{`${attrName}:${being[attrName]}`}</p>
                })}
              </AccordionItemBody>
          </AccordionItem>
        })
      }
      </Accordion>
    </Panel.Body>
    </Panel.Collapse>
    </Panel>;
	}
}
export default BeingList;