package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c)
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}
func nth(tab []byte, tofind byte, len int) int{
  var out0 int = 0
  for i := 0 ; i < len; i++ {
    if tab[i] == tofind {
        out0++;
      }
  }
  return out0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var len int = 0
  fmt.Fscanf(reader, "%d", &len)
  skip()
  var tofind byte = '\x00'
  fmt.Fscanf(reader, "%c", &tofind)
  skip()
  var tab []byte = make([]byte, len)
  for i := 0 ; i < len; i++ {
    var tmp byte = '\x00'
      fmt.Fscanf(reader, "%c", &tmp)
      tab[i] = tmp;
  }
  var result int = nth(tab, tofind, len)
  fmt.Printf("%d", result);
}

