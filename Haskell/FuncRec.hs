module FuncRec where
    addRange :: Int -> Int -> Int 
    addRange a b 
            | a == b = b
            | a < b = a + addRange (a+1) b
            | b < a = b + addRange a (b+1)