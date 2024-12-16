```dart
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smart_chat/utils/api.dart';

class DocService {
  final _api = Api();

  Future<void> uploadDoc({
    required PlatformFile file,
    required Function(double) onProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromBytes(
          file.bytes!,
          filename: file.name,
        ),
      });

      await _api.post(
        '/llmdocumentslist',
        data: formData,
        onSendProgress: (sent, total) {
          onProgress(sent / total);
        },
      );
    } catch (e) {
      throw 'Failed to upload document: $e';
    }
  }

  Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final response = await _api.get('/llmdocumentslist');
      return List<Map<String, dynamic>>.from(response.data['result']);
    } catch (e) {
      throw 'Failed to load documents: $e';
    }
  }

  Future<void> deleteDocument(String docId) async {
    try {
      await _api.post('/deletellmdocuments', data: {'doc_id': docId});
    } catch (e) {
      throw 'Failed to delete document: $e';
    }
  }
}
```