module ShapeTypes where

type Side = Float
type Apothem = Float
type Radius = Float
type Height = Float
type Volume = Float
type Surface = Float

data Pentagon = Pentagon Side Apothem
data Circle = Circle Radius 

class (Eq a, Show a) => Shape a where
    perimeter :: a -> Float
    area :: a -> Float
    volumePrism :: a -> Height -> Volume
    surfacePrism :: a -> Height -> Surface 

    volumePrism baseFigure height = (area baseFigure) * height 
    surfacePrism baseFigure height = ((area baseFigure) * 2) + ((perimeter baseFigure) * height)
    
instance Shape Pentagon where
    perimeter (Pentagon s a) = 5 * s 
    area (Pentagon s a) = (perimeter (Pentagon a s)) * a / 2

instance Shape Circle where
    perimeter (Circle r) = 2 * pi * r 
    area (Circle r) = pi * r * r

instance Eq Pentagon where
    (Pentagon a b) == (Pentagon c d) = a==c && b==d

instance Eq Circle where
    (Circle a) == (Circle b) = a==b

instance Show Pentagon where
    show (Pentagon s a) = "Pentagon: side " ++ (show s) ++ ", apothem " ++ (show a)

instance Show Circle where
    show (Circle r) = "Circle: radius " ++ (show r)