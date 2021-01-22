module LibDB where

type Person = String
type Book = String
type Database = [(Person, Book)]

exampleBase :: Database
exampleBase = [("Alicia", "El nombre de la rosa"), 
               ("Juan", "La hija del canibal"), 
               ("Pepe", "Odesa"), 
               ("Alicia", "La ciudad de las bestias"),("Alicia","Odesa")]

obtain :: Database -> Person -> [Book]
obtain dB p = [ book | (person,book) <-dB, person == p]

borrow :: Database -> Book -> Person -> Database
borrow dB libro persona = dB ++ [(persona, libro)]


return' ::Database -> (Person, Book) -> Database
return' dB (a,b) = [(c,d) | (c,d) <-dB, c /= a || d /= b]
