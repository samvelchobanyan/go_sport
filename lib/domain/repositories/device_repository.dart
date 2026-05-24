abstract interface class DeviceRepository {
  Future<String?> findByToken(String token);

  Future<String> register({required String token, required String platform});

  Future<void> delete(String documentId);
}
