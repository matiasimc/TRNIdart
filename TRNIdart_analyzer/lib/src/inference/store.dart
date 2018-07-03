import 'package:TRNIdart_analyzer/TRNIdart_analyzer.dart';

class Store {
  /*
  Map relating a variable to a virtual memory location
   */
  Map<Element, int> elements;

  /*
  Map relating a virtual memory location to a type
   */
  Map<int, IType> types;

  /*
  Map of expressions
   */
  Map<Expression, IType> expressions;

  int storeIndex, varIndex;

  Store() {
    this.elements = new Map();
    this.types = new Map();
    this.expressions = new Map();
    this.storeIndex = 0;
    this.varIndex = 0;
  }

  void addElement(Element v, IType defaultType, {IType declaredType, IType dartCoreType}) {
    if (!this.elements.containsKey(v)) elements[v] = this.storeIndex++;
    if (declaredType != null) {
      types[elements[v]] = declaredType;
    }
    else {
      types[elements[v]] = new TVar(varIndex++, defaultType, dartCoreType: dartCoreType);
    }
  }

  TVar getTypeVariable(IType defaultType, {IType dartCoreType}) {
    return new TVar(varIndex++, defaultType, dartCoreType: dartCoreType);
  }

  bool hasElement(Element e) {
    return this.elements.containsKey(e);
  }

  IType getType(Element e) {
    return types[elements[e]];
  }

  IType getTypeOrVariable(Element e, {IType defaultType, IType dartCoreType}) {
    if (e == null) return this.getTypeVariable(defaultType, dartCoreType: dartCoreType);
    if (!this.hasElement(e)) this.addElement(e, defaultType, dartCoreType: dartCoreType);
    return getType(e);
  }

  String printStore() {
    String ret = "";
    this.elements.forEach((e,i) {
      ret += "${e.toString()} -> $i\n";
    });
    ret += "\n";
    this.types.forEach((i,t) {
      ret += "$i -> $t\n";
    });

    return ret;
  }
}