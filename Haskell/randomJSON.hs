import Data.Map.Strict (Map, fromList, (!))
import System.Random
import Data.List
import Control.Monad.Writer.Strict (Any)



data JSONValue
  = JSONNull | JSONBool Bool | JSONNumber Double
  | JSONString String | JSONArray [JSONValue]
  | JSONObject (Map String JSONValue)
  deriving (Eq, Show)
  


randomJSON :: Int -> Int -> IO JSONValue
randomJSON _ 0 = do
	let jn = JSONNull
	return jn
randomJSON 0 _ = do
	rn <- rng 3
	rjv <- randomJValue rn 0 0
	return rjv
randomJSON h w = do
	rn <- rng 5
	rjv <- randomJValue rn w h
	return rjv


randomJValue :: Int -> Int -> Int -> IO JSONValue
randomJValue 0 _ _ = do
	let jn = JSONNull
	return jn
randomJValue 1 _ _ = do
	rb <- randomBool
	return (JSONBool rb)
randomJValue 2 _ _ = do
	rn <- randomNumber
	return (JSONNumber rn)
randomJValue 3 _ _ = do
	rs <- randomString
	return (JSONString rs)
randomJValue 4 maxW maxH = do
	ra <- randomArray maxH maxW
	return (JSONArray ra)
randomJValue 5 maxW maxH = do
	ro <- randomJObject maxH maxW
	return (JSONObject ro)

randomBool :: IO Bool
randomBool = do
	rn <- rng 1
	return (rn == 1)

randomNumber :: IO Double --El rango fue elegido arbitrariamente
randomNumber = do
	rn <- rng 100
	let rf = (fromIntegral rn) / 10.0
	return rf

randomString :: IO String
randomString = do
	rn <- rng 10
	rs <- randomStr rn
	return rs

randomStr :: Int -> IO String
randomStr 0 = do
	let result = ""
	return result
randomStr i = do
	let alphabet = "abcdefghijklmnopqrstuvwxyz1234567890!$%&/=?¿+;:@#-_.,"
	rn <- rng ((length alphabet)-1)
	rest <- randomStr (i-1)
	let result = (alphabet !! rn) : rest
	return result

randomArray :: Int -> Int -> IO [JSONValue]
randomArray maxWidth maxHeight = do
	rn <- rng maxWidth
	ra <- randomArr rn maxHeight
	return ra

randomArr :: Int -> Int -> IO [JSONValue]
randomArr 0 _ = do
	let result = [JSONNull]
	return result
randomArr width 0 = do
	rn <- rng 3
	rjv <- randomJValue rn width 0
	let result = [rjv]
	return result
randomArr width height = do
	rn <- rng 5
	rjv <- randomJValue rn width (height-1)
	rest <- randomArr (width-1) (height-1)
	let result = rjv : rest
	return result

randomJObject :: Int -> Int -> IO (Map String JSONValue)
randomJObject maxWidth maxHeight = do
	rn <- rng maxWidth
	ro <- randomObj rn maxHeight
	return (fromList ro)

randomObj :: Int -> Int -> IO [(String, JSONValue)]
randomObj 0 _ = do
	let result = [("", JSONNull)]
	return result
randomObj width 0 = do
	rn <- rng 3
	rjv <- randomJValue rn width 0
	rs <- randomString
	let result = [(rs, rjv)]
	return result
randomObj width height = do
	rn <- rng 5
	rjv <- randomJValue rn width (height-1)
	rs <- randomString
	rest <- randomObj (width-1) (height-1)
	let result = (rs, rjv) : rest
	return result


rng :: Int -> IO Int
rng i = randomRIO (0, i)



