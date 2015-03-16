object euler31
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
def read_char() : Char = {
  if (buffer != null && buffer == "") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}

  def result(sum : Int, t : Array[Int], maxIndex : Int, cache : Array[Array[Int]]): Int = {
    var i: Int=0;
    if (cache(sum)(maxIndex) != 0)
      return cache(sum)(maxIndex);
    else if (sum == 0 || maxIndex == 0)
      return 1;
    else
    {
      var out0: Int = 0;
      var div: Int = sum / t(maxIndex);
      for (i <- 0 to div)
        out0 = out0 + result(sum - i * t(maxIndex), t, maxIndex - 1, cache);
      cache(sum)(maxIndex) = out0;
      return out0;
    }
  }
  
  
  def main(args : Array[String])
  {
    var t :Array[Int] = new Array[Int](8);
    for (i <- 0 to 8 - 1)
      t(i) = 0;
    t(0) = 1;
    t(1) = 2;
    t(2) = 5;
    t(3) = 10;
    t(4) = 20;
    t(5) = 50;
    t(6) = 100;
    t(7) = 200;
    var cache :Array[Array[Int]] = new Array[Array[Int]](201);
    for (j <- 0 to 201 - 1)
    {
      var o :Array[Int] = new Array[Int](8);
      for (k <- 0 to 8 - 1)
        o(k) = 0;
      cache(j) = o;
    }
    printf("%d", result(200, t, 7, cache));
  }
  
}

