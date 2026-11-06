import 'package:flutter/material.dart';

import '../../domain/entities/producto.dart';
import '../widgets/producto_card.dart';

class CatalogoView extends StatelessWidget {
  final List<Producto> productos;
  final List<String> categorias;
  final String? categoriaSeleccionada;
  final ValueChanged<Producto> onAgregar;
  final ValueChanged<String?> onSeleccionarCategoria;
  final VoidCallback onReabastecer;

  const CatalogoView({
    super.key,
    required this.productos,
    required this.categorias,
    required this.categoriaSeleccionada,
    required this.onAgregar,
    required this.onSeleccionarCategoria,
    required this.onReabastecer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 150,
            actions: [
              IconButton(
                onPressed: onReabastecer,
                tooltip: 'Reabastecer',
                icon: const Icon(Icons.refresh),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Eco Market Verity :)',
                style: TextStyle(color: Color(0xFFFFEEDB)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Todas'),
                    selected: categoriaSeleccionada == null,
                    onSelected: (_) => onSeleccionarCategoria(null),
                  ),
                  for (final categoria in categorias)
                    FilterChip(
                      label: Text(categoria),
                      selected: categoriaSeleccionada == categoria,
                      onSelected: (_) => onSeleccionarCategoria(categoria),
                    ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 250,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductoCard(
                  producto: productos[index],
                  onAgregar: onAgregar,
                ),
                childCount: productos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
