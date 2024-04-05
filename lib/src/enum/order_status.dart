enum OrderStatus {
  iniciado(label: 'Iniciado'),
  andamento(label: 'Andamento'),
  finalizado(label: 'Finalizado'),
  emRota(label: 'Em rota'),
  completo(label: 'Completo');

  final String label;
  const OrderStatus({required this.label});
}
