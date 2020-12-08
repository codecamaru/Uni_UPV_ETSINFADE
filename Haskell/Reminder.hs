module Reminder where
    reminder :: Int -> Int -> Int
    reminder a b 
            | b == 0 = -1
            | a < b = a
            | otherwise = reminder (a-b) b