module Unions exposing (..)

{-
This will allow a type called "Answer" that has valid values of
  Yes
  No
  Some other string
-}
type Answer = Yes | No | Other String
-- This can be used to narrow allowed values for a variable:
respond : Answer -> String
respond answer =
  case answer of
    Yes ->
      "Okay!"
    No ->
      "But why..."
    _ ->
      "You said" ++ answer
respond Yes
respond No
respond (Other "Hello World")

{-
Common Unions Types:
BOOL:
  `type Bool = True | False`
"Maybe" (possibility of something or nothing):
  `type Maybe x = Nothing | Just x`  (Just is a function:   `Just : a -> Maybe a`)
"Result" (possibility of a return value or an error of type "Err"):
  `type Result error value = Okay value | Err error`
-}
