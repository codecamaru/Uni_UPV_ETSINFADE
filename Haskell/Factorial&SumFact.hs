module Factorial where
    fact :: Int -> Int
    fact 0 = 1
    fact n = n * fact (n - 1)

    sumFacts :: Int -> Int 
    sumFacts 1 = 1
    sumFacts n = fact n + sumFacts (n - 1)