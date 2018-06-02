-- Create the module for this file, exposing everything using ".."
module Hello exposing (..)
-- Import the HTML module, specifying functions to bring in
import Html exposing (text)

{- Front-end Elm apps start with a "main" function,
  returning an element to draw on the page -}
main =
  text "Hello"
  -- "text" returns a text element containing the string passed into it
