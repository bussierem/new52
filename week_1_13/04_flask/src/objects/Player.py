from objects.Combatant import *
from objects.attacks.Attack import *
from objects.attacks.Magic import *

class Player(Combatant):
  def __init__(self, **kwargs):
    Combatant.__init__(
      self,
      kwargs.get('name', "Player"),
      "Player",
      kwargs.get('health', 10),
      kwargs.get('init', 0),
      kwargs.get('defense', 10),
      kwargs.get('attacks', [])
    )
    self.level = kwargs.get('level', 1)
    self.spells = kwargs.get('spells', [])
    self.consumables = kwargs.get('consumables', 0)
    self.regenerators = kwargs.get('regenerators', 0)

  def attack(self, target):
    if (self.spells != []):
      if random.randint(0,1) > 0:
        atk_list = self.attacks
      else:
        atk_list = self.spells
    else:
      atk_list = self.attacks
    attack = None
    while attack == None:
      attack = atk_list[random.randint(0, len(atk_list)-1)]
      if isinstance(attack, Magic):
        if self.regenerators < attack.level:
          attack = None
        else:
          self.regenerators -= attack.level
    print("Attacking with:\n{}".format(attack))
    to_hit, is_crit, damage = attack.roll()
    if is_crit:
      print("CRIT!")
      damage['total'] *= 2
    total_damage = damage['total']
    is_hit = to_hit['total'] >= target.defense
    if is_hit:
      print("Attack hit ({} to hit vs. {}) for {} damage!".format(
        to_hit['total'], target.defense, total_damage
      ))
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

  def to_json(self):
    base = Combatant.to_json(self)
    base['level'] = self.level
    base['consumables'] = self.consumables
    base['regenerators'] = self.regenerators
    base['spells'] = [spell.to_json() for spell in self.spells]
    return base

  def __str__(self):
    out = ""
    out += "Name: {0}\nLevel: {1}\nHealth: {2}\nInitiative: {3}\n".format(
      self.name, self.level, self.hp,
      ("+" + str(self.init)) if (self.init >= 0) else self.init
    )
    out += "Consumables: {0}\nRegenerators: {1}\n".format(
      self.consumables, self.regenerators
    )
    out += "Attacks:\n"
    out += "".join(["  {}\n".format(a) for a in self.attacks])
    return out
