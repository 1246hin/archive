/** 
  * Assignment 4 for COSE213 Data Structures
  *
  * Won-Ki Jeong (wkjeong@korea.ac.kr)
  *
  * 2021. 6. 1
  *
  */
#include "SearchTree.h"  
#include "LinkedBinaryTree.h"

#include "AVLTree.h"

#include <cstdlib>
#include <iostream>
#include <ctime>
#include <time.h>       /* clock_t, clock, CLOCKS_PER_SEC */

#include <iostream>
 
using namespace std;

int main()
{
	typedef Entry<int, float> EntryType;
	SearchTree<EntryType> st1;
	AVLTree<EntryType> avl1;
	//
	// SearchTree random test nElem=100
	//
	std::cout << "SearchTree random test nElem=100" << std::endl;

	int nElem = 100;
	int *key1 = new int[nElem*2];
	float *val1 = new float[nElem*2];
	std::srand(std::time(0)); // use current time as seed for random generator
	for(int i=0; i<nElem*2; i++)
	{
		key1[i] = std::rand();
		val1[i] = (float) std::rand()/RAND_MAX * 20000;
	}
	clock_t tm;
	
	// (a)
	std::cout << "(a)" << std::endl;

    	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		st1.insert(key1[i], val1[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (b)
	std::cout << "(b)" << std::endl;

	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		st1.find(key1[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (c)
	std::cout << "(c)" << std::endl;

	// ratio 20:80
	std::cout << "ratio 20:80" << std::endl;

	tm = clock();
	bool T;
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<20;
		if (T==true) {st1.find(key1[i]);}
		else {st1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 40:60
	std::cout << "ratio 40:60" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<40;
		if (T==true) {st1.find(key1[i]);}
		else {st1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 50:50
	std::cout << "ratio 50:50" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<50;
		if (T==true) {st1.find(key1[i]);}
		else {st1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 60:40
	std::cout << "ratio 60:40" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<60;
		if (T==true) {st1.find(key1[i]);}
		else {st1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 80:20
	std::cout << "ratio 80:20" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<80;
		if (T==true) {st1.find(key1[i]);}
		else {st1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);



	std::cout << "------------" << std::endl;



	//
	// AVLTree random test nElem=100
	//
	std::cout << "AVLTree random test nElem=100" << std::endl;
	
	// (a)
	std::cout << "(a)" << std::endl;

    	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		avl1.insert(key1[i], val1[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (b)
	std::cout << "(b)" << std::endl;

	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		avl1.find(key1[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (c)
	std::cout << "(c)" << std::endl;

	// ratio 20:80
	std::cout << "ratio 20:80" << std::endl;

	tm = clock();
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<20;
		if (T==true) {avl1.find(key1[i]);}
		else {avl1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 40:60
	std::cout << "ratio 40:60" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<40;
		if (T==true) {avl1.find(key1[i]);}
		else {avl1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 50:50
	std::cout << "ratio 50:50" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<50;
		if (T==true) {avl1.find(key1[i]);}
		else {avl1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 60:40
	std::cout << "ratio 60:40" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<60;
		if (T==true) {avl1.find(key1[i]);}
		else {avl1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 80:20
	std::cout << "ratio 80:20" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<80;
		if (T==true) {avl1.find(key1[i]);}
		else {avl1.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);




	std::cout << "------------" << std::endl;


	SearchTree<EntryType> st2;
	AVLTree<EntryType> avl2;

	//
	// SearchTree random test nElem=1000
	//
	std::cout << "SearchTree random test nElem=1000" << std::endl;

	nElem = 1000;
	int *key2 = new int[nElem*2];
	float *val2 = new float[nElem*2];
	std::srand(std::time(0)); // use current time as seed for random generator
	for(int i=0; i<nElem*2; i++)
	{
		key2[i] = std::rand();
		val2[i] = (float) std::rand()/RAND_MAX * 20000;
	}
	
	// (a)
	std::cout << "(a)" << std::endl;

    	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		st2.insert(key2[i], val2[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (b)
	std::cout << "(b)" << std::endl;

	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		st2.find(key2[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (c)
	std::cout << "(c)" << std::endl;

	// ratio 20:80
	std::cout << "ratio 20:80" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<20;
		if (T==true) {st2.find(key1[i]);}
		else {st2.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 40:60
	std::cout << "ratio 40:60" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<40;
		if (T==true) {st2.find(key1[i]);}
		else {st2.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 50:50
	std::cout << "ratio 50:50" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<50;
		if (T==true) {st2.find(key1[i]);}
		else {st2.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 60:40
	std::cout << "ratio 60:40" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<60;
		if (T==true) {st2.find(key1[i]);}
		else {st2.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 80:20
	std::cout << "ratio 80:20" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<80;
		if (T==true) {st2.find(key1[i]);}
		else {st2.erase(key1[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	
	std::cout << "------------" << std::endl;



	//
	// AVLTree random test nElem=1000
	//
	std::cout << "AVLTree random test nElem=1000" << std::endl;
	
	// (a)
	std::cout << "(a)" << std::endl;

    	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		avl2.insert(key2[i], val2[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (b)
	std::cout << "(b)" << std::endl;

	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		avl2.find(key2[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (c)
	std::cout << "(c)" << std::endl;

	// ratio 20:80
	std::cout << "ratio 20:80" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<20;
		if (T==true) {avl2.find(key2[i]);}
		else {avl2.erase(key2[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 40:60
	std::cout << "ratio 40:60" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<40;
		if (T==true) {avl2.find(key2[i]);}
		else {avl2.erase(key2[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 50:50
	std::cout << "ratio 50:50" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<50;
		if (T==true) {avl2.find(key2[i]);}
		else {avl2.erase(key2[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 60:40
	std::cout << "ratio 60:40" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<60;
		if (T==true) {avl2.find(key2[i]);}
		else {avl2.erase(key2[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 80:20
	std::cout << "ratio 80:20" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<80;
		if (T==true) {avl2.find(key2[i]);}
		else {avl2.erase(key2[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	std::cout << "------------" << std::endl;

	//
	// SearchTree random test nElem=10000
	//
	SearchTree<EntryType> st3;
	AVLTree<EntryType> avl3;

	std::cout << "SearchTree random test nElem=10000" << std::endl;

	nElem = 10000;
	int *key3 = new int[nElem*2];
	float *val3 = new float[nElem*2];
	std::srand(std::time(0)); // use current time as seed for random generator
	for(int i=0; i<nElem*2; i++)
	{
		key3[i] = std::rand();
		val3[i] = (float) std::rand()/RAND_MAX * 20000;
	}
	
	// (a)
	std::cout << "(a)" << std::endl;

    	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		st3.insert(key3[i], val3[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (b)
	std::cout << "(b)" << std::endl;

	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		st3.find(key3[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (c)
	std::cout << "(c)" << std::endl;

	// ratio 20:80
	std::cout << "ratio 20:80" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<20;
		if (T==true) {st3.find(key3[i]);}
		else {st3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 40:60
	std::cout << "ratio 40:60" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<40;
		if (T==true) {st3.find(key3[i]);}
		else {st3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 50:50
	std::cout << "ratio 50:50" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<50;
		if (T==true) {st3.find(key3[i]);}
		else {st3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 60:40
	std::cout << "ratio 60:40" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<60;
		if (T==true) {st3.find(key3[i]);}
		else {st3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 80:20
	std::cout << "ratio 80:20" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<80;
		if (T==true) {st3.find(key3[i]);}
		else {st3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);



	
	std::cout << "------------" << std::endl;



	//
	// AVLTree random test nElem=10000
	//
	std::cout << "AVLTree random test nElem=10000" << std::endl;
	
	// (a)
	std::cout << "(a)" << std::endl;

    	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		avl3.insert(key3[i], val3[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (b)
	std::cout << "(b)" << std::endl;

	tm = clock();
	for(int i=0; i<nElem; i++)
	{
		avl3.find(key3[i]);
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// (c)
	std::cout << "(c)" << std::endl;

	// ratio 20:80
	std::cout << "ratio 20:80" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<20;
		if (T==true) {avl3.find(key3[i]);}
		else {avl3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 40:60
	std::cout << "ratio 40:60" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<40;
		if (T==true) {avl3.find(key3[i]);}
		else {avl3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);


	// ratio 50:50
	std::cout << "ratio 50:50" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<50;
		if (T==true) {avl3.find(key3[i]);}
		else {avl3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 60:40
	std::cout << "ratio 60:40" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<60;
		if (T==true) {avl3.find(key3[i]);}
		else {avl3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	// ratio 80:20
	std::cout << "ratio 80:20" << std::endl;

	tm = clock();
	
	for(int i=nElem; i<nElem*2; i++)
	{
		T=(std::rand()/100)<80;
		if (T==true) {avl3.find(key3[i]);}
		else {avl3.erase(key3[i]);}
	}
	tm = clock() - tm;
	printf ("It took me %f seconds.\n",((float)tm)/(float)CLOCKS_PER_SEC);

	std::cout << "------------" << std::endl;

	return 0;

}