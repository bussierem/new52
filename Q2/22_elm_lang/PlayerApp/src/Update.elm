module Update exposing (..)

import Messages exposing (Msg)
import Models exposing (Model)
import Routing exposing (parseLocation)

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
