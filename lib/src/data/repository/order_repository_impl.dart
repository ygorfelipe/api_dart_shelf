import 'package:api/src/core/database/database.dart';
import 'package:api/src/data/model/order.dart';

import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final Database _database;

  OrderRepositoryImpl({
    required Database database,
  }) : _database = database;

  @override
  Future<List<Order>?> getAll() async {
    final data = await _database.getData("SELECT * FROM ORDERS");
    if (data != null) {
      return data.map<Order>((o) => Order.fromMap(o)).toList();
    }
    return null;
  }

  @override
  Future<Order?> getById(int id) async {
    final data =
        await _database.getUnique("SELECT * FROM ORDERS WHERE ID = $id");
    if (data != null) {
      return Order.fromMap(data);
    }
    return null;
  }

  @override
  Future<int?> save(Order order) async {
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
  Future<bool> update(int id, Order order) async {
    final updated =
        _database.update(tableName: 'ORDERS', value: order.toDataBase());
    return updated;
  }
}
