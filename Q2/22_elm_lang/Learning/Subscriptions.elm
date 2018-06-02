module Subscriptions exposing (..)
import Html exposing (Html, div, text, program)
import Mouse
import Keyboard

-- MODEL
type alias Model = Int
init : (Model, Cmd Msg)
init =
  ( 0, Cmd.none )

-- MESSAGES
type Msg =
  MouseMsg Mouse.Position |
  KeyMsg Keyboard.KeyCode

-- VIEW
view : Model -> Html Msg
view model =
  div [] [ text (toString model) ]

-- UPDATE
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    -- anytime you click the mouse, increment the counter by 1
    MouseMsg position ->
      ( model + 1, Cmd.none )
    -- anytime you press a key, increment the counter by 2
    KeyMsg code ->
      ( model + 2, Cmd.none )

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  -- Declare what we want to listen for
  Sub.batch -- "batch" takes a list of subscriptions and packages them into a single subscription
    [ Mouse.clicks MouseMsg -- Listen for mouse clicks only
    , Keyboard.downs KeyMsg -- Listen for "key down" events - holding the button will spam this!
    ]

-- MAIN
main : Program Never Model Msg
main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
