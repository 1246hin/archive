/** 
  * Assignment 3 for COSE213 Data Structures
  *
  * Won-Ki Jeong (wkjeong@korea.ac.kr)
  *
  * 2021. 5. 9
  *
  */



// destructor
template <class HashMapElemType>
HashMap<HashMapElemType>::~HashMap() 
{
            for (int i = 0; i < capacity; ++i)
	    {
                HashMapElemType* entry = ht[i];
                while (entry != nullptr)
	        {
                    HashMapElemType* prev = entry;
                    entry = entry->link;
                    delete prev;
                }
            }
            delete[] ht;
}
	
template <class HashMapElemType>
HashMapElemType* 
HashMap<HashMapElemType>::find(const KeyType k) 
{ 
            bool flag = false;

            int hashv = hashfunction(k);
            HashMapElemType* entry = ht[hashv];
            while (entry != nullptr)
	    {
                if (entry->key == k)
	        {
			flag = true;
			return entry;
                }
                else {entry = entry->link;}
            }
            if (!flag)
                return NULL;
        	
}
	
template <class HashMapElemType>
void 
HashMap<HashMapElemType>::insert(const KeyType k, const ValType v) 
{
		int hashv = hashfunction(k);
		
		HashMapElemType *tmp = ht[hashv];
		if (tmp == nullptr) {
			HashMapElemType * next = new HashMapElemType;
			next->key = k;
			next->val = v;
			next->link = nullptr;
			ht[hashv] = next;
			mapsize++;	
		}
		else {
			while (tmp != nullptr) {
				if (tmp->key == k) {
					tmp->val = v;
					return;
				}
				else if (tmp->link == nullptr) {
					HashMapElemType * next = new HashMapElemType;
					next->key = k;
					next->val = v;
					next->link = nullptr;
					tmp->link = next;
					mapsize++;
					return;
				}
				else {
					tmp = tmp->link;
					
				}
			}
		}

		if(mapsize>=capacity){capacity=capacity*2;}
}
		
template <class HashMapElemType>
bool 
HashMap<HashMapElemType>::remove(const KeyType k) 
{
		int hashv = hashfunction(k);
		HashMapElemType * tmp = ht[hashv];
		HashMapElemType * prev = ht[hashv];

		if (tmp == nullptr) {
			return false;
		}

		if (tmp->key == k) {
			ht[hashv] = tmp->link;
			delete tmp;
			mapsize--;
			return true;
		}
		else {
			tmp = tmp->link;
			return true;
		}
		while (tmp != nullptr) {
			if (tmp->key == k) {
				if (tmp->link == nullptr) {
					prev->link = nullptr;
					delete tmp;
					mapsize--;
					return true;
				}
				else {
					prev->link = tmp->link;
					delete tmp;
					mapsize--;
					return true;
				}
			}
			else {
				tmp = tmp->link;
				prev = prev->link;
			}
		}
}
	
template <class HashMapElemType>
unsigned int 
HashMap<HashMapElemType>::hashfunction(const KeyType k)
{
    const int p = 31;
    long long hashv = 0;
    long long pp = 1;
    for (char c : k) {
        hashv = (hashv + (c - 'a' + 1) * pp) % divisor;
        pp = (pp * p) % divisor;
    }
    return hashv;
}

template <class HashMapElemType>
void 
HashMap<HashMapElemType>::print()
{	

	for (int i = 1; i < capacity; i++)
	{
                HashMapElemType* entry = ht[i];
		if (entry != nullptr)
	        {
			std::cout<< entry->key<<": "<< entry->val<<std::endl;
		
		}
		    	                    
        }
            
}