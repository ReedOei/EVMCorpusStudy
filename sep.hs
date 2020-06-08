import System.Environment (getArgs)

sepLine = "-----------------------------------------------"

splitNotes = map (\(a,b) -> (a, reverse b)) . splitNotes' "" []
    where
        splitNotes' contractName cur [] = [(contractName, cur)]
        splitNotes' contractName cur [a] = [(contractName, a:cur)]
        splitNotes' contractName cur [a,b] = [(contractName, b:a:cur)]
        splitNotes' contractName cur (top:contract:bot:rest)
            | top == sepLine && bot == sepLine = (contractName, cur) : splitNotes' contract [] rest
            | otherwise = splitNotes' contractName (top:cur) $ contract:bot:rest

main = do
    [fname] <- getArgs
    ls <- splitNotes . lines <$> readFile fname
    mapM_ (\(cName, body) -> writeFile ("out/" ++ cName ++ ".obs") (unlines body)) ls

