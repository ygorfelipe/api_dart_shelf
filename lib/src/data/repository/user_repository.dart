
import 'package:api/src/data/model/user.dart';

abstract interface class UserRepository {
  Future<List<User>?> getAll();
  Future<User?> getById(int id);
  Future<int?> save(User order);
  Future<bool> delete(int id);
  Future<bool> update(int id, User order);
}
