#ifndef CALCULATOR_H
#define CALCULATOR_H

//
// Assignment 2 : Simple calculator using Stack
//
// COSE213 Spring 2021
//
// Won-Ki Jeong (wkjeong@korea.ac.kr)
//

#include <iostream>
#include <cassert>
#include <math.h>
#include "stack.h"
#include <vector>
#include <string>
#include <cstdlib>

using namespace std;

enum type
{
    D = 0, I, R, N, O, U, S
};
 
int stateTable[][7] = { 
	{0, I, R, N, O, U, S}, {I, I, R, D, D, D, D},
	{R, R, D, D, D, D, D}, {N, I, R, D, D, D, D},
	{O, D, D, D, D, D, D}, {U, D, D, D, D, U, D},
	{S, D, D, D, D, D,  D} };
 
string toPost(char* in);
bool isOp(char token);
int order(char token);
vector<string> parser(string postfix);
int getCol(char& currentChar);
double evalPost(const vector<string>& postfix);
double calPost(char token, double op1, double op2);

double Eval(char* in){
	string postfix=toPost(in);
	vector<string> tokens = parser(postfix);
	double answer = evalPost(tokens);

	return answer;
}
 
string toPost(char* in)
{
    string infix(in);
    string postfix;
    Stack<char> charStack;
 
    for (unsigned x = 0; x < infix.length(); ++x) {
        if (infix[x] != '-') {
            continue;
        } else if (x + 1 < infix.length() && isOp(infix[x + 1])) {
            continue;
        }
        if (x == 0 || infix[x - 1] == '(' || isOp(infix[x - 1])) {
            infix[x] = '~';
        }
    }
 
    for (unsigned x = 0; x < infix.length(); ++x)
    {
        if ((isdigit(infix[x])) || (infix[x] == '.') || (infix[x] == '~'))
        {
            postfix += infix[x];
        }
        else if (isspace(infix[x]))
        {
            continue;
        }
        else if (isOp(infix[x]))
        {
            postfix += " ";
            while ((!charStack.IsEmpty()) &&
                (order(charStack.Top()) >= order(infix[x])))
            {
                postfix += charStack.Top();
                charStack.Pop();
            }
            charStack.Push(infix[x]);
        }
        else if (infix[x] == '(')
        {
            charStack.Push(infix[x]);
        }
        else if (infix[x] == ')')
        {
            while ((!charStack.IsEmpty()) && (charStack.Top() != '('))
            {
                postfix += charStack.Top();
                charStack.Pop();
            }
 
            if (!charStack.IsEmpty()) 
            {
                charStack.Pop();
            }
            else 
            {
                break;
            }
        }
        else
        {
            break;
        }
    }
 
     while (!charStack.IsEmpty())
    {
        postfix += charStack.Top();
        charStack.Pop();
    }
 
    return postfix;
}
 
bool isOp(char token)
{  switch (token)
    {
    case '+': case '-': case '*': case '/':
        return true;
        break;
    default:
        return false;
        break;
    }
}
 
int order(char token)
{   int priority = 0;
    switch (token)
    {
    case '*': case '/':
        priority = 3;
        break;
    case '-':
        priority = 2;
        break;
    case '+':
        priority = 1;
        break;
    }
    return priority;
}
 
vector<string> parser(string postfix)
{   vector<string> tokens;
    char currentChar = ' ';
    int col = D;
    int currentState = D;
    string currentToken = "";
 
    for (unsigned x = 0; x < postfix.length();)
    {
        currentChar = postfix[x];
 
        col = getCol(currentChar);
 	  currentState = stateTable[currentState][col];
        if (currentState == D)
        {
            if (currentToken != " ")
            {
                tokens.push_back(currentToken);
            }
            currentToken = "";
        }
        else
        {
            currentToken += currentChar;
            ++x;
        }
 
    }
    if (currentToken != " ")
    {
        tokens.push_back(currentToken);
    }
    return tokens;
}
 
int getCol(char& currentChar)
{
    if (isspace(currentChar))
    {
        return S;
    }
 
    
    else if (isdigit(currentChar))
    {
        return I;
    }
 
    else if (currentChar == '.')
    {
        return R;
    }
 
    
    else if (currentChar == '~')
    {
        currentChar = '-';
        return N;
    }
 
    
    else if (isOp(currentChar))
    {
        return O;
    }
    return U;
}
 
double evalPost(const vector<string>& postfix)
{   double op1 = 0;
    double op2 = 0;
    double answer = 0;
    Stack<double> doubleStack;
 
    for (unsigned x = 0; x < postfix.size(); ++x)
    {
        if ((isdigit(postfix[x][0])) || (postfix[x][0] == '.'))
        {
            doubleStack.Push(atof(postfix[x].c_str()));
        }
        else if ((postfix[x].length() > 1) && ((postfix[x][0] == '-') &&
            (isdigit(postfix[x][1]) || (postfix[x][1] == '.'))))
        {
            doubleStack.Push(atof(postfix[x].c_str()));
        }
        else if (isOp(postfix[x][0]) && (!doubleStack.IsEmpty()))
        {
            char token = postfix[x][0];
 
            if (doubleStack.Size() > 1)
            {
                op2 = doubleStack.Top();
                doubleStack.Pop();
                op1 = doubleStack.Top();
                doubleStack.Pop();
                answer = calPost(token, op1, op2);
                doubleStack.Push(answer);
            }
        }
        else 
        {
            break;
        }
    }
    if (!doubleStack.IsEmpty())
    {
        answer = doubleStack.Top();
    }
    return answer;
}
 
double calPost(char token, double op1, double op2)
{
    double ans = 0;
    switch (token)
    {
    case '+':
        ans = op1 + op2;
        break;
    case '-':
        ans = op1 - op2;
        break;
    case '*':
        ans = op1 * op2;
        break;
    case '/':
        ans = op1 / op2;
        break;
    default:
        ans = 0;
        break;
    }
    
    return ans;
}


#endif
