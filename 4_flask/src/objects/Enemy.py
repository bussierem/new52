from objects.Combatant import *
from objects.attacks.Attack import *

class Enemy(Combatant):
  def __init__(self, **kwargs):
    Combatant.__init__(
      self,
      kwargs.get('name', "Enemy"),
      'Enemy',
      kwargs.get('health', 10),
      kwargs.get('init', 0),
      kwargs.get('defense', 10),
      kwargs.get('attacks', [])
    )
    self.cr = kwargs.get('cr', 0)

  def to_json(self):
    base = Combatant.to_json(self)
    base['cr'] = self.cr
    return base

  def __str__(self):
    out = ""
    out += "Name: {0}\nChallenge Rating: {1}\nHealth: {2}\nInitiative: {3}\n".format(
      self.name, self.cr, self.hp,
      ("+" + str(self.init)) if (self.init >= 0) else self.init
    )
    out += "Attacks:\n"
    out += "".join(["  {}\n".format(a) for a in self.attacks])
    return out
