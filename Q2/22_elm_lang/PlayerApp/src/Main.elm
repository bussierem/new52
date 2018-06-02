module Main exposing (..)

import Html exposing (program)
import Commands exposing (fetchPlayers)
import Messages exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)

-- INIT
init : ( Model, Cmd Msg )
init =
  -- Pull in the initial "Loading" model, then call fetchPlayers() immediately on start
  ( initialModel, fetchPlayers )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- MAIN
main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
