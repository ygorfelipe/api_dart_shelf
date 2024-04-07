// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:api/src/data/model/user.dart';

import '../data/repository/user_repository.dart';
import 'user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _repository;

  UserServiceImpl({required UserRepository repository})
      : _repository = repository;

  @override
  Future<User?> delete(int id) async {
    final order = await getById(id);

    if (order == null) {
      return null;
    }

    final deleted = await _repository.delete(id);
    if (!deleted) {
      return null;
    }
    return order;
  }

  @override
  Future<List<User>?> getAll() => _repository.getAll();

  @override
  Future<User?> getById(int id) => _repository.getById(id);

  @override
  Future<User?> save(User order) async {
    final saved = await _repository.save(order);
    if (saved == null) {
      return null;
    }
    return getById(saved);
  }

  @override
  Future<User?> update(int id, {required Map<String, dynamic> data}) async {
    final order = await getById(id);
    if (order == null) {
      return null;
    }
    final newOrder = order.updateMap(data).copyWith(updatedAt: DateTime.now());
    final update = await _repository.update(id, newOrder);
    if (!update) {
      return null;
    }
    return getById(id);
  }
}
