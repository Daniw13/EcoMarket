import 'package:eco_market/domain/entities/producto.dart';
import 'package:eco_market/presentation/controllers/catalogo_controller.dart';
import 'package:eco_market/presentation/views/catalogo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra el título y el badge vacío inicialmente', (
    tester,
  ) async {
    final controller = CatalogoController(productos: [_productoDePrueba()]);
    addTearDown(controller.dispose);

    await tester.pumpWidget(_catalogoApp(controller));

    expect(find.text('Eco Market Verity :)'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('actualiza el badge al agregar un producto', (tester) async {
    final controller = CatalogoController(productos: [_productoDePrueba()]);
    addTearDown(controller.dispose);

    await tester.pumpWidget(_catalogoApp(controller));
    await tester.tap(find.text('Agregar'));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}

Producto _productoDePrueba() {
  return const Producto(
    id: 'producto-prueba',
    nombre: 'Producto de prueba',
    categoria: 'Prueba',
    imagenUrl: '',
    precio: 12.5,
    stock: 3,
  );
}

Widget _catalogoApp(CatalogoController controller) {
  return MaterialApp(
    home: ListenableBuilder(
      listenable: controller,
      builder: (context, _) => CatalogoView(
        productos: controller.productosFiltrados,
        categorias: controller.categorias,
        categoriaSeleccionada: controller.categoriaSeleccionada,
        totalArticulos: controller.totalArticulos,
        onAgregar: controller.agregarAlCarrito,
        onSeleccionarCategoria: controller.filtrarPorCategoria,
        onReabastecer: controller.reabastecer,
      ),
    ),
  );
}
