import 'package:flutter/material.dart';
import 'dart:html' as html; // For web-specific functionality
import 'package:flutter/services.dart' show rootBundle; // For accessing assets

class DownloadResumeButton extends StatelessWidget {
  const DownloadResumeButton({super.key});

  Future<void> _downloadResume(BuildContext context) async {
    try {
      // Load the PDF file from assets
      final bytes = await DefaultAssetBundle.of(
        context,
      ).load('assets/data/Debdaru_Dasgupta_3yoe_resume.pdf');
      final pdfData = bytes.buffer.asUint8List();

      final blob = html.Blob([pdfData]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor =
          html.AnchorElement(href: url)
            ..setAttribute(
              'download',
              'Debdaru_Dasgupta_3yoe_resume.pdf',
            ) // Set the file name for download
            ..click(); // Trigger the download
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      // Handle any errors (e.g., file not found)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error downloading resume: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _downloadResume(context),
      child: const Text('Download Resume'),
    );
  }
}
