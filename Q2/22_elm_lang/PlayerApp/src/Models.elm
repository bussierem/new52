module Models exposing (..)

import RemoteData exposing (WebData)

type Route =
  PlayersRoute
  | PlayerRoute PlayerId
  | NotFoundRoute

type alias Model =
  { players : WebData (List Player) -- list of "Player" objects (defined below) from the WebData request response
  , route : Route -- The current route
  }

initialModel : Route -> Model
initialModel route =
  { players = RemoteData.Loading -- indication that the data is still Loading
  , route = route -- the current route
  }
  -- OLD CODE --
  {- This is the "dummy data" for players
  { players = [ Player "1" "Sam" 1
              , Player "2" "Max" 4
              ]
  }
  -}

-- Rename the ID for readability
type alias PlayerId = String

-- The "Player" object
type alias Player =
  { id : PlayerId
  , name : String
  , level : Int
  }
