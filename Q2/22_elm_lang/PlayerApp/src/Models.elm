module Models exposing (..)

import RemoteData exposing (WebData)

type alias Model =
  -- The model is just a list of "Player" objects (defined below)
  -- This data now comes from the WebData request response
  { players : WebData (List Player)
  }

initialModel : Model
initialModel =
  -- The initial data will simply be an indication that the data is still Loading:
  { players = RemoteData.Loading
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
