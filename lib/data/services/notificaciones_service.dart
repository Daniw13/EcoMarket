import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificacionesService {
  // Constructor privado para impedir que se creen otras instancias.
  NotificacionesService._();

  // Permite usar el servicio de forma sencilla sin perder el patrón singleton.
  factory NotificacionesService() => instance;

  // Instancia única que comparte el resto de la aplicación.
  static final NotificacionesService instance = NotificacionesService._();

  // Plugin encargado de inicializar y mostrar las notificaciones locales.
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  // Configura el icono de Android y solicita permiso para enviar notificaciones.
  Future<void> init() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // Agrupa la configuración específica de Android.
    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    // Inicializa el plugin usando el nombre requerido por esta versión.
    await _plugin.initialize(settings: initializationSettings);

    // Solicita el permiso POST_NOTIFICATIONS en Android.
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  // Muestra la confirmación de una compra con el total pagado.
  Future<void> mostrarNotificacionCompra(double totalPagado) async {
    // Define el canal, nombre, importancia y prioridad de la notificación.
    const androidDetails = AndroidNotificationDetails(
      'canal_ecomarket_pedidos',
      'Confirmación de Pedidos',
      channelDescription: 'Notificaciones de confirmacion de compras',
      importance: Importance.max,
      priority: Priority.high,
    );

    // Contiene las opciones específicas que usará Android.
    const notificationDetails = NotificationDetails(android: androidDetails);

    // Publica la notificación con su identificador y datos de compra.
    await _plugin.show(
      id: 0,
      title: '¡Compra confirmada!',
      body: 'Total pagado: \$${totalPagado.toStringAsFixed(2)}',
      notificationDetails: notificationDetails,
    );
  }
}
