enum AppEnv { dev, prod }

class AppConfig {
  final AppEnv env;
  final String apiBaseUrl;
  final Duration connectTimeout;
  final Duration receiveTimeout;
  final bool enableLogging;
  final String googleWebClientId;

  const AppConfig._({
    required this.env,
    required this.apiBaseUrl,
    required this.connectTimeout,
    required this.receiveTimeout,
    required this.enableLogging,
    required this.googleWebClientId,
  });

  static const dev = AppConfig._(
    env: AppEnv.dev,
    apiBaseUrl: 'http://37.157.212.21:1338/', //Samo
    // apiBaseUrl: 'http://192.168.1.4:1338', //Anna
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    enableLogging: true,
    googleWebClientId:
        '442164065269-v8kmbe1colucrq818qvvcjlmqlj705ta.apps.googleusercontent.com',
  );

  static const prod = AppConfig._(
    env: AppEnv.prod,
    apiBaseUrl: 'https://api.gosport.com/v1',
    connectTimeout: Duration(seconds: 15),
    receiveTimeout: Duration(seconds: 15),
    enableLogging: false,
    googleWebClientId: '',
  );
}
