import re
import random

BEAST = r'(?P<count>\d+)d(?P<dice>[\d]+)(?P<bonus>[+-]\d+)?'

def roll_dice(dice_str):
  results = re.match(BEAST, dice_str)
  count = int(results.group("count"))
  dice = int(results.group("dice"))
  bonus = int(results.group("bonus") or 0)
  rolls = [random.randint(1,dice) for i in range(count)]
  total = sum(rolls) + bonus
  return {"total": total, "rolls": rolls, "bonus": bonus}

def rand_from_range(dmg_str):
  vals = [int(x) for x in dmg_str.split('-')]
  return { "total": random.randint(*vals) }
