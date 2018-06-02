module Update exposing (..)

import Messages exposing (Msg)
import Models exposing (Model, Player)
import Commands exposing (savePlayerCmd)
import Routing exposing (parseLocation)
import RemoteData

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  -- Nothing to do, for now!
  case msg of
    Messages.OnFetchPlayers response ->
      -- When we get an "OnFetchPlayers" message, we store the response in "players"
      ( { model | players = response }, Cmd.none )
    Messages.OnLocationChange location ->
      let -- Define the new route, grabbed from the Parse call...
        newRoute = parseLocation location
      in -- ...and toss it into the model!
        ( { model | route = newRoute }, Cmd.none )
    Messages.ChangeLevel player change ->
      let
        updatedPlayer =
          { player | level = player.level + change }
      in
        ( model, savePlayerCmd updatedPlayer )
    Messages.OnPlayerSave (Ok player) ->
      ( updatePlayer model player, Cmd.none )
    Messages.OnPlayerSave (Err error) ->
      ( model, Cmd.none )

updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
  let
    pick currentPlayer =
      if updatedPlayer.id == currentPlayer.id then
        updatedPlayer
      else
        currentPlayer
    updatePlayerList players = List.map pick players
    updatedPlayers = RemoteData.map updatePlayerList model.players
  in
    { model | players = updatedPlayers }
