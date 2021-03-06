class AffineTransform {
  num _m00, _m10, _m01, _m11, _m02, _m12;

  AffineTransform([this._m00 = 1, this._m10 = 0, this._m01 = 0, this._m11 = 1, this._m02 = 0, this._m12 = 0]);

  num get scaleX(){
    return _m00;
  }

  num get scaleY(){
    return _m11;
  }

  num get translateX(){
    return _m02;
  }

  num get translateY(){
    return _m12;
  }

  num get shearX(){
    return _m01;
  }

  num get shearY(){
    return _m10;
  }

  AffineTransform concatenate(tx) {
    var m0 = this._m00;
    var m1 = this._m01;
    this._m00 = tx._m00 * m0 + tx._m10 * m1;
    this._m01 = tx._m01 * m0 + tx._m11 * m1;
    this._m02 += tx._m02 * m0 + tx._m12 * m1;

    m0 = this._m10;
    m1 = this._m11;
    this._m10 = tx._m00 * m0 + tx._m10 * m1;
    this._m11 = tx._m01 * m0 + tx._m11 * m1;
    this._m12 += tx._m02 * m0 + tx._m12 * m1;
    return this;
  }
  
  AffineTransform rotate(num theta, num x, num y) {
    return this.concatenate(AffineTransform.getRotateInstance(theta, x, y));
  }
  
  AffineTransform translate(num dx, num dy) {
    _m02 += dx * _m00 + dy * _m01;
    _m12 += dx * _m10 + dy * _m11;
    return this;
  }

  AffineTransform setToScale(sx, sy) {
    return setTransform(sx, 0, 0, sy, 0, 0);
  }
  
  AffineTransform setToRotation(num theta, num x, num y) {
    var cos = Math.cos(theta);
    var sin = Math.sin(theta);
    return this.setTransform(cos, sin, -sin, cos, 
      x - x * cos + y * sin, y - x * sin - y * cos);
  }
  
  AffineTransform setToTranslation(num dx, num dy) {
    return setTransform(1, 0, 0, 1, dx, dy);
  }
  
  AffineTransform setTransform (num m00, num m10, num m01,
    num m11, num m02, num m12) {
    this._m00 = m00;
    this._m10 = m10;
    this._m01 = m01;
    this._m11 = m11;
    this._m02 = m02;
    this._m12 = m12;
    return this;
  }
  
  Coordinate transformCoordinate([Coordinate point = const Coordinate()]){
    num x = point.x * _m00 + point.y * _m01 + _m02;
    num y = point.x * _m10 + point.y * _m11 + _m12;

    return new Coordinate(x, y);
  }
  
  num get determinant(){
    return _m00 * _m11 - _m01 * _m10;
  }
  
  AffineTransform createInverse() {
    num det = determinant;
    return new AffineTransform(
        _m11 / det,
        -_m10 / det,
        -_m01 / det,
        _m00 / det,
        (_m01 * _m12 - _m11 * _m02) / det,
        (_m10 * _m02 - _m00 * _m12) / det);
  }

  static AffineTransform getRotateInstance(num theta, num x, num y) {
    return new AffineTransform().setToRotation(theta, x, y);
  }

  static AffineTransform getScaleInstance(sx, sy) {
    return new AffineTransform().setToScale(sx, sy);
  }
}
