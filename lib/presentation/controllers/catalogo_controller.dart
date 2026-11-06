import 'package:flutter/foundation.dart';

import '../../domain/entities/producto.dart';

class CatalogoController extends ChangeNotifier {
  final List<Producto> _productos;
  final Map<String, int> _carrito = {};
  String? _categoriaSeleccionada;

  CatalogoController({required List<Producto> productos})
    : _productos = List<Producto>.of(productos);

  List<Producto> get productos => List<Producto>.unmodifiable(
    _productos.map(
      (producto) => producto.copyWith(
        stock: producto.stock - (_carrito[producto.id] ?? 0),
      ),
    ),
  );

  List<String> get categorias =>
      _productos.map((producto) => producto.categoria).toSet().toList();

  String? get categoriaSeleccionada => _categoriaSeleccionada;

  List<Producto> get productosFiltrados {
    final inventarioDisponible = productos;
    if (_categoriaSeleccionada == null) return inventarioDisponible;
    return inventarioDisponible
        .where((producto) => producto.categoria == _categoriaSeleccionada)
        .toList();
  }

  Map<String, int> get carrito => Map<String, int>.unmodifiable(_carrito);

  double get total {
    var resultado = 0.0;
    for (final producto in _productos) {
      resultado += producto.precio * (_carrito[producto.id] ?? 0);
    }
    return resultado;
  }

  void agregarAlCarrito(Producto producto) {
    final indice = _productos.indexWhere((item) => item.id == producto.id);
    if (indice == -1) return;
    final cantidadEnCarrito = _carrito[producto.id] ?? 0;
    if (cantidadEnCarrito >= _productos[indice].stock) return;

    _carrito.update(producto.id, (cantidad) => cantidad + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void filtrarPorCategoria(String? categoria) {
    if (_categoriaSeleccionada == categoria) return;
    _categoriaSeleccionada = categoria;
    notifyListeners();
  }

  bool confirmarCompra() {
    for (final entrada in _carrito.entries) {
      final indice = _productos.indexWhere(
        (producto) => producto.id == entrada.key,
      );
      if (indice == -1 || entrada.value > _productos[indice].stock) {
        return false;
      }
    }

    for (var indice = 0; indice < _productos.length; indice++) {
      final producto = _productos[indice];
      _productos[indice] = producto.copyWith(
        stock: producto.stock - (_carrito[producto.id] ?? 0),
      );
    }
    _carrito.clear();
    notifyListeners();
    return true;
  }

  void reabastecer() {
    for (var indice = 0; indice < _productos.length; indice++) {
      final producto = _productos[indice];
      _productos[indice] = producto.copyWith(stock: producto.stock + 10);
    }
    notifyListeners();
  }
}
