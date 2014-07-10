#include <iostream>
#include <vector>
std::vector<char> getline(){
  if (std::cin.flags() & std::ios_base::skipws){
    std::cin.ignore();
    std::cin.unsetf(std::ios::skipws);
  }
  std::string line;
  std::getline(std::cin, line);
  std::vector<char> c(line.begin(), line.end());
  return c;
}
int read_int(){
  int out_ = 0;
  std::cin >> out_ >> std::skipws;
  return out_;
}

std::vector<char > read_char_line(int n){
  return getline();
}

int programme_candidat(std::vector<char >& tableau, int taille){
  int out_ = 0;
  for (int i = 0 ; i < taille; i++)
  {
    out_ += tableau.at(i) * i;
    std::cout << tableau.at(i);
  }
  std::cout << "--\n";
  return out_;
}


int main(){
  int b = 0;
  std::cin >> b >> std::skipws;
  int a = b;
  int taille = a;
  std::vector<char > c = getline();
  std::vector<char > tableau = c;
  std::cout << programme_candidat(tableau, taille) << "\n";
  return 0;
}

