import 'package:eco_market/domain/entities/producto.dart';
import 'package:eco_market/presentation/controllers/catalogo_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatalogoController', () {
    test('inicia con el carrito vacío y total en cero', () {
      // ARRANGE
      final controller = CatalogoController(productos: const []);

      // ACT
      final totalArticulos = controller.carrito.values.fold<int>(
        0,
        (total, cantidad) => total + cantidad,
      );
      final montoTotal = controller.total;

      // ASSERT
      expect(controller.carrito, isEmpty);
      expect(totalArticulos, 0);
      expect(montoTotal, 0.0);
    });

    test('calcula los artículos y el monto de dos productos', () {
      // ARRANGE
      final productos = [
        const Producto(
          id: 'producto-1',
          nombre: 'Producto uno',
          categoria: 'Prueba',
          imagenUrl: '',
          precio: 12.5,
          stock: 5,
        ),
        const Producto(
          id: 'producto-2',
          nombre: 'Producto dos',
          categoria: 'Prueba',
          imagenUrl: '',
          precio: 3.25,
          stock: 5,
        ),
      ];
      final controller = CatalogoController(productos: productos);

      // ACT
      for (final producto in productos) {
        controller.agregarAlCarrito(producto);
      }
      final totalArticulos = controller.carrito.values.fold<int>(
        0,
        (total, cantidad) => total + cantidad,
      );

      // ASSERT
      expect(totalArticulos, 2);
      expect(controller.total, 15.75);
    });

    test('rechaza un producto con precio negativo', () {
      // ARRANGE
      // ACT
      Producto crearProductoInvalido() => Producto(
        id: 'producto-invalido',
        nombre: 'Producto inválido',
        categoria: 'Prueba',
        imagenUrl: '',
        precio: -1,
        stock: 1,
      );

      // ASSERT
      expect(crearProductoInvalido, throwsA(isA<AssertionError>()));
    });
  });
}
