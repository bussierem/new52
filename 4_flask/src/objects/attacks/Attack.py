from systems.Dice import *

import random
from enum import Enum

class Attack_Type(Enum):
  Melee = "Melee"
  Ranged = "Ranged"
  Magic = "Magic"

class Attack:
  def __init__(self, atk_type, hit_bonus, damage):
    self.type = Attack_Type[atk_type]
    self.hit = hit_bonus
    # damage_str can be either "<min>-<max>" or "XdY+B" format
    self.damage = damage

  def roll(self):
    is_crit = False
    hit_result = roll_dice("1d20{}".format(
      "+{}".format(self.hit) if self.hit >= 0 else self.hit
    ))
    damage_result = rand_from_range(self.damage) if "-" in self.damage else roll_dice(self.damage)
    is_crit = (hit_result['rolls'][0] == 20)
    return hit_result, is_crit, damage_result

  def to_json(self):
    return {
      'atk_type': self.type.name,
      'hit_bonus': self.hit,
      'damage': self.damage
    }

  def __str__(self):
    dmg = self.damage.split('-') if '-' in self.damage else self.damage
    isRange = isinstance(dmg, tuple)
    return "{0} Attack: {1}, {2}{3} damage".format(
      self.type.name,
      "+{}".format(self.hit) if self.hit >= 0 else self.hit,
      dmg[0] if isRange else dmg,
      "-" + dmg[1] if isRange else ""
    )
