module Main exposing (..)

-- utils
import Html exposing (program)
import Navigation exposing (Location)
import Routing
-- internal modules
import Commands exposing (fetchPlayers)
import Messages exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)

-- INIT
init : Location -> ( Model, Cmd Msg )
init location =
  let
    currentRoute =
      Routing.parseLocation location
  in
    ( initialModel currentRoute, fetchPlayers )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- MAIN
main : Program Never Model Msg
main =
  Navigation.program Messages.OnLocationChange
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
