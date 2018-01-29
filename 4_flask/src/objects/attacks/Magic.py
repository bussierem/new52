from objects.attacks.Attack import *

class Magic(Attack):
  def __init__(self, spell_lvl, hit_bonus, damage):
    Attack.__init__(self, 'Magic', hit_bonus, damage)
    self.level = spell_lvl

  def to_json(self):
    return {
      'atk_type': self.type.name,
      'spell_lvl': self.level,
      'hit_bonus': self.hit,
      'damage': self.damage
    }

  def __str__(self):
    dmg = self.damage.split('-') if '-' in self.damage else self.damage
    isRange = isinstance(dmg, tuple)
    return "Level {0} Spell: {1}, {2}{3} damage".format(
      self.level,
      "+{}".format(self.hit) if self.hit >= 0 else self.hit,
      dmg[0] if isRange else dmg,
      "-" + dmg[1] if isRange else ""
    )
