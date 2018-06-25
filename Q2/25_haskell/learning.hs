import Data.Time.Clock.POSIX
import qualified Data.List as L

m::String
m = "Polly wants a cracker"

-- Anonymous function
-- (\x -> True) False
-- (\_ -> True) False   `since we didn't need the variable, we can use '_'`

-- Pattern Matching for function declarations
not' :: Bool -> Bool
not' True = False
not' False = True

-- Takes 2 arguments, adds them
plus :: Int -> Int -> Int
plus x y = x + y

-- Same as above but with lambdas
plus' :: Int -> Int -> Int
plus' = \x -> \y -> x + y

-- Adds 1 by utilizing the above
increment :: Int -> Int
increment x = plus x 1

-- Same as before, but using the lambda def of plus'
increment' :: Int -> Int
increment' = (\x -> \y -> x + y) 1

-- Static utilization of plus
addition :: Int
addition = plus 100 25

-- Control statements
msg :: String -> String
msg name = if name /= "Dave"
          then if name == "Max"
            then "Hey Max!"
            else "You're not Dave OR Max..."
          else "Hello Dave..."

msgCase :: String -> String
msgCase name =
  case name of
    "Dave" -> "Hello Dave..."
    "Max"  -> "Hey Max!"
    _      -> "You're not Dave OR Max..."

-- Use Pattern Matching to define "logical OR"
eitherOR :: Bool -> Bool -> Bool
eitherOR False False = False
eitherOR _ _ = True

-- Use Pattern Matching to define "logical XOR"
eitherXOR :: Bool -> Bool -> Bool
eitherXOR False True = True
eitherXOR True False = True
eitherXOR _ _ = False

-- Use a nested function call to check
msgNest :: String -> String
msgNest name = if (eitherOR (name == "Max") (name == "Dave"))
              then "Hello Sir..."
              else "You're not Dave OR Max!"

-- Use a Guard Pattern to implement
-- Guard Pattern checks each statement for True, using the first it finds
-- This is important for functions where the various tests are on different things!
-- `otherwise` keyword matches to `True`
msgGuard :: String -> String
msgGuard name      -- NOTE: NO '=' IS USED HERE!
  | name == "Dave" = "Hello Dave..."
  | name == "Max"  = "Hey Max!"
  | otherwise      = "You're not Dave OR Max!"  -- NOTE: We could also just use `| True` here, same thing

-- ===================== --

-- LISTS
theList = []

-- Adding to a list:
-- 1: (:) is an INFIX function that takes an element and then a list, and prepends the element to the list:
anotherList = "sauce" : []  -- Could also do PREFIX as `anotherList = (:) "sauce" []`
-- 2: Direct assignment:
thirdList = ["pie"]  -- thirsList is of type `thirdList = [String]` OR `thirdList = [] String`

-- Multiple items
multiList = [1, 2]
multiList2 :: Num a => [a] -- Here we say we want it to constrain to only Num subtypes
multiList2 = 1 : 2 : []
finalList =
  [ "Carrots"
  , "Beans"
  , "Jell-O"
  , "Lactaid Milk"
  , "Chocolate"
  ]

-- Pattern Matching using `:`
firstOrEmpty :: [String] -> String
firstOrEmpty [] = ""   -- If the list is empty, send back nothing
firstOrEmpty (x:_) = x -- If the list has at least 1 item, assign the FIRST one to `x` and return `x`

twoOrEmpty :: [String] -> String
twoOrEmpty [] = ""
twoOrEmpty [x] = ""
twoOrEmpty (x:y:_) = x ++ ", " ++ y -- Advanced Pattern Matching for first 2 items in list

-- Recursive function calling!
-- NOTE:  This is already declared more generally by `intercalate` in Data.List using any separator!
joinWithComma :: [String] -> String
joinWithComma []       = ""
joinWithComma [x]      = x
joinWithComma (x:rest) = x ++ ", " ++ joinWithComma rest

-- ================= --

-- PREDICATES

movies =
  [ "Aeon Flux"
  , "The Black Cat"
  , "Superman"
  , "Stick It"
  , "The Matrix Revolutions"
  , "The Raven"
  , "Inception"
  , "Looper"
  , "Hoodwinked"
  , "Tell-Tale"
  ]

isGood :: String -> Bool
isGood (x:_) = x <= 'M'
isGood _     = False

assess :: String -> String
assess movie = movie ++ " - " ++ assessment
  where assessment = if isGood movie
                     then "Good"
                     else "Bad"

assessMovies :: [String] -> [String]
assessMovies = map assess

assessedMovies :: [String]
assessedMovies = assessMovies movies

-- ================= --

-- TUPLES

shoppingListItem :: (String, Int)
shoppingListItem = ("Bananas", 2)

-- Type Aliases
type Name = String
type Amount = Int
type GroceryItem = (Name, Amount)
type GroceryList = [GroceryItem]

shoppingList :: GroceryList
shoppingList = [ ("Bananas", 10)
               , ("Apples", 5)
               , ("Milk", 1)
               , ("Bread", 3)
               ]

sumShoppingList :: GroceryList -> Amount
sumShoppingList [] = 0
sumShoppingList (x:rest) = getAmount x + sumShoppingList rest

getAmount :: GroceryItem -> Amount
getAmount (_, amount) = amount

-- ================== --

-- DATA/SUM/PRODUCT TYPES

data Animal = Giraffe
            | Elephant
            | Tiger
            | Cockatoo

-- Product Types:
type Name = String
type Age = Integer
-- This declares a product type called "ZooResident"
-- Then says it has a single constructor that takes the 3 parameters
data ZooResident = ZooResident Name Age Animal

main :: IO ()
-- the "show" function takes any "showable" Type and returns it as a String
--   `main = putStrLn (show addition)`
-- Much easier:  the "print" function is basically `putStrLn (show x)`!
--   `main = print addition`
main = putStrLn ("The total items on the shopping list is "
                ++ show (sumShoppingList shoppingList)
                ++ " items")
