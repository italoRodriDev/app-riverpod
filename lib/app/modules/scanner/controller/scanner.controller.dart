import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_document_scanner/google_mlkit_document_scanner.dart';

class ScannerController {
  DocumentScanner? _documentScanner;
  DocumentScanningResult? _result;

  void startScan(DocumentFormat format) async {
    try {
      _result = null;
      _documentScanner?.close();
      _documentScanner = DocumentScanner(
        options: DocumentScannerOptions(
          documentFormat: format,
          mode: ScannerMode.full,
          isGalleryImport: false,
          pageLimit: 1,
        ),
      );
      _result = await _documentScanner?.scanDocument();
      print('result: $_result');
    } catch (e) {
      print('Error: $e');
    }
  }
}

final scannerProvider = Provider((ref) => ScannerController());
