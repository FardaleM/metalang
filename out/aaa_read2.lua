
function readintline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), "-?%d+") do
    tab[i] = tonumber(a)
    i = i + 1
  end
  return tab
end
function readcharline()
   local tab = {}
   local i = 0
   for a in string.gmatch(io.read("*l"), ".") do
    tab[i] = string.byte(a)
    i = i + 1
   end
   return tab
end
--[[
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
--]]

local len = tonumber(io.read('*l'))
io.write(string.format("%d=len\n", len))
local tab = readintline()
for i = 0,len - 1 do
  io.write(string.format("%d=>%d ", i, tab[i]))
end
io.write("\n")
local tab2 = readintline()
for i_ = 0,len - 1 do
  io.write(string.format("%d==>%d ", i_, tab2[i_]))
end
local strlen = tonumber(io.read('*l'))
io.write(string.format("%d=strlen\n", strlen))
local tab4 = readcharline()
for i3 = 0,strlen - 1 do
  local tmpc = tab4[i3]
  local c = tmpc
  io.write(string.format("%c:%d ", tmpc, c))
  if tmpc ~= 32
  then
    c = math.mod((c - 97) + 13, 26) + 97;
  end
  tab4[i3] = c;
end
for j = 0,strlen - 1 do
  io.write(string.format("%c", tab4[j]))
end
