import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacionesService {
  // Mantiene una única instancia del servicio para toda la aplicación.
  factory NotificacionesService() => instancia;

  NotificacionesService._();

  static final NotificacionesService instancia = NotificacionesService._();
  final FlutterLocalNotificationsPlugin _notificaciones =
      FlutterLocalNotificationsPlugin();

  // Configura las notificaciones para Android y solicita permiso al usuario.
  Future<void> inicializar() async {
    const ajustesAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const ajustes = InitializationSettings(android: ajustesAndroid);

    await _notificaciones.initialize(settings: ajustes);
    await _notificaciones
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  // Muestra la confirmación de compra con prioridad para un aviso Heads-up.
  Future<void> mostrarNotificacionCompra(double totalPagado) async {
    const detallesAndroid = AndroidNotificationDetails(
      'canal_ecomarket_pedidos',
      'Confirmación de Pedidos',
      importance: Importance.max,
      priority: Priority.high,
    );
    const detalles = NotificationDetails(android: detallesAndroid);

    await _notificaciones.show(
      id: 0,
      title: 'Compra confirmada',
      body: 'Total pagado: \$${totalPagado.toStringAsFixed(2)}',
      notificationDetails: detalles,
    );
  }
}
