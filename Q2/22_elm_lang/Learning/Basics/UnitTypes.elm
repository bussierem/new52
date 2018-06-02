module UnitTypes exposing (..)

-- If you had a type alias:
type alias Msg content =
  { code: String
  , body: content
  }
-- and a function that expects a String body:
readMessage : Message String -> String
-- what happens if you want that function to not have expect a body?
readMessage : Message () -> String
-- The (), AKA the "Unit Type", acts as an empty value

-- Example:  The "Task" function:
-- `Task error result`
-- Sometimes we want everything:
Task (Err "Blah") "Done"
-- Sometimes we don't care about the error:
Task () "Done"
-- Sometimes we don't need the result:
Task (Err "Blah") ()
-- Sometimes we don't need any of it, just the Task object:
Task () ()
