from battle.BattleManager import *
from systems.Utilities import *

import random
import json
import sys, os
import uuid

class CombatSystem:
  def __init__(self, players, enemies):
    self.battle = BattleManager(players, enemies)
    self.turn_order = []
    self.current_index = 0

  def roll_initiative(self):
    self.turn_order = [[c, c.roll_init()['total']] for c in self.battle.combatants]
    self.turn_order.sort(key=lambda x: x[1], reverse=True)

  def next_combatant(self):
    return self.turn_order[self.current_index][0]

  def play_combat_round(self):
    for i, cur_combatant in enumerate([x[0] for x in self.turn_order]):
      self.current_index = i
      print("{}'s turn! FIGHT!".format(cur_combatant.name))
      turn_result = self.battle.combatant_turn(cur_combatant)
      if self.battle.battle_over():
        print("BATTLE OVER!")
        break
    return turn_result

  def play_full_combat(self):
    combat_data = {"rounds": [], 'winner': "", 'loser': ""}
    while not self.battle.battle_over():
      combat_data['rounds'].append(self.play_combat_round())
    if self.battle.enemies == []:
      combat_data['winner'] = "Players"
      combat_data['loser'] = "Enemies"
    else:
      combat_data['winner'] = "Enemies"
      combat_data['loser'] = "Players"
    return self.record_battle(combat_data)

  # --------------------------------- /
  # ------ UTILITY FUNCTIONS -------- /
  # --------------------------------- /

  def record_battle(self, battle):
    # record separate battle, assign ID
    guid = str(uuid.uuid4())
    combat_data['id'] = guid
    write_data_to_json(combat_data, "../data/battles/{}.json".format(guid))
    # build an overview and add it to list
    combat_overview = {
      'id': guid,
      'winner': combat_data['winner'],
      'loser': combat_data['loser'],
      'round_duration': len(combat_data['rounds'])
    }
    battle_data = read_json_file('../data/battles.json')
    battle_data['battles'].append(combat_overview)
    write_data_to_json(battle_data, '../data/battles.json')
    return combat_overview


  def print_initiative(self):
    for c in self.turn_order:
      print("{}: {}".format(c[0].name, c[1]))
