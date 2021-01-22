import Queue 
main = do
    let colavacia = dequeue (enqueue 1 empty)
    let cola1 = enqueue 10 (enqueue 5 empty)
    let cola2 = enqueue 5 (enqueue 10 empty)
    putStrLn ("colavacia " ++ show colavacia)
    putStrLn ("cola1 " ++ show cola1)
    putStrLn ("cola2 " ++ show cola2)
    putStrLn ("¿cola1 == cola2?")
    let bool = (enqueue 10 (enqueue 5 empty)) == (enqueue 5 (enqueue 10 empty))