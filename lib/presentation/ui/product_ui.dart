import 'package:Control_de_Empleados/core/providers/product_provider.dart';
import 'package:Control_de_Empleados/data/models/product_models.dart';
import 'package:Control_de_Empleados/presentation/widget/show_modal_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widget/product_list_tile.dart';

class ProductUi extends ConsumerStatefulWidget {
  const ProductUi({super.key});

  @override
  ProductUiState createState() => ProductUiState();
}

class ProductUiState extends ConsumerState<ProductUi> {
  @override
  void initState() {
    super.initState();
    ref.read(productControllerProvider.notifier).reloadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Empleados'), 
        actions: [
          ElevatedButton(
            onPressed: () {
              //Call widget functions for add new product or edit
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return ShowModalProduct(
                    onAdd: (name, position, salary, description) async {
                      final newProduct = Product(
                        id: null,
                        name: '', 
                        position: '', 
                        salary: 0.0, 
                        department: '', 
                        description: '',
                      );
                      await ref
                          .read(productControllerProvider.notifier)
                          .addProduct(newProduct);
                    },
                  );
                },
              );
            },
            child: const Text('Agregar Empleado'),
          ),
        ],
      ),
      body: products.when(
        loading: () {
          return const CircularProgressIndicator();
        },
        error: (error, stackTrace) => Text('Error: $error'),
        data: (productList) {
          // Load list products in a ListView
          return ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              final product = productList[index];
              return ProductTile(product: product);
            },
          );
        },
      ),
    );
  }
}
