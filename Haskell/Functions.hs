module Functions where
    -- 1
    elimDups :: [Int] -> [Int]
    elimDups [] = []
    elimDups [x] = [x]
    elimDups (x:y:ys) 
                    | x == ys = elimDups (y:ys)
                    | otherwise = x : elimDups (y:ys)

    -- 2 
    any :: (a -> Bool) -> [a] -> Bool
    any p xs = or ([ p x | x <- xs ])

    all :: (a -> Bool) -> [a] -> Bool
    all p xs = and ([ p x | x <- xs ])


    ordenada :: [Int] -> Bool
    ordenada [] = True
    ordenada [x] = True
    ordenada (x:y:ys) -- x <= y && ordenada (y:ys)
                    | x <= y = sorted (y:ys)
                    | otherwise = False

    sorted xs = and [x <= y | (x,y) <- zip (init xs) (tail xs)]
    
    copias :: Int -> [Int]
    copias 0 x = x
    copias n x = x : copias (n-1) x

    position :: a -> [a] -> Int
    position a xs = head [y | (x,y) <- zip xs [1..length xs], a == x]

    