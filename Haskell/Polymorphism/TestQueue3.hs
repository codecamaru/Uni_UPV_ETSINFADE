import Queue2 
main = do
    putStrLn ("Cola vacía")
    putStrLn (show (dequeue (enqueue 1 empty)))
    let cola1 = enqueue 5 (enqueue 4 (enqueue 3 (enqueue 2 (enqueue 1 empty)))) 
    let cola2 = enqueue 1 (enqueue 2 (enqueue 3 (enqueue 4 (enqueue 5 empty)))) 
    putStrLn ("cola1")
    putStrLn (show (cola1))
    putStrLn ("cola2")
    putStrLn (show (cola2))
    putStrLn ("prueba toList: "  ++ show (toList cola1))
    putStrLn ("prueba toList: "  ++ show (toList cola2))