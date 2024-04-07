import '../data/model/user.dart';

abstract interface class UserService {
  Future<List<User>?> getAll();
  Future<User?> getById(int id);
  Future<User?> save(User order);
  Future<User?> delete(int id);
  Future<User?> update(int id, {required Map<String, dynamic> data});
}
