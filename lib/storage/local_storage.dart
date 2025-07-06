import 'package:hive/hive.dart';

class LocalStorage {
  static final _box = Hive.box('chatBox');

  static List<Map<String, dynamic>> getMessages() {
    final raw = _box.get('messages', defaultValue: []);

    // Safe conversion from dynamic list to List<Map<String, dynamic>>
    if (raw is List) {
      return raw
          .whereType<Map>() // filter only map items
          .map((item) => Map<String, dynamic>.from(
          item.map((key, value) => MapEntry(key.toString(), value))))
          .toList();
    } else {
      return [];
    }
  }

  static void saveMessage(String msg, bool isUser) {
    final messages = getMessages();
    messages.add({'msg': msg, 'isUser': isUser});
    _box.put('messages', messages);
  }

  static void deleteAll() {
    _box.put('messages', []);
  }
}
