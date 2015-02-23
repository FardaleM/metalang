import Text.Printf
import Control.Applicative
import Control.Monad
import Data.Array.MArray
import Data.Array.IO
import Data.Char
import System.IO
import Data.IORef


writeIOA :: IOArray Int a -> Int -> a -> IO ()
writeIOA = writeArray

readIOA :: IOArray Int a -> Int -> IO a
readIOA = readArray

(<&&>) a b =
	do aa <- a
	   if aa then b
		 else return False

(<||>) a b =
	do aa <- a
	   if aa then return True
		 else b


main :: IO ()

ifM :: IO Bool -> IO a -> IO a -> IO a
ifM cond if_ els_ =
  do b <- cond
     if b then if_ else els_

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


array_init_withenv :: Int -> ( Int -> env -> IO(env, tabcontent)) -> env -> IO(env, IOArray Int tabcontent)
array_init_withenv len f env =
  do (env, li) <- g 0 env
     o <- newListArray (0, len - 1) li
     return (env, o)
  where g i env =
           if i == len
           then return (env, [])
           else do (env', item) <- f i env
                   (env'', li) <- g (i+1) env'
                   return (env'', item:li)



result sum t maxIndex cache =
  ifM (((/=) <$> join (readIOA <$> (readIOA cache sum) <*> return (maxIndex)) <*> return (0)))
      (join (readIOA <$> (readIOA cache sum) <*> return (maxIndex)))
      ((if ((sum == 0) || (maxIndex == 0))
       then return (1)
       else do let out0 = 0
               div <- ((quot sum) <$> (readIOA t maxIndex))
               let a i h =
                     (if (i <= div)
                     then do l <- (((+) h) <$> (join (result <$> (((-) sum) <$> (((*) i) <$> (readIOA t maxIndex))) <*> (return t) <*> (return (maxIndex - 1)) <*> (return cache))))
                             (a (i + 1) l)
                     else do join (writeIOA <$> (readIOA cache sum) <*> return (maxIndex) <*> return (h))
                             return (h)) in
                     (a 0 out0)))
main =
  ((\ (c, t) ->
     do return (c)
        writeIOA t 0 1
        writeIOA t 1 2
        writeIOA t 2 5
        writeIOA t 3 10
        writeIOA t 4 20
        writeIOA t 5 50
        writeIOA t 6 100
        writeIOA t 7 200
        ((\ (e, cache) ->
           do return (e)
              printf "%d" =<< ((result 200 t 7 cache) :: IO Int)) =<< (array_init_withenv 201 (\ j () ->
                                                                                                ((\ (g, o) ->
                                                                                                   do return (g)
                                                                                                      let d = o
                                                                                                      return (((), d))) =<< (array_init_withenv 8 (\ k () ->
                                                                                                                                                    let f = 0
                                                                                                                                                            in return (((), f))) ()))) ()))) =<< (array_init_withenv 8 (\ i () ->
                                                                                                                                                                                                                         let b = 0
                                                                                                                                                                                                                                 in return (((), b))) ()))

