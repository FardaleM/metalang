

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



function max2_( a, b )
  if a > b
  then
    return a
  else
    return b
  end
end

--[[

(a + b * 10 + c * 100) * (d + e * 10 + f * 100) =
a * d + a * e * 10 + a * f * 100 +
10 * (b * d + b * e * 10 + b * f * 100)+
100 * (c * d + c * e * 10 + c * f * 100) =

a * d       + a * e * 10   + a * f * 100 +
b * d * 10  + b * e * 100  + b * f * 1000 +
c * d * 100 + c * e * 1000 + c * f * 10000 =

a * d +
10 * ( a * e + b * d) +
100 * (a * f + b * e + c * d) +
(c * e + b * f) * 1000 +
c * f * 10000

--]]
function chiffre( c, m )
  if c == 0
  then
    return math.mod(m, 10)
  else
    return chiffre(c - 1, trunc(m / 10))
  end
end


local m = 1
for a = 0,9 do
for f = 1,9 do
for d = 0,9 do
for c = 1,9 do
for b = 0,9 do
for e = 0,9 do
local mul = a * d + 10 * (a * e + b * d) + 100 * (a * f + b * e + c * d) + 1000 * (c *
                                                                                e +
                                                                                b *
                                                                                f) + 10000 * c * f
  if chiffre(0, mul) == chiffre(5, mul) and chiffre(1, mul) == chiffre(4,
  mul) and chiffre(2, mul) == chiffre(3, mul)
  then
    m = max2_(mul, m);
  end
  end
  end
  end
  end
  end
  end
  io.write(string.format("%d\n", m))
  