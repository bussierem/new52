import qualified Data.List as L

type Name = String
type Year = Int
-- "Records"!
data Person = Person
    { firstName :: Name
    , lastName  :: Name
    , birthYear :: Year
    }
  deriving (Show)

-- Basic dataset
people :: [Person]
people =
  [ Person "Isaac" "Newton" 1643
  , Person "Leonard" "Euler" 1707
  , Person "Blaise" "Pascal" 1623
  , Person "Ada" "Lovelace" 1815
  , Person "Alan" "Turing" 1912
  , Person "Haskell" "Curry" 1900
  , Person "John" "von Neumann" 1903
  , Person "Lipot" "Fejer" 1880
  , Person "Grace" "Hopper" 1906
  , Person "Anita" "Borg" 1949
  , Person "Karen" "Sparck Jones" 1935
  , Person "Henriette" "Avram" 1919 ]

firstAfter1900 :: Maybe Person
-- for `yearOfBirth person` - this is a "getter" for a Record property
firstAfter1900 = L.find (\person -> birthYear person >= 1900) people

firstLetterIs :: Char -> String -> Bool
firstLetterIs char ""    = False
-- Check if first letter in the second param is == first param Char
firstLetterIs char (x:_) = char == x

firstNameStartsWith :: Char -> Person -> Bool
firstNameStartsWith char person =
  firstLetterIs char (firstName person)

listLPeople :: [Person] -> [Person]
-- the second param of `firstNameStartsWith` is not needed due to it being passed to filter
-- This is called a "partially applied function"!
listLPeople people = filter (firstNameStartsWith 'L') people

lastNames :: [String]
lastNames = map lastName people

sortedLastNames :: Bool -> [String]
sortedLastNames revOrder
  -- `flip` takes a function with 2+ params and reverses the order of the params
  | revOrder = L.sortBy (flip compare) lastNames
  | otherwise = L.sort lastNames

firstNames :: [String]
firstNames = map firstName people

sortedFirstNames :: Bool -> [String]
sortedFirstNames revOrder
  | revOrder = L.sortBy (flip compare) firstNames
  | otherwise = L.sort firstNames

ageAtYear :: Year -> Person -> Int
ageAtYear year person = year - birthYear person

allAgesIn2018 :: [Int]
allAgesIn2018 = map (ageAtYear 2018) people

oldestBirthYear :: [Person] -> Year
oldestBirthYear people = minimum $ L.map birthYear people

bornFirst :: [Person] -> Person
bornFirst people =
    L.minimumBy compareBirthYears people
  where compareBirthYears x y =
          compare (birthYear x) (birthYear y)

main :: IO ()
main = putStrLn (L.intercalate "\n" (sortedLastNames True))
