import 'package:Control_de_Empleados/data/models/product_models.dart';
import 'package:Control_de_Empleados/presentation/widget/action_button.dart';
import 'package:Control_de_Empleados/presentation/widget/init_product_form.dart';
import 'package:flutter/material.dart';
import 'custom_text_field.dart';

//Add product + Edit product call from product_ui
class ShowModalProduct extends StatefulWidget {
  final void Function(String, String, double, int) onAdd;
  final bool isEditMode;
  final Product? editedProduct;

  const ShowModalProduct({
    super.key,
    required this.onAdd,
    this.isEditMode = false,
    this.editedProduct,
  });

  @override
  ShowModalProductState createState() => ShowModalProductState();
}

class ShowModalProductState extends State<ShowModalProduct> {
  final TextEditingController codeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeProductForm(
      isEditMode: widget.isEditMode,
      editedProduct: widget.editedProduct,
      codeController: codeController,
      descriptionController: descriptionController,
      priceController: priceController,
      quantityController: quantityController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        CustomTextField(
          label: 'Nombre',
          controller: codeController,
        ),
        CustomTextField(
          label: 'Descripción',
          controller: descriptionController,
        ),
        CustomTextField(
          label: 'Salario',
          controller: priceController,
          keyboardType: TextInputType.number,
        ),
        CustomTextField(
          label: 'Puesto',
          controller: quantityController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        ActionButtons(
          onAdd: () {
            widget.onAdd(
              codeController.text,
              descriptionController.text,
              double.parse(priceController.text),
              int.parse(quantityController.text),
            );
            Navigator.pop(context);
          },
          isEditMode: widget.isEditMode,
        ),
      ],
    );
  }
}
