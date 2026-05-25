import 'package:shared_preferences/shared_preferences.dart';

class PushLocalStorage {
  static const _documentIdKey = 'gosport_device_document_id';

  Future<void> saveDocumentId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_documentIdKey, id);
  }

  Future<String?> getDocumentId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_documentIdKey);
  }

  Future<void> clearDocumentId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_documentIdKey);
  }
}
