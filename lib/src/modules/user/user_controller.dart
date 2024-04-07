import 'dart:convert';

import 'package:api/src/core/developer/developer.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../data/model/user.dart';
import '../../services/user_service.dart';

class UserController {
  final UserService _service;

  UserController({required UserService service}) : _service = service;

  final headers = {'Content-Type': 'text/json'};

  Future<Response> getAll(Request request) async {
    final user = await _service.getAll();
    final list = [];

    if (user != null) {
      for (var order in user) {
        list.add(order.toMap());
      }
      var body = json.encode(list);
      return Response.ok(body, headers: headers);
    }
    return Response.notFound('Pedidos não encontrado', headers: headers);
  }

  Future<Response> getById(Request request) async {
    try {
      final id = int.parse(request.params['id'].toString());
      final order = await _service.getById(id);

      if (order != null) {
        return Response.ok(order.toJson(), headers: headers);
      } else {
        return Response.notFound('Pedido $id, não encontrado',
            headers: headers);
      }
    } catch (e, s) {
      Developer.logError(
          errorText: 'Erro ao carregar produto',
          error: e,
          stackTrace: s,
          errorName: runtimeType.toString());
      return Response.internalServerError(body: 'ID não encontrado');
    }
  }

  Future<Response> save(Request request) async {
    final data = await request.readAsString();
    final order = User.fromJson(data);
    final useraved = await _service.save(order);

    if (useraved == null) {
      return Response.internalServerError(body: 'Erro ao salvar Pedido');
    }
    return Response.ok(useraved.toJson(), headers: headers);
  }

  Future<Response> delete(Request request) async {
    final id = int.parse(request.params['id'].toString());
    final orderDeleted = await _service.delete(id);

    if (orderDeleted == null) {
      return Response.internalServerError(body: 'Erro ao deletar pedido');
    }
    return Response.ok(orderDeleted.toJson(), headers: headers);
  }

  Future<Response> update(Request request) async {
    final body = await request.readAsString();
    final id = int.parse(request.params['id'].toString());
    final order = await _service.update(id, data: json.decode(body));
    // return Response.ok(order.toJson(), headers: headers);
    return Response.ok(order?.toJson());
  }
}
