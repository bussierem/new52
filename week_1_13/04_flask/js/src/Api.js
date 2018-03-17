const serverUrl = 'https://battle-sim.herokuapp.com';

module.exports = {
  getBattles: ()=>{
    return fetch(`${serverUrl}/battles`);
  },
  getBattle:()=>{
    
  },
  createBattle:()=>{
    
  },
  deleteBattle:()=>{
    
  },
  createPlayer:()=>{
    
  },
  editPlayer:()=>{
    
  },
  getPlayers:()=>{
    
  },
  getPlayer:()=>{
    
  }
}