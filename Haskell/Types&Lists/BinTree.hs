module BinTree where

data BinTreeInt = Void | Node Int BinTreeInt BinTreeInt deriving Show

insTree :: Int -> BinTreeInt -> BinTreeInt
insTree n Void = Node n Void Void
insTree n (Node x a b) 
        | n <= x = Node x (insTree n a) b 
        | otherwise = Node x a (insTree n b)

creaTree :: [Int] -> BinTreeInt
creaTree [x] = Node x Void Void
creaTree (x:y:xs) 
     | x <= y = Node x Void (creaTree (y:xs))
     | otherwise = Node x (creaTree (y:xs)) Void

treeElem :: Int -> BinTreeInt -> Bool
treeElem x (Void) = False
treeElem x (Node y a b)
    | x == y = True
    | x <= y = treeElem x a
    | otherwise = treeElem x b     