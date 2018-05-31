module TypeAlias exposing (..)

-- Type aliases can be used to "name" a type:
type alias PlayerId = Int
type alias PlayerName = String
-- This is useful for defining more readable functions:
getPlayerName : Int -> String
-- becomes:
getPlayerName : PlayerId -> PlayerName

-- "Records" are similar to Python dictionaries, or JS objects:
{ id: Int
, name: String
}
-- These can be used in functions, if rather verbose:
label : { id: Int, name: String } -> String
-- Type aliases can help with this:
type alias Player =
  { id: Int
  , name: String
  }
label : Player -> String
-- The above can also be used as a "constructor function":
max = Player 1 "Max"
lyra = Player 2 "Lyra" 
