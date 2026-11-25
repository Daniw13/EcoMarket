import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacionesService {
  static final NotificacionesService _instancia = NotificacionesService._();
  factory NotificacionesService() => _instancia;
  NotificacionesService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> inicializar() async {
    const androidAjustes = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ajustes = InitializationSettings(android: androidAjustes);

    await _plugin.initialize(settings: ajustes);
  }

  Future<void> mostrarNotificacionCompra(double totalPagado) async {
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.requestNotificationsPermission();

    const androidDetalles = AndroidNotificationDetails(
      'canal_ecomarket_pedidos',
      'Confirmación de Pedidos',
      channelDescription: 'Avisos de confirmación de compra',
      importance: Importance.max,
      priority: Priority.high,
    );

    await _plugin.show(
      id: 0,
      title: '¡Compra confirmada!',
      body: 'Total pagado: \$${totalPagado.toStringAsFixed(2)}',
      notificationDetails: const NotificationDetails(android: androidDetalles),
    );
  }
}
