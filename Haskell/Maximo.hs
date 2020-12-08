module Maximo where
    max' :: Int -> Int -> Int
    max' a b 
        | a > b = a
        | otherwise = b

    max'' :: Int -> Int -> Int
    max'' a b = if (a > b) then a else b 