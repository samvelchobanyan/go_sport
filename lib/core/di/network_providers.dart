import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/network/api_client.dart';

final apiClientProvider = Provider<ApiClient>((_) => 
  throw UnimplementedError('apiClientProvider must be overridden in ProviderScope'));