import 'package:flutter/material.dart';

import '../../data/entrega_service.dart';

class RastreoEntrega extends StatefulWidget {
  const RastreoEntrega({super.key});

  @override
  State<RastreoEntrega> createState() => _RastreoEntregaState();
}

class _RastreoEntregaState extends State<RastreoEntrega> {
  late final Stream<int> _entregaStream = EntregaService().rastrearEntrega();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _entregaStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Ocurrió un error al rastrear tu entrega.');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Conectando con el GPS...');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const Text('¡Pedido entregado!');
        }
        if (snapshot.hasData) {
          return Text('Tu pedido llega en ${snapshot.data} min');
        }
        return const Text('Conectando con el GPS...');
      },
    );
  }
}
