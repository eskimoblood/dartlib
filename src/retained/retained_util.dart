class RetainedUtil {
  static List<PElement> hitTest(Stage stage, Coordinate point){
    return _hitTest(stage.rootElement, point);
  }

  static List<PElement> _hitTest(PElement element, Coordinate point){
    point = transformPointGlobalToLocal(element, point);

    var bounds = new PRect(0, 0, element.width, element.height);

    var hits = new List<PElement>();
    if (bounds.contains(point)) {

      var length = element.visualChildCount;
      for (var i = 0; i < length; i++) {
        var e = element.getVisualChild(length - 1 - i);
        hits = _hitTest(e, point);
        if (hits.length > 0) {
          break;
        }
      }
      hits.add(element);
      return hits;
    } else {
      return [];
    }
  }

  static Coordinate transformPointLocalToGlobal(element, point) {
    var tx = element.getTransformToRoot();
    return tx.transformCoordinate(point);
  }

  static Coordinate transformPointGlobalToLocal(element, point) {
    var tx = element.getTransform();
    return tx.createInverse().transformCoordinate(point);
  }
}
