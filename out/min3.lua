function min2_( a, b )
  if a < b
  then
    return a
  else
    return b
  end
end


io.write(string.format("%d %d %d %d %d %d\n", min2_(min2_(2, 3), 4), min2_(min2_(2, 4), 3), min2_(min2_(3, 2), 4), min2_(min2_(3, 4), 2), min2_(min2_(4, 2), 3), min2_(min2_(4, 3), 2)))
