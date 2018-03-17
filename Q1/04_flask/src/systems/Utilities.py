import random
import json

def rand_from_list(lst):
  return lst[random.randint(0, len(lst) - 1)]

def read_json_file(fpath):
  with open(fpath, "r") as infile:
    data = json.loads(infile.read())
  return data

def write_data_to_json(data, fpath):
  print("fpath: {}".format(fpath))
  with open(fpath, "w") as bf:
    json.dump(data, bf, indent=2)
