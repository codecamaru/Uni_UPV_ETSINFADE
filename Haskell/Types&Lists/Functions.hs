module Functions where

decBin :: Int -> [Int]
decBin 0 = [0]
decBin 1 = [1]
decBin n = (n `mod` 2) : decBin (n `div`2 )

binDec :: [Int] -> Int
binDec (x:[]) = x
binDec (x:y) = x + binDec y * 2

funLength :: [Int] -> Int
funLength [] = 0
funLength (x:xs) = 1 + funLength xs

divisors :: Int -> [Int]
divisors x = [ n | n <-[1..x] , (mod x n) == 0]

funMap :: (a->b) -> [a] -> [b]
funMap f [] = []
funMap f (x:xs) = (f x) : funMap f xs

member :: Int -> [Int] -> Bool
member n [] = False
member n (x:xs) = n == x || member n xs

member2 :: Int -> [Int] -> Bool
member2 n [] = False
member2 n (x:xs) = if (n == x) then True else member2 n xs 

isPrime :: Int -> Bool
isPrime n = length (divisors n) == 2 || length (divisors n) == 1

primes :: Int -> [Int]
primes n = take n [x | x <-[1..], isPrime x]

selectEven :: [Int] -> [Int]
selectEven (x:xs) = [x | x <- (x:xs), mod x 2 == 0]

selectEvenPos :: [Int] -> [Int]
selectEvenPos [] = []
selectEvenPos xs = [ xs !! i | i <- [0..length xs], mod i 2 == 0 ]

selectEvenPos2 :: [Int] -> [Int]
selectEvenPos2 xs = map (xs !!) [0,2..length xs -1]

ins :: Int -> [Int] -> [Int]
ins n [] = [n]
ins n (x:xs) 
    | n < x = n : x:xs
    | otherwise = x:ins n xs

iSort :: [Int] -> [Int]
iSort [] = []
iSort (x:xs) = ins x (iSort xs)

doubleAll :: [Int] -> [Int]
doubleAll xs = map (*2) xs

map' :: (a -> b) -> [a] -> [b]
map' f xs = [f x | x <-xs]

filter' :: (a -> Bool) -> [a] -> [a]
filter' p xs = [ x | x <-xs, p x ]