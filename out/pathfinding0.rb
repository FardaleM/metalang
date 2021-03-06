require "scanf.rb"
def pathfind_aux( cache, tab, x, y, posX, posY )
  if posX == x - 1 && posY == y - 1 then
      return 0
  elsif posX < 0 || posY < 0 || posX >= x || posY >= y then
      return x * y * 10
  elsif tab[posY][posX] == "#" then
      return x * y * 10
  elsif cache[posY][posX] != -1 then
      return cache[posY][posX]
  else 
      cache[posY][posX] = x * y * 10
      val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY)
      val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY)
      val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1)
      val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1)
      out0 = 1 + [val1, val2, val3, val4].min
      cache[posY][posX] = out0
      return out0
  end
end
def pathfind( tab, x, y )
  cache = [*0..y-1].map { |i|
    
    tmp = [*0..x-1].map { |j|
      
      printf "%c", tab[i][j]
      next -1
      }
    print "\n"
    next tmp
    }
  return pathfind_aux(cache, tab, x, y, 0, 0)
end
x = STDIN.readline.to_i(10)
y = STDIN.readline.to_i(10)
printf "%d %d\n", x, y
e = [*0..y-1].map { |f|
  
  next STDIN.readline.split(//)
  }
tab = e
result = pathfind(tab, x, y)
printf "%d", result
