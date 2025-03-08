import 'package:Control_de_Empleados/core/providers/product_provider.dart';
import 'package:Control_de_Empleados/data/models/product_models.dart';
import 'package:Control_de_Empleados/presentation/widget/delete_product_widget.dart';
import 'package:Control_de_Empleados/presentation/widget/show_modal_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Call list products and buttons actions from producto_ui
class ProductTile extends ConsumerWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ListTile(
          title: Text(product.description),
          subtitle: Text('Salario: ${product.salary.toString()}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Image.asset('assets/images/pen.png'),
                iconSize: 24.0, // Ajusta el tamaño del ícono si es necesario
                onPressed: () async {
                  // Mostrar el modal de edición
                  await showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return ShowModalProduct(
                        onAdd: (name, position, salary, description) async {
                          final updatedProduct = Product(
                        id: null,
                        name: '', 
                        position: '', 
                        salary: 0.0, 
                        department: '', 
                        description: '',
                          );
                          await ref
                              .read(productControllerProvider.notifier)
                              .editProduct(product.id, updatedProduct);
                        },
                        isEditMode: true,
                        editedProduct: product,
                      );
                    },
                  );
                },
              ),
              DeleteProductButton(product: product),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
