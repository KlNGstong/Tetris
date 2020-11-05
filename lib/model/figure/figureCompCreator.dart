
import '../border/borderIndex.dart';
import 'figureType.dart';

class FigureCompCreator{

  static List<BorderIndex> getI () {
    final result = [
      BorderIndex(0, 1),
      BorderIndex(1, 1),
      BorderIndex(2, 1),
      BorderIndex(3, 1),
    ];
    return result;
  }

  static List<BorderIndex> getL () {
    final result = [
      BorderIndex(0, 1),
      BorderIndex(1, 1),
      BorderIndex(2, 1),
      BorderIndex(2, 0),
    ];
    return result;
  }

  static List<BorderIndex> getS () {
    final result = [
      BorderIndex(0, 1),
      BorderIndex(1, 1),
      BorderIndex(1, 0),
      BorderIndex(2, 0),
    ];
    return result;
  }

  static List<BorderIndex> getT () {
    final result = [
      BorderIndex(0, 1),
      BorderIndex(1, 1),
      BorderIndex(1, 0),
      BorderIndex(2, 1),
    ];
    return result;
  }

  static List<BorderIndex> getJ () {
    final result = [
      BorderIndex(0, 0),
      BorderIndex(0, 1),
      BorderIndex(1, 1),
      BorderIndex(2, 1),
    ];
    return result;
  }

  static List<BorderIndex> getZ () {
    final result = [
      BorderIndex(0, 0),
      BorderIndex(1, 0),
      BorderIndex(1, 1),
      BorderIndex(2, 1),
    ];
    return result;
  }

  static List<BorderIndex> getO () {
    final result = [
      BorderIndex(0, 1),
      BorderIndex(1, 1),
      BorderIndex(0, 0),
      BorderIndex(1, 0),
    ];
    return result;
  }

  static List<BorderIndex> getByType (FigureType type)  {
    switch(type){
      case FigureType.I:
        return getI();
        break;
      case FigureType.J:
        return getJ();
        break;
      case FigureType.L:
        return getL();
        break;
      case FigureType.O:
        return getO();
        break;
      case FigureType.S:
        return getS();
        break;
      case FigureType.T:
        return getT();
        break;
      case FigureType.Z:
        return getZ();
        break;
    }
    return null;
  }


}