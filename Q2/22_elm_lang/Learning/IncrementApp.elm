module IncrementApp exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)


-- MODEL
type alias Model = Int
-- The model is now a "counter" Int
init : ( Model, Cmd Msg )
init =
  ( 0, Cmd.none )

-- MESSAGES
type Msg = Increment Int

-- VIEW
view : Model -> Html Msg
view model =
  div []
    -- Clicking the button will increment the counter by 2
    [ button [ onClick (Increment 2) ] [ text "+" ]
    , text (toString model)
    ]

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    -- Pattern match the message to a function prototype, grab the variable using a generic
    Increment howMuch ->
      -- Pass back the model, now incremented by the interval passed from the Button Click
      ( model + howMuch, Cmd.none )

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
