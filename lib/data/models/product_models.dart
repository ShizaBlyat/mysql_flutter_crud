class Product {
  final int? id;
  final String name;
  final String position;
  final double salary;
  final String department;
  final String description;

  Product({
    this.id,
    required this.description,
    required this.name,
    required this.position,
    required this.salary,
    required this.department,
  });

  // Método para convertir el objeto a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'salary': salary,
      'department': department,
      'description': description,
    };
  }

  // Método para crear un objeto Product desde un mapa (JSON)
  factory Product.fromJson(Map<String, dynamic> item) {
    return Product(
      id: item['id'],
      name: item['name'],
      position: item['position'],
      salary: (item['salary'] as num).toDouble(),
      department: item['department'], 
      description: '',
    );
  }
}
