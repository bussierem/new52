module Update exposing (..)

import Messages exposing (Msg)
import Models exposing (Model)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  -- Nothing to do, for now!
  case msg of
    Messages.OnFetchPlayers response ->
      -- When we get an "OnFetchPlayers" message, we store the response in "players"
      ( { model | players = response }, Cmd.none )
