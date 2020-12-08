module NumCbetw2 where
    import Data.Char
    numbetw2 :: Char -> Char -> Int
    numbetw2 a b = if (a == b) then 0 else (abs ((ord a) - (ord b))) - 1 