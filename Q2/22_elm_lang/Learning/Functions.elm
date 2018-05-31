module Functions exposing (..)

-- Anonymous functions:   \<params> -> <expression>
-- Example:  Anonymous function that adds 1 to the parameter
\x -> x + 1
-- Example:  Anonymous function that adds two params together
\x y -> x + y

{- Named functions:
-- <name> : <params> -> <return>
-- <name> <params> = <expression>
-}
-- Example:  Function that adds one to a param
addOne : Int -> Int
addOne x =
  x + 1
-- Calling function:
addOne 5
{--}
-- Example:  Multiply two params
multiply : Int -> Int -> Int
multiply x y =
  x * y
{--}
-- Example:  Function that adds two params together
addParams : Int -> Int -> Int
addParams x y =
  x + y
-- Calling function:
addParams 5 10
{--}
-- Functions in Elm take just 1 parameter; multi-param functions can grab intermediaries:
-- The following call returns an anonymous function  ` \x -> x + 5 `
add5 = addParams 5
-- you can then apply this function later:
add5 10
-- The above all is what happens behind the scenes when you call `addParams 5 10`
{--}
-- You can nest function calls using parens:
addParams 5 (multiply 2 5)
-- You can use the "pipe" operator to make this more readable:
2
  |> multiply 5
  |> add 5
-- This reads as "take 2, multiply 5, then add 5 to the result"

-- Type Variables & Generics
-- This takes in a string, and a list of strings, and returns found index OR -1:
-- `indexOf : String -> List String -> Int`
-- The above won't work with a list of ints though, so we can make it generic:
indexOf : item -> List item -> Int
