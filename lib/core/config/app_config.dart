enum AppEnv { dev, prod }

class AppConfig {
  final AppEnv env;
  final String apiBaseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final bool enableLogging;

  const AppConfig._({
    required this.env,
    required this.apiBaseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.enableLogging,
  });

  static const dev = AppConfig._(
    env: AppEnv.dev,
    // apiBaseUrl: 'http://37.157.212.21:1338/', //Samo
    apiBaseUrl: 'http://192.168.1.4:1338', //Anna
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    enableLogging: true,
  );

  static const prod = AppConfig._(
    env: AppEnv.prod,
    apiBaseUrl: 'https://api.gosport.com/v1',
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 15),
    enableLogging: false,
  );
}
