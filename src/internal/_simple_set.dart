class _SimpleSet<T>{
  final List<T> _items;

  _SimpleSet():_items = new List<T>();

  // NOTE: set doesn't like dupes. Ignores extras
  void add(T item){
    if(_items.indexOf(item) >= 0){
      _items.add(item);
    }
  }
  
  bool remove(T item){
    var index = _items.indexOf(item);
    if(index >= 0){
      _items.removeRange(index, 1);
      return true;
    }
    return false;
  }

  void forEach(void f(T element)){
    _items.forEach(f);
  }
}
