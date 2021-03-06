interface IDisposable {
  void dispose();
  bool get isDisposed();
}

class Disposable implements IDisposable{
	bool _disposed = false;

  void dispose(){
    if (!_disposed) {
      // Set disposed_ to true first, in case during the chain of disposal this
      // gets disposed recursively.
      this._disposed = true;
      this.disposeInternal();
    }
  }

  bool get isDisposed(){
    return _disposed;
  }

  void disposeInternal(){
    // TODO: once we support dependency disposables, need to clean them up
  }
}
