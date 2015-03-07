

function trunc(x)
  return x>=0 and math.floor(x) or math.ceil(x)
end

buffer =  ""
function readint()
    if buffer == "" then buffer = io.read("*line") end
    local num, buffer0 = string.match(buffer, '^([\-0-9]*)(.*)')
    buffer = buffer0
    return tonumber(num)
end

function readchar()
    if buffer == "" then buffer = io.read("*line") end
    local c = string.byte(buffer)
    buffer = string.sub(buffer, 2, -1)
    return c
end

function stdinsep()
    if buffer == "" then buffer = io.read("*line") end
    if buffer ~= nil then buffer = string.gsub(buffer, '^%s*', "") end
end



function foo(  )
  local a = 0
  --[[ test --]]
  a = a + 1;
  --[[ test 2 --]]
end

function foo2(  )
  
end

function foo3(  )
  if 1 == 1
  then
    
  end
end

function sumdiv( n )
  --[[ On désire renvoyer la somme des diviseurs --]]
  local out0 = 0
  --[[ On déclare un entier qui contiendra la somme --]]
  for i = 1,n do
  --[[ La boucle : i est le diviseur potentiel--]]
    if (math.mod(n, i)) == 0
    then
      --[[ Si i divise --]]
      out0 = out0 + i;
      --[[ On incrémente --]]
    else
      --[[ nop --]]
    end
    end
    return out0
    --[[On renvoie out--]]
  end
  
  
  --[[ Programme principal --]]
  local n = 0
  n = readint()
  --[[ Lecture de l'entier --]]
  io.write(sumdiv(n))
  