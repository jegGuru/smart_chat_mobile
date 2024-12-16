
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:smart_chat/services/doc_service.dart';

class FileProvider with ChangeNotifier {
  final _docService = DocService();
  bool _isLoading = false;
  String? _error;
  double _uploadProgress = 0;

  bool get isLoading => _isLoading;
  String? get error => _error;
  double get uploadProgress => _uploadProgress;

  Future<void> uploadFile() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
      );

      if (result != null) {
        final file = result.files.first;
        await _docService.uploadDoc(
          file: file,
          onProgress: (progress) {
            _uploadProgress = progress;
            notifyListeners();
          },
        );
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
