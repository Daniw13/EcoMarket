import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacionesService {
  NotificacionesService._();

  static final NotificacionesService instance = NotificacionesService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(settings: initializationSettings);

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  Future<void> mostrarNotificacionCompra(double totalPagado) async {
    const androidDetails = AndroidNotificationDetails(
      'canal_ecomarket_pedidos',
      'Confirmación de Pedidos',
      channelDescription: 'Notificaciones de confirmacion de compras',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _plugin.show(
      id: 0,
      title: 'Compra confirmada',
      body: 'Tu pago de \$${totalPagado.toStringAsFixed(2)} fue procesado.',
      notificationDetails: notificationDetails,
    );
  }
}
