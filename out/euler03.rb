require "scanf.rb"
def mod(x, y)
  return x - y * (x.to_f / y).to_i
end

maximum = 1
b0 = 2
a = 408464633
while a != 1 do
  b = b0
  found = false
  while b * b < a do
    if (mod(a, b)) == 0 then
      a /= b
      b0 = b;
      b = a;
      found = true;
    end
    b += 1
  end
  if not(found) then
    printf "%d\n", a
    a = 1;
  end
end

