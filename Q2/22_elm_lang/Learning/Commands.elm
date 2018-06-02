module Main exposing (..)
import Html exposing (Html, div, button, text, program)
import Html.Events exposing (onClick)
import Random

-- MODEL
type alias Model = Int
int : ( Model, Cmd Msg )
init =
  ( 1, Cmd.none )

-- MESSAGES
-- The possible messages are either a Roll attempt, or getting a number back from Random
type Msg = Roll | OnResult Int

-- VIEW
view : Model -> Html Msg
view model =
  div []
      [ button [ onClick Roll ] [ text "Roll" ]
      , text (toString model)
      ]

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Roll ->
      -- Random.generate creates a Command
      -- The first param needs to be a constructor that returns the Message type (OnResult, in this case)
      ( model, Random.generate OnResult (Random.int 1 6) )
    -- In this case, grab the random int from the OnResult call
    OnResult res ->
      ( res, Cmd.none )

-- MAIN
main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = (always Sub.none)
    }
