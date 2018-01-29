from objects.attacks.Attack import *
from objects.attacks.Magic import *
from systems.CombatSystem import *
from systems.Utilities import *

from flask import Flask, request, Response, send_from_directory
from flask_cors import CORS
from flasgger import Swagger, swag_from
import json
import os

static_folder = 'js/build'
app = Flask(__name__,static_folder=static_folder)
CORS(app)
swagger = Swagger(app)

# ------------------ /
# UTILTITY FUNCTIONS /
# ------------------ /

def get_object_response(fpath, guid):
  try:
    obj = read_json_file("{}/{}.json".format(fpath, guid))
    return Response(json.dumps(obj, indent=2), status=200, mimetype="application/json")
  except FileNotFoundError:
    return Response("INVALID GUID {}".format(guid), status=404)

def delete_object(fpath, key, guid):
  data = read_json_file(fpath)
  found = False
  for i, obj in enumerate(data[key]):
    if obj == guid:
      del data[key][i]
      found = True
      break
  if(found):
    write_data_to_json(data, fpath)
    os.remove("../data/combatants/{}/{}.json".format(key, guid))
    resp = Response(status=204)
  else:
    resp = Response(status=404)
  return resp

def add_combatant_to_record(ctype, guid):
  record_file = "../data/combatants/{}.json".format(ctype)
  data = read_json_file(record_file)
  if guid not in data[ctype]: # for update
    data[ctype].append(guid)
  write_data_to_json(data, record_file)

def create_combatant(request, ctype, guid=None):
  combatant = request.get_json()
  if combatant == None:
    return Response("ERROR WITH POST DATA", status=400)
  # Build Attacks
  combatant['attacks'] = [Attack(**atk) for atk in combatant['attacks']]
  if ctype == "players":
    if "spells" not in combatant.keys():
      combatant['spells'] = []
    combatant['spells'] = [Magic(**spell) for spell in combatant['spells']]
    new_combatant = Player(**combatant)
  elif ctype == "enemies":
    if "spells" in combatant.keys():
      del combatant['spells']
    new_combatant = Enemy(**combatant)
  else:
    return Response("ERROR WITH POST DATA", status=400)
  if guid:
    new_combatant.id = guid
  write_data_to_json(
    new_combatant.to_json(),
    "../data/combatants/{}/{}.json".format(ctype, new_combatant.id)
  )
  add_combatant_to_record(ctype, new_combatant.id)
  return Response("ID: {}".format(new_combatant.id), status=201)

# ------------------ /
# ROUNTING FUNCTIONS
# ------------------ /

# Thanks - https://stackoverflow.com/questions/44209978/serving-a-create-react-app-with-flask
@app.route('/', defaults={'path': ''})
@app.route('/static/<path:path>')
def serve(path):
  static_path = cwd+'/'+static_folder
  if(path == ""):
    return send_from_directory(static_path, 'index.html')
  else:
    if(os.path.exists(static_path + "/" + path)):
      static_path,file = os.path.split(static_path + "/" + path)
      return send_from_directory(static_path, file)
    else:
      return send_from_directory(static_path,  'index.html')

@app.route("/spec")
def spec():
    return jsonify(swagger(app))

@app.route("/battles", endpoint='battles_no_guid', methods=['GET', 'POST'])
def battles_methods():
  if request.method == "GET":
    # TODO:  UPDATE THIS TO "../data/battles.json"
    battles = read_json_file("../data/battles.json")
    resp = Response(json.dumps(battles, indent=2), status=200, mimetype="application/json")
  elif request.method == "POST":
    teams = request.get_json()
    if teams == None:
      resp = Response("ERROR WITH POST DATA", status=400)
    else:
      # build combat
      system = CombatSystem(teams['players'], teams['enemies'])
      overview = system.play_full_combat()
      resp = Response(json.dumps(overview, indent=2), status=200, mimetype="application/json")
  else:
    resp = Response("UNSUPPORTED METHOD /battles [{}]".format(request.method), status=400)
  return resp

@app.route("/battles/<guid>", endpoint='battles_guid', methods=['GET', 'DELETE'])
def battle_methods(guid):
  resp = None
  if request.method == "GET":
    resp = get_object_response("/data/battles", guid)
  elif request.method == "DELETE":
    resp = delete_object("/data/battles.json", "battles", guid)
  else:
    resp = Response("UNSUPPORTED METHOD /battles/<id> [{}]".format(request.method), status=400)
  return resp

@app.route("/players", endpoint='players_no_guid', methods=['GET', 'POST'])
@swag_from("swagger/get_players.yml", endpoint='players_no_guid', methods=['GET'])
@swag_from("swagger/create_player.yml", endpoint='players_no_guid', methods=['POST'])
def players_methods():
  if request.method == "GET":
    players = read_json_file("../data/combatants/players.json")
    resp = Response(json.dumps(players, indent=2), status=200, mimetype="application/json")
  elif request.method == "POST":
    try:
      resp = create_combatant(request, 'players')
    except TypeError as e:
      resp = Response("ERROR WITH POST DATA: {}".format(e), status=400)
  else:
    resp = Response("UNSUPPORTED METHOD /players [{}]".format(request.method), status=400)
  return resp

@app.route("/players/<guid>", endpoint='players_guid', methods=['GET', 'PUT', 'DELETE'])
@swag_from("swagger/get_player.yml", endpoint='players_guid', methods=['GET'])
@swag_from("swagger/update_player.yml", endpoint='players_guid', methods=['PUT'])
@swag_from("swagger/delete_player.yml", endpoint='players_guid', methods=['DELETE'])
def player_methods(guid):
  if request.method == "GET":
    resp = get_object_response("../data/combatants/players", guid)
  elif request.method == "PUT":
    resp = create_combatant(request, 'players', guid=guid)
    resp.status = 204
  elif request.method == "DELETE":
    resp = delete_object("../data/combatants/players.json", 'players', guid)
  else:
    resp = Response("UNSUPPORTED METHOD /players/<id> [{}]".format(request.method), status=400)
  return resp

@app.route("/enemies", endpoint='enemies_no_guid', methods=['GET', 'POST'])
@swag_from("swagger/get_enemies.yml", endpoint='enemies_no_guid', methods=['GET'])
@swag_from("swagger/create_enemy.yml", endpoint='enemies_no_guid', methods=['POST'])
def enemies_methods():
  if request.method == "GET":
    enemies = read_json_file("../data/combatants/enemies.json")
    resp = Response(json.dumps(enemies, indent=2), status=200, mimetype="application/json")
  elif request.method == "POST":
    try:
      resp = create_combatant(request, 'enemies')
    except TypeError as e:
      resp = Response("ERROR WITH POST DATA: {}".format(e), status=400)
  else:
    resp = Response("UNSUPPORTED METHOD /enemies [{}]".format(request.method), status=400)
  return resp

@app.route("/enemies/<guid>", endpoint='enemies_guid', methods=['GET', 'PUT', 'DELETE'])
@swag_from("swagger/get_enemy.yml", endpoint='enemies_guid', methods=['GET'])
@swag_from("swagger/update_enemy.yml", endpoint='enemies_guid', methods=['PUT'])
@swag_from("swagger/delete_enemy.yml", endpoint='enemies_guid', methods=['DELETE'])
def enemy_methods(guid):
  if request.method == "GET":
    resp = get_object_response("../data/combatants/enemies", guid)
  elif request.method == "PUT":
    resp = create_combatant(request, 'enemies', guid=guid)
    resp.status = 204
  elif request.method == "DELETE":
    resp = delete_object("../data/combatants/enemies.json", 'enemies', guid)
  else:
    resp = Response("UNSUPPORTED METHOD /enemies/<id> [{}]".format(request.method), status=400)
  return resp
