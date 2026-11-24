import 'package:eco_market/domain/entities/producto.dart';
import 'package:eco_market/presentation/controllers/catalogo_controller.dart';
import 'package:eco_market/presentation/views/checkout_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CatalogoController calcula el total real del carrito', () {
    final productos = [
      Producto(
        id: '1',
        nombre: 'Producto de prueba',
        categoria: 'Prueba',
        imagenUrl: '',
        precio: 12.5,
        stock: 3,
      ),
    ];
    final controller = CatalogoController(productos: productos);

    controller.agregarAlCarrito(controller.productos.first);
    controller.agregarAlCarrito(controller.productos.first);

    expect(controller.total, 25);
  });

  testWidgets('CheckoutView muestra el total del carrito', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: CheckoutView(total: 25, onConfirmar: () {})),
    );

    expect(find.text('Checkout'), findsOneWidget);
    expect(find.text('Total a pagar: \$25.00'), findsOneWidget);
    expect(find.text('Confirmar pago'), findsOneWidget);
  });
}
