class CheckoutResponse {
  String? reference;
  bool success;

  CheckoutResponse({this.success = false, required this.reference});

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      success: json['success'],
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (reference != null) {
      data['reference'] = reference;
    }
    return data;
  }
    
}