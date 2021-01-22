import qualified Circle
import qualified Triangle

main = do
    putStrLn ("The Circle's area is " ++ show (Circle.area 2))
    putStrLn ("The Triangle's area is " ++ show (Triangle.area 4 5))