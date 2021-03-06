import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef
ifM :: IO Bool -> IO a -> IO a -> IO a
ifM c i e =
  do b <- c
     if b then i else e
writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray
readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray
array_init :: Int -> ( Int -> IO out ) -> IO (IOArray Int out)
array_init len f = newListArray (0, len - 1) =<< g 0
  where g i =
           if i == len
           then return []
           else fmap (:) (f i) <*> g (i + 1)

main :: IO ()
result len tab =
  do tab2 <- array_init len (\ i ->
                               return False)
     let a i1 =
           if i1 <= len - 1
           then do printf "%d " =<< ((readIOA tab i1)::IO Int)
                   join $ writeIOA tab2 <$> (readIOA tab i1) <*> return True
                   a (i1 + 1)
           else do printf "\n" :: IO ()
                   let b i2 =
                         if i2 <= len - 1
                         then ifM (fmap not (readIOA tab2 i2))
                                  (return i2)
                                  (b (i2 + 1))
                         else return (- 1) in
                         b 0 in
           a 0

main =
  do len <- (fmap read getLine)
     printf "%d\n" (len::Int) :: IO()
     tab <- (join (newListArray . (,) 0 . subtract 1 <$> return len <*> fmap (map read . words) getLine))
     printf "%d\n" =<< ((result len tab)::IO Int)


