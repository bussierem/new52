module Commands exposing (..)

import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Messages exposing (Msg)
import Models exposing (PlayerId, Player)
import RemoteData

fetchPlayers : Cmd Msg
fetchPlayers =
  -- Takes a url and a "decoder" (both defined below)
  -- Returns a "Request" type
  Http.get fetchPlayersUrl playersDecoder
    -- Wrap the resulting "Request" object in a WebData type
    -- Returns a "Cmd" to send the request
    |> RemoteData.sendRequest
    -- Map the command from RemoteData to our custom "OnFetchPlayers" message type
    |> Cmd.map Messages.OnFetchPlayers

-- Define the static URL to grab the list from above
fetchPlayersUrl : String
fetchPlayersUrl =
  "http://localhost:4000/players"

-- Define the static url to save a Player's data
savePlayerUrl : PlayerId -> String
savePlayerUrl playerId =
  "http://localhost:4000/players/" ++ playerId

-- Takes a list of Players and delegates decoding each in turn to a "playerDecoder" (defined below)
playersDecoder : Decode.Decoder (List Player)
playersDecoder =
  Decode.list playerDecoder

-- Creates a single JSON decoder that returns a full Player JSON record
playerDecoder : Decode.Decoder Player
playerDecoder =
  decode Player
    -- We can define if a property in that record is required:
    |> required "id" Decode.string
    |> required "name" Decode.string
    |> required "level" Decode.int

-- Request to save a Player's data after an update
savePlayerRequest : Player -> Http.Request Player
savePlayerRequest player =
  Http.request
    { body = playerEncoder player |> Http.jsonBody
    , expect = Http.expectJson playerDecoder
    , headers = []
    , method = "PATCH"
    , timeout = Nothing
    , url = savePlayerUrl player.id
    , withCredentials = False
    }

-- Command to save Player's data after an update
savePlayerCmd : Player -> Cmd Msg
savePlayerCmd player =
  savePlayerRequest player
    |> Http.send Messages.OnPlayerSave

-- Encode Player object into a sendable JSON record
playerEncoder : Player -> Encode.Value
playerEncoder player =
  let
    attributes =
      [ ( "id", Encode.string player.id )
      , ( "name", Encode.string player.name )
      , ( "level", Encode.int player.level )
      ]
  in
    Encode.object attributes
