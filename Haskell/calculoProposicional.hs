import Data.Map.Strict (Map, fromList, (!))
import Data.List
import Control.Monad.Writer.Strict (Any)

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
asigns p = map fromList (auxAsigns (propVars p) [])

auxAsigns :: [String] -> [(String, Bool)] -> [[(String, Bool)]]
auxAsigns [] lista = [lista]
auxAsigns (v:vs) lista = auxAsigns vs evalFalse ++ auxAsigns vs evalTrue where
	evalFalse = (v, False) : lista
	evalTrue = (v, True) : lista

tautology :: Prop -> Bool
tautology p = auxTautology p (asigns p)

auxTautology :: Prop -> [VarAsign] -> Bool
auxTautology p (va:[]) = eval p va
auxTautology p (va:vas) = if (not (eval p va)) then False else auxTautology p vas