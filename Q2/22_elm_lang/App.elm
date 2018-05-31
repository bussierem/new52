module App exposing (..)
import Html exposing (Html, text, div, program)

-- MODEL
type alias Model = String

{-
 Init looks for an Html.program object, which expects:
    model:  some model for the program
    command: an initial command to be run
-}
init : ( Model, Cmd Msg )
-- We will pass it just the string "Hello" for our entire model, and no starting command
init =
  ( "Hello", Cmd.none )

-- MESSAGES
-- These are things that happen in our app - show/hide widgets, etc
-- Since we have none, we simply have a NoOp message:
type Msg = NoOp
-- If we had some, we would use Type Unions:
--  `type Msg = Expand | Collapse` for show/hide widgets, for example

-- VIEW
-- This function renders an Html element using the application model
view : Model -> Html Msg
view model =
  div [] [ text model ]

-- UPDATE
-- this function is called each time some message is received
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  -- You would have numerous cases here for the various Msg types
  case msg of
    NoOp ->
      -- Each case returns a new model, just like the init function
      ( model, Cmd.none )

-- SUBSCRIPTIONS
-- These are used to listen for external input to our app:
--  mouse movements, keyboard events, browser location changes, etc
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- MAIN
-- Wire everything together and start the message event loop:
main : Program Never Model Msg
main =
  program {
    init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
