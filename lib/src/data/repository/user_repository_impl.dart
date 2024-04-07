import 'package:api/src/core/database/database.dart';

import '../model/user.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Database _database;

  UserRepositoryImpl({
    required Database database,
  }) : _database = database;

  @override
  Future<List<User>?> getAll() async {
    final data = await _database.getData("SELECT * FROM ORDERS");
    if (data != null) {
      return data.map<User>((o) => User.fromMap(o)).toList();
    }
    return null;
  }

  @override
  Future<User?> getById(int id) async {
    final data =
        await _database.getUnique("SELECT * FROM ORDERS WHERE ID = $id");
    if (data != null) {
      return User.fromMap(data);
    }
    return null;
  }

  @override
  Future<int?> save(User order) async {
    final data =
        await _database.insert(tableName: 'ORDERS', value: order.toDataBase());
    if (data != 0) {
      return data;
    }
    return null;
  }

  @override
  Future<bool> delete(int id) async {
    final deleted =
        await _database.delete(tableName: 'ORDERS', value: {'id': id});
    return deleted;
  }

  @override
  Future<bool> update(int id, User order) async {
    final updated =
        _database.update(tableName: 'ORDERS', value: order.toDataBase());
    return updated;
  }
}
