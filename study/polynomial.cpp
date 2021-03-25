#include "polynomial.h"
#include <iostream>
#include <math.h>


//
// Implementation
//

// Default constructor p(x) = 0
Polynomial::Polynomial(){
	capacity=1;
	terms=0;
	termArray=new Term[capacity];
}

// Copy constructor
Polynomial::Polynomial(const Polynomial& source){
	capacity=source.capacity;
	terms=source.terms;
	termArray=new Term[capacity];
	for (int i=0; i<terms; i++){
		termArray[i]=source.termArray[i];
	}
}	

// Destructor
Polynomial::~Polynomial(){
	delete[] termArray;
}


Polynomial& Polynomial::operator = (const Polynomial& source){
	if (this!=&source) {
        Term *temp=new Term[source.capacity];
		for (int i=0; i<capacity; i++){
			temp[i]=source.termArray[i];
		}
		delete[] termArray;
		termArray=temp;
		terms=source.terms;
    }
    return *this;
}

// Sum of *this and source polynomials
Polynomial Polynomial::operator +(const Polynomial& source){
	Polynomial c;

	int aPos=0, bPos=0;
	int at=this->terms, bt=source.terms;
	while ((aPos<at)&&(bPos<bt)){
		if (termArray[aPos].exp==source.termArray[bPos].exp){
			float t=termArray[aPos].coef+source.termArray[bPos].coef;
			if (t) {c.CreateTerm(t, termArray[aPos].exp);}
			aPos++;
			bPos++;
		}
		else if (termArray[aPos].exp<source.termArray[bPos].exp){
			c.CreateTerm(source.termArray[bPos].coef, source.termArray[bPos].exp);
			bPos++;
		}
		else{
			c.CreateTerm(termArray[aPos].coef, termArray[aPos].exp);
			aPos++;
		}
	}
	
	for(; aPos<at; aPos++){
		c.CreateTerm(termArray[aPos].coef, termArray[aPos].exp);
	}
	for(; bPos<bt; bPos++){
		c.CreateTerm(source.termArray[bPos].coef, source.termArray[bPos].exp);
	}
	

	return c;
	
}

Polynomial Polynomial::operator - (const Polynomial& source){
	Polynomial c;

	int aPos=0, bPos=0;
	int at=this->terms, bt=source.terms;
	while ((aPos<at)&&(bPos<bt)){
		if (termArray[aPos].exp==source.termArray[bPos].exp){
			float t=termArray[aPos].coef-source.termArray[bPos].coef;
			if (t) {c.CreateTerm(t, termArray[aPos].exp);}
			aPos++;
			bPos++;
		}
		else if (termArray[aPos].exp<source.termArray[bPos].exp){
			c.CreateTerm(-source.termArray[bPos].coef, source.termArray[bPos].exp);
			bPos++;
		}
		else{
			c.CreateTerm(termArray[aPos].coef, termArray[aPos].exp);
			aPos++;
		}
	}
	
	for(; aPos<at; aPos++){
		c.CreateTerm(termArray[aPos].coef, termArray[aPos].exp);
	}
	for(; bPos<bt; bPos++){
		c.CreateTerm(-source.termArray[bPos].coef, source.termArray[bPos].exp);
	}
	

	return c;
	
}


Polynomial Polynomial::operator * (const Polynomial& source){
	Polynomial c;
	
	int at=terms, bt=source.terms;
	for (int i=0; i<at; i++){
		for (int j=0; j<bt; j++){
			float t=termArray[i].coef*source.termArray[j].coef;
			int k=termArray[i].exp+source.termArray[j].exp;
			Polynomial temp;
			temp.CreateTerm(t, k);
			c=c+temp;
		}
	}
	
	
	return c;	
}





float Polynomial::Eval(float x){
	float ret = 0;
	
	for (int i=0; i<terms; i++){
		float temp=1;
		for (int j=0; j<termArray[i].exp; j++){
			temp*=x;
		}
		ret+=(temp*termArray[i].coef);
	}
	
	return ret;
}




// Compute derivative of the current polynomial
Polynomial Polynomial::Derivative(){
	Polynomial c;
	
	for (int i=0; i < terms; i++){
		if(termArray[i].exp != 0){
            	c.CreateTerm(termArray[i].exp*termArray[i].coef, termArray[i].exp-1);
		}
	}
	return c;	
}


void Polynomial::CreateTerm(const float coef, const int exp){
	if (terms==capacity){
		capacity*=2;
		Term *temp=new Term[capacity];
		for (int i=0; i<terms; i++){
			temp[i]=termArray[i];
		}
		delete[] termArray;
		termArray=temp;
	}
	termArray[terms].coef=coef;
	termArray[terms].exp=exp;
	
	for(int i=0; i<terms; i++){
		if(termArray[i].exp==exp){		
			termArray[i].coef+=coef;
			termArray[terms].exp=-1;
			terms--;	
		}
		
	}
	for (int i=0; i<terms+1; i++){
		if (termArray[i].coef==0){
			Term *temp=new Term[capacity];
			for (int j=0; j<i; j++){
				temp[j]=termArray[j];
			}
			for (int k=i+1; k<terms+1; k++){
				temp[k-1]=termArray[k];
			}
			delete[] termArray;
			termArray=temp;
			terms--;
		}
	}
	terms++;
	for(int i=0; i<terms; i++){
		for(int j=i+1; j<terms; j++){
      		if (termArray[i].exp < termArray[j].exp){                 		
				Term temp = termArray[i];
				termArray[i] = termArray[j];
            	      termArray[j] = temp;
			}
		}
	}
	
}


