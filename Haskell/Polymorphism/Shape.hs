module Shape where

type Side = Float
type Apothem = Float
type Radius = Float

data Shape = Pentagon Apothem Side | Circle Radius deriving (Eq, Show)

perimeter :: Shape -> Float
perimeter (Pentagon a s) = 5 * s 
perimeter (Circle r) = 2 * pi * r 

area :: Shape -> Float 
area (Pentagon apothem side) = (perimeter (Pentagon apothem side)) * apothem / 2
area (Circle r) = pi * r * r