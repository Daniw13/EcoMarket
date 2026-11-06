class Producto {
  final String id;
  final String nombre;
  final String categoria;
  final String imagenUrl;
  final double precio;
  final int stock;

  const Producto({
    required this.id,
    required this.nombre,
    required this.categoria,
    required this.imagenUrl,
    required this.precio,
    required this.stock,
  }) : assert(precio >= 0, 'El precio no puede ser negativo.'),
       assert(stock >= 0, 'El stock no puede ser negativo.');

  bool get agotado => stock == 0;

  Producto copyWith({int? stock}) {
    return Producto(
      id: id,
      nombre: nombre,
      categoria: categoria,
      imagenUrl: imagenUrl,
      precio: precio,
      stock: stock ?? this.stock,
    );
  }
}
