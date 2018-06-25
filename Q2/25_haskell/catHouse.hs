import qualified Data.List as L

-- Cat Stuff
data CatBreed =
    Siamese | Persian | Bengal | Sphynx
  | Burmese | Birman | RussianBlue
  | NorwegianForest | CornishRex | MaineCoon

type Name = String
type Age = Integer
-- Defines the value constructor as `Cat :: Name -> CatBreed -> Age -> Cat`
data Cat = Cat Name CatBreed Age

-- House Stuff
type HouseNumber = Int
data House = House HouseNumber Cat

-- Functions
humanAge :: Cat -> Age
humanAge (Cat _ _ catAge)
  | catAge <= 0 = 0
  | catAge == 1 = 15
  | catAge == 2 = 25
  | otherwise   = 25 + (catAge - 2) * 4

street :: [House]
street =
  [ House 1 (Cat "George" Siamese 10)
  , House 2 (Cat "Mr Bigglesworth" Persian 5)
  , House 3 (Cat "Mr Tinkles" Birman 1)
  , House 4 (Cat "Puddy" Burmese 3)
  , House 5 (Cat "Tiger" Bengal 7)
  , House 6 (Cat "The Ninja" RussianBlue 12)
  , House 7 (Cat "Mr Tinklestein" NorwegianForest 8)
  , House 8 (Cat "Plain Cat" MaineCoon 9)
  , House 9 (Cat "Shnooby" Sphynx 7)
  , House 10 (Cat "Crazy Ears Sam" CornishRex 3)
  ]

getCatFromHouse :: House -> Cat
getCatFromHouse (House _ kitty) = kitty

getHumanAgeOfHouseCat :: House -> Integer
-- Function Composition!
getHumanAgeOfHouseCat = humanAge . getCatFromHouse
-- Same as:  `getHumanAgeOfHouseCat h = humanAge (getCatFromHouse h)`

-- Predicate function for later
catAgeComparator :: House -> House -> Ordering
catAgeComparator (House _ (Cat _ _ age1))
                 (House _ (Cat _ _ age2))
  = compare age2 age1

-- First large function
findOldestCat :: [House] -> Maybe Cat
findOldestCat [] = Nothing
findOldestCat houses = Just oldestCat
  where -- NOTE: Work from the bottom up of this!
    -- Return the oldest cat
    oldestCat = getCatFromHouse houseWithOldestCat
    -- Grab the first item in the sorted list
    houseWithOldestCat = head housesSortedByCatAge
    -- Sort using predicate
    housesSortedByCatAge = L.sortBy catAgeComparator houses

-- Form of other function
findOldestCatHouse :: [House] -> Maybe House
findOldestCatHouse houses =
    if length housesSortedByCatAge > 0
    then Just (head housesSortedByCatAge)
    else Nothing
  where housesSortedByCatAge = L.sortBy catAgeComparator houses

getCatName :: Cat -> String
getCatName (Cat name _ _) = name

getHouseNumber :: House -> String
getHouseNumber (House number _) = show number

main :: IO ()
main = putStrLn oldest
  where
    oldest = case findOldestCatHouse street of
      Nothing -> "There is no oldest cat!"
      Just house ->
        "The oldest cat is "
        ++ getCatName (getCatFromHouse house)
        ++ " and it is "
        ++ show (getHumanAgeOfHouseCat house)
        ++ " human years old, and lives at #"
        ++ getHouseNumber house
