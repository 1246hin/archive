//
// Assignment 2 : Simple calculator using Stack
//
// Array-based stack data structure
//
// COSE213 Spring 2021
//

template<class type>
Stack<type>::~Stack()
{
	delete[] array;
	top=-1;
	array=new type[capacity];
}

template<class type>
type& Stack<type>::Top()
{
	if(!IsEmpty()){
		return array[top];
	}
	
}

template<class type>
void Stack<type>::Push(const type& item)
{
	if(top!=capacity-1){
		array[++top]=item;
	}
	
}

template<class type>
void Stack<type>::Pop()
{
	if(!IsEmpty()){
		top--;
	
	}
	
}

template<class type>
bool Stack<type>::IsEmpty() const
{
	return top==-1;
}

