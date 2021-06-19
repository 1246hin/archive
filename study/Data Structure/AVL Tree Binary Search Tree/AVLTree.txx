//
// Implementation
//
template <typename E>					// constructor
  AVLTree<E>::AVLTree() : ST() { }

template <typename E>					// node height utility
  int AVLTree<E>::height(const TPos& v) const
    { return (v.isExternal() ? 0 : (*v).height()); }

template <typename E>					// set height utility
  void AVLTree<E>::setHeight(TPos v) {
    int hl = height(v.left());
    int hr = height(v.right());
    (*v).setHeight(1 + std::max(hl, hr));			// max of left & right
  }

template <typename E>					// is v balanced?
  bool AVLTree<E>::isBalanced(const TPos& v) const {	
    int bal = height(v.left()) - height(v.right());
    return ((-1 <= bal) && (bal <= 1));
  }

template <typename E>					// get tallest grandchild
  typename AVLTree<E>::TPos AVLTree<E>::tallGrandchild(const TPos& z) const {
    TPos zl = z.left();
    TPos zr = z.right();
    if (height(zl) >= height(zr))			// left child taller
      if (height(zl.left()) >= height(zl.right()))
        return zl.left();
      else
        return zl.right();
    else 						// right child taller
      if (height(zr.right()) >= height(zr.left()))
        return zr.right();
      else
        return zr.left();
  }


//
// ToDo
//

template <typename E>					// remove key k entry
  void AVLTree<E>::erase(const K& k) {
    
	TPos v = ST::finder(k, ST::root());	
	if (! v.isExternal()) {
		TPos w = ST::eraser(v);
		rebalance(w); 					
    	
	} 			
	
  }

template <typename E>					// insert (k,x)
  typename AVLTree<E>::Iterator AVLTree<E>::insert(const K& k, const V& x) {
    
	TPos v = ST::inserter(k, x); 		
	setHeight(v); 					
	return Iterator(v);
    
  }
  
template <typename E>					// rebalancing utility
  void AVLTree<E>::rebalance(const TPos& v) {
    
	TPos z = v;
	while (!(z == ST::root())) 
    { 								
		z = z.parent();
		setHeight(z); 				
		if (!isBalanced(z)) 
        {	 						
			TPos x = tallGrandchild(z);
			z = ST::restructure(x);		
			setHeight(z.left());	
			setHeight(z.right());
			setHeight(z);
		}
	}
    
  }

