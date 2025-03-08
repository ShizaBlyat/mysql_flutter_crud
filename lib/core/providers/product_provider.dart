import 'package:Control_de_Empleados/data/source/product_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product_models.dart';

final productControllerProvider =
    StateNotifierProvider<ProductController, AsyncValue<List<Product>>>(
  (ref) => ProductController(ref),
);

final productsProvider = productControllerProvider;
