class AppConfig {
  static const String ip = '192.168.100.211';
  static const String port = '3000';

  static String get baseUrl => 'http://$ip:$port';
}
