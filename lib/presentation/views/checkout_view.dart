import 'package:flutter/material.dart';

class CheckoutView extends StatefulWidget {
  final double total;
  final VoidCallback onConfirmar;

  const CheckoutView({
    super.key,
    required this.total,
    required this.onConfirmar,
  });

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();

  void _confirmarPago() {
    if (_formKey.currentState!.validate()) {
      widget.onConfirmar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Total a pagar: \$${widget.total.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final nombre = value?.trim() ?? '';
                  if (nombre.length < 3) {
                    return 'Ingresa al menos 3 caracteres.';
                  }
                  if (!RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ ]+$').hasMatch(nombre)) {
                    return 'Usa solo letras y espacios.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final correo = value?.trim() ?? '';
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(correo)) {
                    return 'Ingresa un correo electrónico válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (!RegExp(r'^\d{10}$').hasMatch(value ?? '')) {
                    return 'Ingresa exactamente 10 dígitos.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if ((value?.trim().length ?? 0) < 10) {
                    return 'La dirección debe tener al menos 10 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _confirmarPago,
                child: const Text('Confirmar pago'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
