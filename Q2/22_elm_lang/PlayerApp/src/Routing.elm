module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import UrlParser exposing (..)

matchers : Parser (Route -> a) a
matchers =
  oneOf
    -- Order defined is important - order defines priority over later definitions!
    [ map PlayersRoute top -- Match top route to PlayersRoute
    , map PlayerRoute (s "players" </> string) -- Match /player/<id> to PlayerRoute
    , map PlayersRoute (s "players") -- Match /players to PlayersRoute
    ]

-- Every time the browser location changes, Navigation library will trigger a message with a "Location" record
-- We will call the following from our main `update` using that record:
parseLocation : Location -> Route
parseLocation location =
  -- call the UrlParser.parseHash, returning a Just (containing the route) or a Nothing
  case (parseHash matchers location) of
    Just route ->
      route
    Nothing ->
      NotFoundRoute

playersPath : String
playersPath =
  "#players"

playerPath : PlayerId -> String
playerPath id = "#players/" ++ id
