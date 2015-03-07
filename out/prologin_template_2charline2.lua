
function readcharline()
  local tab = {}
  local i = 0
  for a in string.gmatch(io.read("*l"), ".") do
    tab[i] = string.byte(a)
    i = i + 1
  end
  return tab
end
function programme_candidat( tableau1, taille1, tableau2, taille2 )
  local out0 = 0
  for i = 0,taille1 - 1 do
    out0 = out0 + tableau1[i] * i;
    io.write(string.format("%c", tableau1[i]))
  end
  io.write("--\n")
  for j = 0,taille2 - 1 do
    out0 = out0 + tableau2[j] * j * 100;
    io.write(string.format("%c", tableau2[j]))
  end
  io.write("--\n")
  return out0
end


local taille1 = tonumber(io.read('*l'))
local taille2 = tonumber(io.read('*l'))
local tableau1 = readcharline()
local tableau2 = readcharline()
io.write(string.format("%d\n", programme_candidat(tableau1, taille1, tableau2, taille2)))
