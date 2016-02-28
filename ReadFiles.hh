#ifndef ReadFiles_h
#define ReadFiles_h

#include <sstream>
#include <fstream>
#include <vector>
#include <string>
#include <cstdlib>

std::vector<int> readInts(char ** fileName){
  
  std::ifstream inFile(fileName);
  std::vector<int> numbers;
  std::string line;
  if(inFile.is_open()){
    while(getline(inFile,line)){
      numbers.push_back(atoi(line));
    }
  }
  return numbers;
}

std::vector< std::string > readStrings(char ** fileName){
 
  std::ifstream inFile(filename);
  std::vector< std::string > strings;
  std::string line;
  if(inFile.is_open()){
    while(getline(inFile,line)){
      numbers.push_back(line);
    }
  }
  return strings;
}

#endif
