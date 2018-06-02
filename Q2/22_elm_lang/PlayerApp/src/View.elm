module View exposing (..)

import Html exposing (Html, div, text)
import Messages exposing (Msg)
import Models exposing (Model, PlayerId)
import Players.Edit
import Players.List
import RemoteData

view : Model -> Html Msg
view model =
  div []
      [ page model ]

page : Model -> Html Msg
page model =
  case model.route of
    Models.PlayersRoute -> -- Grab the entire "Player List" component as the whole app model
      Players.List.view model.players
    Models.PlayerRoute id -> -- Grab the "Edit Player" form for the given ID
      playerEditPage model id
    Models.NotFoundRoute -> -- Show a "Not Found" page
      notFoundView

playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model playerId =
  case model.players of
    RemoteData.NotAsked -> -- Not called yet
      text ""
    RemoteData.Loading -> -- Loading data
      text "Loading..."
    RemoteData.Failure err -> -- Whoops!
      text (toString err)
    RemoteData.Success players -> -- Show player edit page if it was found
      let -- Filter the list of players into maybePlayer...
        maybePlayer =
          players
            -- Filter the list to only match on ID
            |> List.filter (\player -> player.id == playerId)
            -- Grab the first item in the list (same as `maybePlayer = ary[0]`)
            |> List.head
      in -- ...and do something with it!
        case maybePlayer of
          Just player -> -- Player found
            Players.Edit.view player
          Nothing -> -- ID doesn't match any record
            notFoundView

notFoundView : Html msg -- use LOWERCASE "msg" when you don't have a concrete type you need to care about
notFoundView = div [] [ text "Not Found!" ]
