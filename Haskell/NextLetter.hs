module NextLetter where
    import Data.Char
    siglet :: Char -> Char 
    siglet a 
        | (ord a) == 122 || (ord a) == 90 = chr ((ord a) - 25) 
        | otherwise = chr ((ord a) + 1)