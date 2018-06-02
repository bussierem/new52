module Players.List exposing (..)
-- This Module is similar to a "React Component", and gets pulled into View.elm similarly
import Html exposing (..)
import Html.Attributes exposing (class, href)
import Messages exposing (Msg)
import Models exposing (Player)
import RemoteData exposing (WebData)
import Routing exposing (playerPath)

view : WebData (List Player) -> Html Msg
view response =
  {- This div contains:
    - a "nav" object (defined below)
    - a "maybeList", which will either be a list of players, or some text element with a message
  -}
  div []
      [ nav
      , maybeList response
      ]

nav : Html Msg
nav =
  {- This "nav" div contains:
    - an inner div
    - the title text "Players"
  -}
  div [ class "clearfix mb2 white bg-black" ]
      [ div [ class "left p2" ] [ text "Players" ] ]

-- This is probably a "list" component, but also could be some text, based on the RemoteData response type:
maybeList : WebData (List Player) -> Html Msg
maybeList response =
  case response of
    RemoteData.NotAsked ->
      text ""
    RemoteData.Loading ->
      text "Loading..."
    RemoteData.Failure err ->
      text (toString err)
    RemoteData.Success players ->
      list players

list : List Player -> Html Msg
list players =
  -- This "list" div contains a table containing the player data
  div [ class "p2" ]
      [ table []
        [ thead []
          [ tr []
            -- Assign table headers for each column
            [ th [] [ text "Id"  ]
            , th [] [ text "Name" ]
            , th [] [ text "Level" ]
            , th [] [ text "Actions" ]
            ] -- End <tr>
          ] -- End <thead>
          {- The <tbody> will contain
            a list of players, called using the "playerRow" function (defined below)
            and assigned using the "List.map" function
          -}
        , tbody [] (List.map playerRow players)
        ] -- End <table>
      ]

playerRow : Player -> Html Msg
playerRow player =
  {- Each "player row" contains:
    - columns for ID, Name, Level, and an empty "Actions" column (for now)
  -}
  tr []
     [ td [] [ text player.id ]
     , td [] [ text player.name ]
     , td [] [ text (toString player.level) ]
     , td [] [ editBtn player ]
     ]

editBtn : Player -> Html.Html Msg
editBtn player =
  let
    path = playerPath player.id
  in
    a [ class "brn regular"
      , href path
      ]
      [ i [ class "fa fa-pencil mr1" ] []
      , text "Edit"
      ]
