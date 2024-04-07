//* nessa classe de modelo, foi obrigatorio realizar muitas modificações, por causa do DataClassGenerate

import 'dart:convert';

import '../../enum/order_status.dart';

class User {
  final int? id;
  final String name;
  final String address;
  final String orderId;
  final double orderTotal;
  final String provider;
  final String orderProviderId;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({
    this.id,
    required this.name,
    required this.address,
    required this.orderId,
    required this.orderTotal,
    required this.provider,
    required this.orderProviderId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? address,
    String? orderId,
    double? orderTotal,
    String? provider,
    String? orderProviderId,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        orderId: orderId ?? this.orderId,
        orderTotal: orderTotal ?? this.orderTotal,
        provider: provider ?? this.provider,
        orderProviderId: orderProviderId ?? this.orderProviderId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'orderId': orderId,
      'orderTotal': orderTotal,
      'provider': provider,
      'orderProviderId': orderProviderId,
      'status': status.index,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  //! outra coisa importente, foi a criação do toDataBase e updateMap, pois isso não é algo que tem, e sim que precisamos criar

  Map<String, dynamic> toDataBase() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
      'order_id': orderId,
      'order_total': orderTotal,
      'provider': provider,
      'order_provider_id': orderProviderId,
      'status': status.index,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      //* aqui no id foi realizado uma verificação do mesmo o parser do dataclass não resolveu o problema
      id: (map['id'] == null) ? null : int.parse(map['id'].toString()),
      name: map['name'] as String,
      address: map['address'] as String,
      orderId: map['order_id'] as String,
      orderTotal: double.parse(map['order_total'].toString()),
      provider: map['provider'] as String,
      orderProviderId: map['order_provider_id'] as String,
      //* aqui no status, foi realizado uma busca pelo firstWhere
      status: OrderStatus.values.firstWhere(
          (orderStatus) =>
              orderStatus.index == int.parse(map['status'].toString()),
          orElse: () => OrderStatus.iniciado),
      createdAt: (map['created_at'] == null)
          ? DateTime.now()
          : DateTime.parse(map['created_at']),
      updatedAt: (map['updated_at'] == null)
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User updateMap(Map<String, dynamic> data) {
    return User(
      id: id,
      name: data['name'] ?? name,
      address: data['address'] ?? address,
      orderId: data['order_id'] ?? orderId,
      orderTotal: data['order_total'] ?? orderTotal,
      provider: data['provider'] ?? provider,
      orderProviderId: data['order_provider_id'] ?? orderProviderId,
      status: OrderStatus.values.firstWhere(
        (orderStatus) =>
            orderStatus.index == (int.tryParse(data['status'].toString())),
        orElse: () => OrderStatus.iniciado,
      ),
      createdAt: data['created_at'] ?? createdAt,
      updatedAt: data['updated_at'] ?? updatedAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, address: $address, order_id: $orderId, order_total: $orderTotal, provider: $provider, order_provider_id: $orderProviderId, status: $status, created_at: $createdAt, updated_at: $updatedAt)';
  }
}
