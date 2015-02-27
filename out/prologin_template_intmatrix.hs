import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False
(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

main :: IO ()
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f =
  do li <- g 0
     newListArray (0, len - 1) li
  where g i =
           if i == len
           then return []
           else do item <- f i
                   li <- g (i+1)
                   return (item:li)
                                                            



programme_candidat tableau x y =
  do let out0 = 0
     let e = y - 1
     let b i h =
           if i <= e
           then do let d = x - 1
                   let c j k =
                         if j <= d
                         then do l <- (((+) k) <$> (((*) (i * 2 + j)) <$> (join $ readIOA <$> (readIOA tableau i) <*> return j)))
                                 c (j + 1) l
                         else b (i + 1) k in
                         c 0 h
           else return h in
           b 0 out0

main =
  do taille_x <- (fmap read getLine)
     taille_y <- (fmap read getLine)
     tableau <- array_init taille_y (\ a ->
                                      (join (newListArray . (,) 0 . subtract 1 <$> return taille_x <*> fmap (map read . words) getLine)))
     printf "%d" =<< (programme_candidat tableau taille_x taille_y :: IO Int)
     printf "\n" :: IO ()


