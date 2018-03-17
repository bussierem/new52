from objects.attacks.Attack import *
from systems.Dice import roll_dice

import random
import uuid
import copy

class Combatant(object):
    def __init__(self, name, ctype, health, initiative_mod, defense, attack_list):
      self.id = str(uuid.uuid4())
      self.name = name
      self.type = ctype
      self.hp = health
      self.init = initiative_mod
      self.defense = defense
      self.attacks = attack_list

    def to_json(self):
      return {
        'id': self.id,
        'name': self.name,
        'type': self.type,
        'health': self.hp,
        'initiative': self.init,
        'defense': self.defense,
        'attacks': [atk.to_json() for atk in self.attacks if atk.type != Attack_Type.Magic]
      }

    def roll_init(self):
      return roll_dice("1d20{}".format(
        "+{}".format(self.init) if self.init >= 0 else self.init
      ))

    def attack(self, target):
      attack = self.attacks[random.randint(0, len(self.attacks)-1)]
      print("Attacking with:\n{}".format(attack))
      to_hit, is_crit, damage = attack.roll()
      if is_crit:
        print("CRIT!")
        damage['total'] *= 2
      total_damage = damage['total']
      print("DAMAGE: ", damage)
      is_hit = to_hit['total'] >= target.defense
      if is_hit:
        print("Attack hit for {} damage!".format(total_damage))
        target.damage(total_damage)
      else:
        print("Attack MISSED! ({} to hit vs. {})".format(to_hit['total'], target.defense))
      return {
        'attack': attack.to_json(),
        'hit': is_hit,
        'crit': is_crit,
        'attack_roll': to_hit,
        'damage_roll': damage
      }

    def damage(self, dmg):
      self.hp -= dmg
      print("{}'s new HP: {}".format(self.name, self.hp))

    def __str__(self):
      out = "Name: {0}\nHealth: {1}\nInitiative: {2}\nDefense: {3}\n".format(
        self.name, self.hp,
        ("+" + str(self.init)) if (self.init >= 0) else self.init,
        self.defense
      )
      out += "Attacks:\n"
      out += "".join(["  {}\n".format(a) for a in self.attacks])
      return out
