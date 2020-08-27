import Data.Map.Strict (Map, fromList, (!))
import System.Random
import Data.List
import Control.Monad.Writer.Strict (Any)



data JSONValue
  = JSONNull | JSONBool Bool | JSONNumber Double
  | JSONString String | JSONArray [JSONValue]
  | JSONObject (Map String JSONValue)
  deriving (Eq, Show)
  


--randomJSON :: Int -> Int -> IO JSONValue
--randomJSON h w = if (w == 0) then do 
--	let result = JSONNull
--	return result
--	else do
--		ix <- randomRIO (0, 5)
--		let gen = getStdGen
--		let value = randomJValue ix gen
--		return


--randomJValue :: Int -> g -> JSONValue
--randomJValue 0 g = JSONNull
--randomJValue 1 g = JSONBool randomBool g
--randomJValue 2 g = JSONNumber randomNumber
--randomJValue 3 g = JSONString randomString
--randomJValue 4 g = JSONArray randomArray
--randomJValue 5 g = JSONObject randomObject

--randomBool :: RandomGen g => g -> Bool
--randomBool g = (fst (randomR (0, 1) g)) == 1




data Prop = TruthValue Bool | PropVar String
  | OpNOT Prop | OpAND Prop Prop | OpOR Prop Prop 
  | OpCond Prop Prop | OpBicond Prop Prop 
  deriving (Eq, Show)

type VarAsign = Map String Bool
emptyAsign :: Map Any a
emptyAsign = fromList []

eval :: Prop -> VarAsign -> Bool
eval (TruthValue b) _ = b 
eval (PropVar x) a = a ! x
eval (OpNOT p) a = not (eval p a) 
eval (OpAND p1 p2) a = (eval p1 a) && (eval p2 a)
eval (OpOR p1 p2) a = (eval p1 a) || (eval p2 a)
eval (OpBicond p1 p2) a = (eval p1 a) == (eval p2 a)
eval (OpCond p1 p2) a = not (eval p1 a) || (eval p2 a)

propVars :: Prop -> [String]
propVars (TruthValue b) = [] 
propVars (PropVar x) = [x]
propVars (OpNOT p) = propVars p
propVars (OpAND p1 p2)  = nub ((propVars p1) ++ (propVars p2))
propVars (OpOR p1 p2)  = nub ((propVars p1) ++ (propVars p2))
propVars (OpBicond p1 p2)  = nub ((propVars p1) ++ (propVars p2))
propVars (OpCond p1 p2)  = nub ((propVars p1) ++ (propVars p2))

asigns :: Prop -> [VarAsign]
asigns p = 