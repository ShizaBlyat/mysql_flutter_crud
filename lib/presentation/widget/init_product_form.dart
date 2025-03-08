import 'package:Control_de_Empleados/data/models/product_models.dart';
import 'package:flutter/material.dart';

//Load initState in show modal product for edit product
void initializeProductForm({
  required bool isEditMode,
  Product? editedProduct,
  required TextEditingController codeController,
  required TextEditingController descriptionController,
  required TextEditingController priceController,
  required TextEditingController quantityController,
}) {
  if (isEditMode && editedProduct != null) {
    descriptionController.text = editedProduct.description.toString();
    priceController.text = editedProduct.salary.toString();
  }
}
