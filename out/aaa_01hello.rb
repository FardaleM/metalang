require "scanf.rb"
print "Hello World"
a = 5
printf "%d \n%dfoo", (4 + 6) * 2, a
b = 1 + (((1 + 1) * 2 * (3 + 8)).to_f / 4).to_i - (1 - 2) - 3 == 12 && true
if b then
  print "True"
else
  print "False"
end
print "\n"
c = (3 * (4 + 5 + 6) * 2 == 45) == false
if c then
  print "True"
else
  print "False"
end
printf "%d%d", ((((4 + 1).to_f / 3).to_i).to_f / (2 + 1)).to_i, ((((4 * 1).to_f / 3).to_i).to_f / (2 * 1)).to_i
d = not(not(a == 0) && not(a == 4))
if d then
  print "True"
else
  print "False"
end
e = true && not(false) && not(true && false)
if e then
  print "True"
else
  print "False"
end
print "\n"

