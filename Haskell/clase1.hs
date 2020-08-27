import Data.Map.Strict (Map, fromList)
import System.Random
import System.IO.Unsafe

data JSONValue
  = JSONNull | JSONBool Bool | JSONNumber Double
  | JSONString String | JSONArray [JSONValue]
  | JSONObject (String, JSONValue)
  deriving (Eq, Show)
  
stringify :: JSONValue -> String
stringify (JSONObject jo) = "{" ++ fst jo ++ ":" ++ stringify (snd jo) ++ "}"
stringify (JSONArray ja) = show (map stringify ja)
stringify (JSONString js) = js
stringify (JSONNumber jn) = show jn
stringify (JSONBool jb) = show jb
stringify (JSONNull) = "null"






randomStr :: Int -> String -> IO String
randomStr 0 _ = do
	let result = ""
	return result
randomStr _ [] = do
	let result = ""
	return result
randomStr i str = do
	ix <- randomRIO (0, (length str)-1)
	xs <- randomStr (i-1) str
	let result = (str !! ix) : xs
	return result


randomStr2 :: Int -> String -> String
randomStr2 0 _ = ""
randomStr2 _ [] = ""
randomStr2 i str = randomChar : randomStr2 (i-1) str
	where
		randomChar = str !! unsafePerformIO (randomRIO (0, (length str)-1))