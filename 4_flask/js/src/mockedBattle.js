const faker = require('faker');
const fs = require('fs');

const playerSchema = {
  name:()=>faker.name.findName(),
  health:()=>Math.random()*100,
  spells:()=>{
    let i;
    const spells = [];
    for(i = 0; i<Math.random()*5; i++){
      spells.push(faker.name.findName());
    }
    return spells;
  },
  perception:()=>Math.random()*20,
};

const enemySchema = {
  name:()=>faker.name.findName(),
  health: ()=>Math.random()*50,
  damage: ()=>Math.random()*5,
};

const createPlayer = (props)=>createBeing(playerSchema,props);
const createEnemy = (props)=>createBeing(enemySchema,props);

const createBeing = (schema,props={})=>{
  const being = {};
  Object.keys(schema).forEach(key=>{
    being[key] = props[key] || schema[key]();
  });
  return being;
};
const createDefaultBeings = (creationFn,numBeings = 20)=>{
  let i;
  const beings = [];
  for(i = 0; i<numBeings; i++){
    beings.push(creationFn());
  }
  return beings;
};
const players = createDefaultBeings(createPlayer);
const enemies = createDefaultBeings(createEnemy,15);

const battle =
{
  id:400,
  steps:[{
    players,
    enemies
  }]
};
fs.writeFileSync('mockedBattle.json',JSON.stringify(battle));
module.exports = battle;