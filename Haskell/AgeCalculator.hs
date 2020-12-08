module AgeCalculator where
    agecalculator :: (Int, Int, Int) -> (Int, Int, Int ) -> String
    -- first tupla is your birthday and second one is the current date
    agecalculator (a,b,c) (d,e,f) 
                    | e < b = "Tu edad es: " ++(show ((f - c) - 1))
                    | d < a = "Tu edad es: " ++(show ((f - c) - 1))
                    | otherwise = "Tu edad es: " ++(show (f - c))