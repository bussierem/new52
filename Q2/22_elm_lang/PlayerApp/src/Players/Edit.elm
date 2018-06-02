module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Messages exposing (Msg)
import Models exposing (Player)
import Routing exposing (playersPath)

view : Player -> Html Msg
view model =
  {- div contains:
    - empty nav component (defined below)
    - the player edit form (defined below)
  -}
  div []
      [ nav model
      , form model
      ]

nav : Player -> Html Msg
nav model =
  -- Div contains nothing for now
  div [ class "clearfix mb2 white bg-black p1" ]
      [ listBtn ]

form : Player -> Html Msg
form player =
  {- div contains:
    - H1 tag containing player name
    - Player Level edit form
  -}
  div [ class "m3" ]
      [ h1 [] [ text player.name ]
      , formLevel player
      ]

formLevel : Player -> Html Msg
formLevel player =
  {- div contains:
    - "Level" label
    - div containing:
      - H2 tag containing current Player Level
      - "Decrease Level" button
      - "Increase Level" button
  -}
  div [ class "clearfix py1" ]
      [ div [ class "col col-5" ] [ text "Level" ]
      , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
      ]

-- "Decrease Level" button component
btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
  let
    message = Messages.ChangeLevel player -1
  in
    a [ class "btn ml1 h1"
      , onClick message
      ]
      [ i [ class "fa fa-minus-circle" ] [ text "-"] ]

-- "Increase Level" button component
btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
  let
    message = Messages.ChangeLevel player 1
  in
    a [ class "btn ml1 h1"
      , onClick message
      ]
      [ i [ class "fa fa-plus-circle" ] [ text "+" ] ]

listBtn : Html Msg
listBtn =
  a [ class "btn regular"
      , href playersPath
      ]
      [ i [ class "fa fa-chevron-left mr1" ] []
      , text "List"
      ]
