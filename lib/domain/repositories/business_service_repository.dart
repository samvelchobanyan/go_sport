import '../entities/business_service.dart';

abstract interface class BusinessServiceRepository {
  Future<List<BusinessService>> getServices();
}
