import qualified Data.List as L

data Animal = Giraffe
            | Elephant
            | Tiger
            | Cockatoo

type Zoo = [Animal]

localZoo :: Zoo
localZoo = [ Elephant
           , Tiger
           , Giraffe
           , Tiger
           , Cockatoo
           , Cockatoo
           , Cockatoo
           , Elephant
           ]

adviceOnEscape :: Animal -> String
adviceOnEscape animal =
  case animal of
    Giraffe  -> "Look up"
    Elephant -> "Ear to the ground"
    Tiger    -> "Check the morgue!"
    Cockatoo -> "Grab a cracker"

adviceOnZooEscape :: Zoo -> [String]
-- The usual way:
-- adviceOnZooEscape [] = ""
-- adviceOnZooEscape (x:rest) =
--   adviceOnEscape x : adviceOnEscape rest
-- Using Map (params: {<predicate>, <list>}):
adviceOnZooEscape zoo = map adviceOnEscape zoo

-- The final program!
main :: IO ()
main = putStrLn outputString
  where
    outputString = L.intercalate ", " advices
    advices = adviceOnZooEscape localZoo
