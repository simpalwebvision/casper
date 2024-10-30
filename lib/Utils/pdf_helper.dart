import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';

class PdfApi {
  static Future<File> loadNetworkFile(String? url) async {
    final response = await http.get(Uri.parse(url!));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String? url, List<int>? bytes) async {
    final filename = path.basename(url!);
    final dir = await path_provider.getApplicationDocumentsDirectory();
    final file = File("${dir.path}/$filename");
    await file.writeAsBytes(bytes!, flush: true);
    return file;
  }

  Future<File> uint8ListToXFile(Uint8List uint8list, String fileName) async {
    // Get the temporary directory where we can save the file
    Directory tempDir = await getTemporaryDirectory();

    // Create a file path with the desired file name in the temp directory
    String filePath = '${tempDir.path}/$fileName';

    // Create a file at the path and write the Uint8List data to it
    File file = File(filePath);
    await file.writeAsBytes(uint8list);

    // // Create an XFile from the path of the file
    // XFile xFile = XFile(filePath);

    return file;
  }
}
