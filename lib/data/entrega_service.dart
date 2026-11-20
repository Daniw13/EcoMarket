import '../domain/entities/producto.dart';
import 'productos_data.dart';

class EntregaService {
  Future<List<Producto>> obtenerProductos() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return productos;
  }

  Stream<int> rastrearEntrega() async* {
    for (var minutos = 10; minutos >= 0; minutos--) {
      yield minutos;
      if (minutos > 0) {
        await Future<void>.delayed(const Duration(seconds: 3));
      }
    }
  }
}
