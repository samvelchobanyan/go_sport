import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/di/repository_providers.dart';
import '../entities/business_service.dart';
import '../repositories/business_service_repository.dart';

part 'business_services_state.freezed.dart';

@freezed
class BusinessServicesState with _$BusinessServicesState {
  const factory BusinessServicesState({
    @Default([]) List<BusinessService> services,
    @Default(false) bool isLoading,
    String? error,
  }) = _BusinessServicesState;
}

class BusinessServicesNotifier extends Notifier<BusinessServicesState> {
  late final BusinessServiceRepository _repository;

  @override
  BusinessServicesState build() {
    _repository = ref.watch(businessServiceRepositoryProvider);
    Future.microtask(loadServices);
    return const BusinessServicesState();
  }

  Future<void> loadServices() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final services = await _repository.getServices();
      state = state.copyWith(services: services, isLoading: false);
    } catch (error) {
      state = state.copyWith(isLoading: false, error: error.toString());
    }
  }

  BusinessService? getServiceById(String id) {
    try {
      return state.services.firstWhere(
        (service) =>
            service.documentId ==
            id, // Change `documentId` to `id` if named differently
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> refresh() async {
    await loadServices();
  }
}

final businessServicesStateProvider =
    NotifierProvider<BusinessServicesNotifier, BusinessServicesState>(
      BusinessServicesNotifier.new,
    );
