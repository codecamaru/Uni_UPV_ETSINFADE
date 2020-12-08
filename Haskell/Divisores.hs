module Divisores where
    divisores n = [i | i <- [1..n], n `mod`i == 0]