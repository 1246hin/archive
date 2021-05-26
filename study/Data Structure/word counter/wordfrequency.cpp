#include "wordfrequency.h"
#include "map.h"

#include <iostream>
#include <sstream>
#include <fstream>
#include <string>
#include <algorithm>

using namespace std;
/** 
  * Assignment 3 for COSE213 Data Structures
  *
  * Won-Ki Jeong (wkjeong@korea.ac.kr)
  *
  * 2021. 5. 9
  *
  */



WordFrequency::WordFrequency()
{
}

WordFrequency::~WordFrequency()
{
}


void WordFrequency::ReadText(const char* filename)
{

	ifstream inFile;
	inFile.open(filename);
	stringstream strStream;
	strStream << inFile.rdbuf();
	string str = strStream.str();
	istringstream iss(str);
	do
	{	
		string word;
		string tmp="";
		iss>>word;
		transform(word.begin(), word.end(), word.begin(), ::tolower);
    		for (int i = 0; i < word.size(); ++i) {
        		if ((word[i] >= 'a' && word[i] <= 'z')) {
            			tmp = tmp + word[i];
        		}
    		}
    		word = tmp;
		if (map.find(word)==NULL)
		{
			map.insert(word, 1);
		}
		else
		{
			map.find(word)->val=map.find(word)->val+1;	
		}

	} while(iss);
}

int WordFrequency::GetFrequency(const std::string word)
{	
	if(map.find(word)!=NULL){return map.find(word)->val;}
	else{return 0;}	
}

void WordFrequency::IncreaseFrequency(const std::string word)
{
	
	if(map.find(word)==NULL) {map.insert(word, 1);}
	else {map.find(word)->val=map.find(word)->val+1;}
}