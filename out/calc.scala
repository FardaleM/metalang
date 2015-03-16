object calc
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

  /*
La suite de fibonaci
*/
  def fibo(a : Int, b : Int, i : Int): Int = {
    var j: Int=0;
    var out_U: Int = 0;
    var a2: Int = a;
    var b2: Int = b;
    for (j <- 0 to i + 1)
    {
      printf("%d", j);
      out_U = out_U + a2;
      var tmp: Int = b2;
      b2 = b2 + a2;
      a2 = tmp;
    }
    return out_U;
  }
  
  
  def main(args : Array[String])
  {
    printf("%d", fibo(1, 2, 4));
  }
  
}

