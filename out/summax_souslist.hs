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


skip_whitespaces :: IO ()
skip_whitespaces =
  ifM (hIsEOF stdin)
      (return ())
      (do c <- hLookAhead stdin
          if c == ' ' || c == '\n' || c == '\t' || c == '\r' then
           do hGetChar stdin
              skip_whitespaces
           else return ())
read_int_a :: Int -> IO Int
read_int_a b =
  ifM (hIsEOF stdin)
      (return b)
      (do c <- hLookAhead stdin
          if c >= '0' && c <= '9' then
           do hGetChar stdin
              read_int_a (b * 10 + ord c - 48)
           else return b)

read_int :: IO Int
read_int =
   do c <- hLookAhead stdin
      sign <- if c == '-'
                 then fmap (\x -> -1::Int) $ hGetChar stdin
                 else return 1
      num <- read_int_a 0
      return (num * sign)
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


summax lst len =
  do let current = 0
     let max0 = 0
     let b = len - 1
     let a i g h =
           if i <= b
           then do j <- (((+) g) <$> (readIOA lst i))
                   let k = if j < 0
                           then let l = 0
                                        in l
                           else j
                   if h < k
                   then do let m = k
                           a (i + 1) k m
                   else a (i + 1) k h
           else return h in
           a 0 current max0

main =
  do let len = 0
     f <- read_int
     let n = f
     skip_whitespaces
     tab <- array_init n (\ i ->
                           do let tmp = 0
                              e <- read_int
                              let o = e
                              skip_whitespaces
                              return o)
     result <- summax tab n
     printf "%d" (result :: Int) :: IO ()


