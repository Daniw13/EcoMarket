import 'package:flutter/material.dart';

import 'data/entrega_service.dart';
import 'domain/entities/producto.dart';
import 'presentation/controllers/catalogo_controller.dart';
import 'presentation/views/catalogo_view.dart';
import 'presentation/views/checkout_view.dart';
import 'presentation/widgets/rastreo_entrega.dart';

const _azulPetroleo = Color(0xFF2C4251);
const _verdeBosque = Color(0xFF3F612D);
const _crema = Color(0xFFFFEEDB);
const _terracota = Color(0xFF994636);
const _verdeSalvia = Color(0xFF619B8A);
const _oliva = Color(0xFF767522);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final Future<List<Producto>> _productosFuture = EntregaService()
      .obtenerProductos();
  CatalogoController? _controller;
  bool _mostrarRastreo = false;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Market Dani',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: _verdeBosque,
          onPrimary: _crema,
          secondary: _terracota,
          onSecondary: _crema,
          tertiary: _azulPetroleo,
          onTertiary: _crema,
          surface: _crema,
          onSurface: _verdeBosque,
          error: _terracota,
          onError: _crema,
          outline: _oliva,
          outlineVariant: _oliva,
        ),
        scaffoldBackgroundColor: _crema,
        appBarTheme: const AppBarTheme(
          backgroundColor: _azulPetroleo,
          foregroundColor: _crema,
        ),
        cardTheme: const CardThemeData(color: _crema),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: _verdeSalvia,
          foregroundColor: _crema,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _oliva),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _azulPetroleo, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _terracota),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _terracota, width: 2),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: _azulPetroleo,
          contentTextStyle: TextStyle(color: _crema),
        ),
      ),
      home: FutureBuilder<List<Producto>>(
        future: _productosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(
                  'No se pudieron cargar los productos: ${snapshot.error}',
                ),
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: Text('No hay productos disponibles.')),
            );
          }

          final controller = _controller ??= CatalogoController(
            productos: snapshot.data!,
          );
          return ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return Scaffold(
                body: CatalogoView(
                  productos: controller.productosFiltrados,
                  categorias: controller.categorias,
                  categoriaSeleccionada: controller.categoriaSeleccionada,
                  onAgregar: controller.agregarAlCarrito,
                  onSeleccionarCategoria: controller.filtrarPorCategoria,
                  onReabastecer: controller.reabastecer,
                ),
                bottomNavigationBar: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_mostrarRastreo) ...[
                          const RastreoEntrega(),
                          const SizedBox(height: 8),
                        ],
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (checkoutContext) => CheckoutView(
                                    total: controller.total,
                                    onConfirmar: () {
                                      if (!controller.confirmarCompra()) {
                                        ScaffoldMessenger.of(
                                          checkoutContext,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: const Text(
                                              'No hay stock suficiente para completar la compra.',
                                            ),
                                            action: SnackBarAction(
                                              label: 'Rellenar Stock',
                                              onPressed: controller.reabastecer,
                                            ),
                                          ),
                                        );
                                        return;
                                      }
                                      Navigator.of(checkoutContext).pop();
                                      setState(() => _mostrarRastreo = true);
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.shopping_cart_checkout),
                            label: Text(
                              'Ir a pagar (\$${controller.total.toStringAsFixed(2)})',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
