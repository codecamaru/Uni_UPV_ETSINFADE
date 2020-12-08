module LowerToGreater where
    lowertogreater :: Int -> Int -> String
    lowertogreater a b
                    | a < b = (show a)++ " -> " ++(show b)
                    | b < a = (show b)++ " -> " ++(show a)