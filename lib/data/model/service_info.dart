class ServiceInfo {
  ServiceInfo({
    required this.pendingTotal,
    required this.pendingInvoice,
    this.lastEnty,
  });

  double pendingTotal;
  late DateTime? lastEnty;
  double pendingInvoice;
}
