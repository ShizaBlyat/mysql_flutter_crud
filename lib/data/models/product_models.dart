class Product {
  final int? id;
  final String? code;
  final String description;
  final double? price;
  final int? quantity;

  Product({
    this.id,
    this.code,
    required this.description,
    this.price,
    this.quantity,
  });

  // Método para convertir el objeto a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'price': price,
      'quantity': quantity
    };
  }
}
