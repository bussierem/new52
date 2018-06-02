module Messages exposing (..)

import Models exposing (Player)
import RemoteData exposing (WebData)

-- No messages, for now!
type Msg =
  OnFetchPlayers (WebData (List Player))
  {- WebData is a type that has 4 constructors:
    `NotAsked`, `Loading`, `Success`, and `Failure`
    (These are the 4 states an HTTP resources could be)
  -}
