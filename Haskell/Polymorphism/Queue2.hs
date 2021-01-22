module Queue2 where 
data Queue a = Queue [a] [a]

empty = Queue [] []
enqueue x (Queue xs ys) = Queue xs (x:ys)
dequeue (Queue (x:xs) ys) = Queue xs ys
dequeue (Queue [] ys) = dequeue (Queue (reverse ys) [])
first (Queue (x:xs) ys) = x
first (Queue [] ys) = head (reverse ys)
isEmpty (Queue [] []) = True
isEmpty _ = False
size (Queue a b) = length a + length b

toList :: (Queue a) -> [a]
toList (Queue [] []) = []
toList (Queue [] b) = toList (Queue (reverse b) [])
toList (Queue (x:xs) b) = x:toList (Queue xs b)

fromList :: [a] -> (Queue a)
fromList [] = empty
fromList (xs) = fromList2 (reverse xs)
fromList2 [] = empty
fromList2 (x:xs) = enqueue x (fromList2 xs)

instance (Show a) => Show (Queue a) where
    show (Queue [] []) = " <- "
    show (Queue [] ys) = show (Queue (reverse ys) [])
    show (Queue (x:xs) b) = " <- " ++ show x ++ show (Queue xs b)

