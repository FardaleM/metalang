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

func programme_candidat(tableau []byte, taille int) int{
  var out0 int = 0
  for i := 0 ; i <= taille - 1; i++ {
    out0 += (int)(tableau[i]) * i;
      fmt.Printf("%c", tableau[i]);
  }
  fmt.Printf("--\n");
  return out0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  var b int
  fmt.Fscanf(reader, "%d", &b)
  skip()
  var taille int = b
  var tableau []byte = make([]byte, taille)
  for e := 0 ; e <= taille - 1; e++ {
    fmt.Fscanf(reader, "%c", &tableau[e])
  }
  skip()
  fmt.Printf("%d\n", programme_candidat(tableau, taille));
}

