typedef T InstanceCreator<T>();

class DependecyInjector {
  DependecyInjector._();

  static final _singleton = DependecyInjector._();

  factory DependecyInjector() => _singleton;

  final _instanceMap = <Type, _InstanceGenerator<Object>>{};

  // Register dependency

  void register<T extends Object>(
    InstanceCreator<T> instance, {
    bool isSingleton = false,
  }) {
    _instanceMap[T] = _InstanceGenerator(instance, isSingleton);
  }

  // Get dependency
  T get<T extends Object>() {
    final instance = _instanceMap[T]?.getInstance();
    if (instance != null && instance is T) {
      return instance;
    }
    throw Exception('[Error] => Instance ${T.toString()} not found');
  }
}

class _InstanceGenerator<T> {
  T? _instance;
  bool _isFirstGet = false;

  final InstanceCreator<T> _instanceCreator;
  _InstanceGenerator(this._instanceCreator, bool isSingleton)
      : _isFirstGet = isSingleton;

  T? getInstance() {
    if (_isFirstGet) {
      _instance = _instanceCreator();
      _isFirstGet = false;
    }
    return _instance ?? _instanceCreator();
  }
}
