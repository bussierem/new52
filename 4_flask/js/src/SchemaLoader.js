const merge = require('lodash.merge');

module.exports = (...schemaNames)=>{
  const allSchemas = {};
  const getExpandableType = (prop)=>{
    switch(prop.type){
      case "integer":
      case "string":
      case "object":
        return false;
      case "array":
        return getExpandableType(prop.items);
      default:
        return prop.type;
    }
  }
  const loadSchema = (schemaName)=>{
    console.log(`Loading schema for ${schemaName}`);
    if(allSchemas[schemaName]){
      return JSON.parse(JSON.stringify(allSchemas[schemaName]));
    }
    let curSchema = require(`../../schemas/${schemaName}`);
    if(curSchema.base_class){
      const baseSchema = loadSchema(curSchema.base_class);
      curSchema.properties = merge(curSchema.properties,baseSchema.properties);
    }
    Object.keys(curSchema.properties).filter(prop=>getExpandableType(curSchema.properties[prop])).forEach(prop=>{
      const expandedSchema = loadSchema(getExpandableType(curSchema.properties[prop]));
      let expandPtr = curSchema.properties;
      while(expandPtr[prop].type==='array'){
        expandPtr = expandPtr[prop];
        prop = 'items';
      }
      expandPtr[prop] = expandedSchema;
    });
    allSchemas[schemaName] = curSchema; 
    return loadSchema(schemaName);
  }
  schemaNames.forEach(schemaName=>{
    loadSchema(schemaName);
  });
  return allSchemas;
}