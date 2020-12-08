module Leapyear where
    leapyear :: Int -> Bool
    leapyear n 
            | mod n 400 == 0 = True 
            | mod n 100 == 0 = False
            | mod n 4 == 0 = True

    daysAmonth :: Int -> Int -> Int
    daysAmonth a b 
            | (a == 2) && leapyear b = 29
            | (a == 2) && (leapyear b == False) = 28
            | mod a 2 == 0 = 30
            | otherwise = 31