# Eco Market Verity :)

Aplicación móvil de ejemplo para explorar productos ecológicos, filtrar el catálogo por categoría, añadir artículos al carrito y completar un checkout. Incluye una simulación asíncrona de carga de productos y rastreo de entrega, además de una paleta personalizada con Material 3.

## Funcionalidades

- Catálogo de productos con imágenes, precios y stock disponible.
- Filtros para mostrar todas las categorías o una categoría específica.
- Carrito con cálculo del total y validación de stock al confirmar la compra.
- Reabastecimiento de inventario desde el catálogo.
- Formulario de checkout con validación de nombre, correo, teléfono y dirección.
- Simulación de carga de productos y rastreo de entrega sin bloquear la interfaz.

## Arquitectura

El código Dart está organizado por capas:

- `lib/domain/entities/`: entidades del dominio, como `Producto`.
- `lib/data/`: productos de ejemplo y servicio de entrega simulado.
- `lib/presentation/controllers/`: estado del catálogo y reglas del carrito.
- `lib/presentation/views/`: catálogo y checkout.
- `lib/presentation/widgets/`: tarjetas de productos y rastreo de entrega.

## Requisitos

- Flutter SDK compatible con la versión indicada en `pubspec.yaml`.
- Android Studio o un dispositivo/emulador Android para ejecutar la app.

## Ejecutar

```bash
flutter pub get
flutter run
```

Para analizar el proyecto:

```bash
flutter analyze
```
