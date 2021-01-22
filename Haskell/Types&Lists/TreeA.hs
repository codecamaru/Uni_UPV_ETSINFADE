module TreeA where 

data Tree a = Leaf a | Branch (Tree a) (Tree a) deriving Show
data BinTreeInt = Void | Node Int BinTreeInt BinTreeInt 

numleaves :: Tree a -> Int
numleaves (Leaf x) = 1
numleaves (Branch y z) = numleaves y + numleaves z

symmetric :: Tree a -> Tree a
symmetric (Leaf n) = (Leaf n)
symmetric (Branch a b) = Branch (symmetric b) (symmetric a)

listToTree :: [a] -> Tree a
listToTree [x] = Leaf x
listToTree (x:xs) = (Branch (listToTree [x]) (listToTree xs)) 

treeToList :: Tree a -> [a]
treeToList (Leaf x) = [x]
treeToList (Branch a b) = (treeToList a) ++ (treeToList b)