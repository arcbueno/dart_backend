import '../models/task.dart';
import '../utils/list_extension.dart';
import 'generic.service.dart';

class TasksService implements GenericService<Task> {
  final List<Task> _fakeList = [];

  @override
  bool delete(int id) {
    _fakeList.removeWhere((element) => element.id == id);
    return true;
  }

  @override
  List<Task> findAll() {
    return _fakeList;
  }

  @override
  Task findOne(int id) {
    return _fakeList.firstWhere((element) => element.id == id);
  }

  @override
  bool save(Task value) {
    Task? model =
        _fakeList.firstWhereOrNull((element) => element.id == value.id);

    if (model == null) {
      _fakeList.add(value);
    } else {
      var index = _fakeList.indexOf(model);
      _fakeList[index] = value;
    }
    return true;
  }
}
