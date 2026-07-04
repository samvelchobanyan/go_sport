import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/core/network/network_error_service.dart';

final apiClientProvider = Provider<ApiClient>((_) =>
  throw UnimplementedError('apiClientProvider must be overridden in ProviderScope'));

final networkErrorServiceProvider = Provider<NetworkErrorService>((_) =>
  throw UnimplementedError('networkErrorServiceProvider must be overridden in ProviderScope'));

final networkErrorProvider = StreamProvider<NetworkErrorKind>((ref) =>
  ref.watch(networkErrorServiceProvider).onError);