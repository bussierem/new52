module Messages exposing (..)

import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Http

-- No messages, for now!
type Msg =
  OnFetchPlayers (WebData (List Player)) -- Get Player Data request
  | OnLocationChange Location -- Browser Location Changed
  | ChangeLevel Player Int -- One of the Level Change buttons pressed
  | OnPlayerSave (Result Http.Error Player) -- Save the Player updated data


{- WebData is a type that has 4 constructors:
  `NotAsked`, `Loading`, `Success`, and `Failure`
  (These are the 4 states an HTTP resources could be)
-}
