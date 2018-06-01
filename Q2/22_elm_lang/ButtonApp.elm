module ButtonApp exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)


-- MODEL
-- The model only needs to tell if the widget is expanded or collapsed
type alias Model =
  Bool

init : ( Model, Cmd Msg )
init =
  ( False, Cmd.none )

-- MESSAGES
-- States of the widget
type Msg
  = Expand
  | Collapse

-- VIEW
view : Model -> Html Msg
view model =
  if model then
    -- We will display a div containing both a "Collapse" button, and the text element (SHOWN)
    -- The div expects options, and then some content inside the div
    div []
      -- buttons expect options and some text for the button
      -- In this case, the "options" is an onclick definition which passes the Msg type
      [ button [ onClick Collapse ] [ text "Collapse" ]
      , text "Widget"
      ]
  else
    -- We will display a div with just an "Expand" button, no text element
    div []
      [ button [ onClick Expand ] [ text "Expand" ] ]

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  -- This passes back the desired STATE
  case msg of
    Expand ->
      -- Pass back that the widget is showing
      ( True, Cmd.none )
    Collapse ->
      -- Pass back that the widget is NOT showing
      ( False, Cmd.none )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- MAIN
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


{- APPLICATION FLOW:
1. Html.program calls our view function with the initial model and renders it.
2. When the user clicks on the Expand button, the view triggers the Expand message.
3. Html.program receives the Expand message which calls our update function with Expand and the current application state.
4. The update function responds to the message by returning the updated state and a command to run (or Cmd.none).
5. Html.program receives the updated state, stores it, and calls the view with the updated state.displa
-}
