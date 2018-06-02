module Commands exposing (..)

import Http
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
