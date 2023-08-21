class CheckoutResponse {
  String? reference;
  bool success;

  CheckoutResponse({this.success = false, required this.reference});
}