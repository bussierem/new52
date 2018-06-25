

main :: IO ()
main = do
  putStrLn "You are in a fridge.  What do you want to do?"
  putStrLn "1. Try to escape"
  putStrLn "2. Eat"
  putStrLn "3. Die"
  -- NOTE: You can ONLY use <- INSIDE A `do` BLOCK!!
  command <- getLine
  case command of
    "1" -> putStrLn "You try to get out. You fail. You die."
    "2" -> do
      putStrLn "You eat. You eat some more."
      putStrLn "Damn, this food is tasty!"
      putStrLn "You eat so much you die."
    "3" -> putStrLn "You die."
    _   -> putStrLn "You scramble about pointlessly until you die."
  putStrLn "Play again? (y/n)"
  playAgain <- getLine
  if playAgain == "y"
  then main
  else putStrLn "Thanks for playing"
