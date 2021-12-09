module Main where
import Data.Char (digitToInt)
import Data.List (transpose)

main :: IO ()
main = do
    input <- map (map digitToInt) . lines <$> readFile "../input.txt"
    let lowPoints = [(r, c) | r <- [0..(length input - 1)], c <- [0..(length (head input) - 1)], ltAll r c input]
    print $ sum [input !! fst lp !! snd lp + 1 | lp <- lowPoints]

ltAll :: Int -> Int -> [[Int]] -> Bool
ltAll r c m = ltLeft r c m && ltRight r c m && ltUp r c m && ltDown r c m

ltLeft :: Int -> Int -> [[Int]] -> Bool
ltLeft r c matrix
    | (c-1) < 0 = True
    | otherwise = matrix !! r !! c < matrix !! r !! (c-1)

ltRight :: Int -> Int -> [[Int]] -> Bool
ltRight r c matrix
    | c+2 > length (matrix !! r) = True
    | otherwise = matrix !! r !! c < matrix !! r !! (c+1)

ltUp :: Int -> Int -> [[Int]] -> Bool
ltUp r c matrix
    | (r-1) < 0 = True
    | otherwise = matrix !! r !! c < matrix !! (r-1) !! c

ltDown :: Int -> Int -> [[Int]] -> Bool
ltDown r c matrix
    | r+2 > length matrix = True
    | otherwise = matrix !! r !! c < matrix !! (r+1) !! c