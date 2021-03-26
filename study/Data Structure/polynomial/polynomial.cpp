#include "polynomial.h"
#include <iostream>
#include <math.h>


//
// Implementation
//

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

	int ap=0, bp=0;
	int at=this->terms, bt=source.terms;
	while ((ap<at)&&(bp<bt)){
		if (termArray[ap].exp==source.termArray[bp].exp){
			float t=termArray[ap].coef+source.termArray[bp].coef;
			if (t) {c.CreateTerm(t, termArray[ap].exp);}
			ap++;
			bp++;
		}
		else if (termArray[ap].exp<source.termArray[bp].exp){
			c.CreateTerm(source.termArray[bp].coef, source.termArray[bp].exp);
			bp++;
		}
		else{
			c.CreateTerm(termArray[ap].coef, termArray[ap].exp);
			ap++;
		}
	}
	
	for(; ap<at; ap++){
		c.CreateTerm(termArray[ap].coef, termArray[ap].exp);
	}
	for(; bp<bt; bp++){
		c.CreateTerm(source.termArray[bp].coef, source.termArray[bp].exp);
	}
	

	return c;
	
}

Polynomial Polynomial::operator - (const Polynomial& source){
	Polynomial c;

	int ap=0, bp=0;
	int at=this->terms, bt=source.terms;
	while ((ap<at)&&(bp<bt)){
		if (termArray[ap].exp==source.termArray[bp].exp){
			float t=termArray[ap].coef-source.termArray[bp].coef;
			if (t) {c.CreateTerm(t, termArray[ap].exp);}
			ap++;
			bp++;
		}
		else if (termArray[ap].exp<source.termArray[bp].exp){
			c.CreateTerm(-source.termArray[bp].coef, source.termArray[bp].exp);
			bp++;
		}
		else{
			c.CreateTerm(termArray[ap].coef, termArray[ap].exp);
			ap++;
		}
	}
	
	for(; ap<at; ap++){
		c.CreateTerm(termArray[ap].coef, termArray[ap].exp);
	}
	for(; bp<bt; bp++){
		c.CreateTerm(-source.termArray[bp].coef, source.termArray[bp].exp);
	}
	

	return c;
	
}


Polynomial Polynomial::operator * (const Polynomial& source){
	Polynomial c;
	
	int at=terms, bt=source.terms;
	for (int i=0; i<at; i++){
		for (int j=0; j<bt; j++){
			float k=termArray[i].coef*source.termArray[j].coef;
			int l=termArray[i].exp+source.termArray[j].exp;
			Polynomial temp;
			temp.CreateTerm(k, l);
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


