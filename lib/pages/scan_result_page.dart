import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartfiber/components/button/custom_button.dart';
import 'package:smartfiber/pages/home_layout_page.dart';
import 'package:smartfiber/pages/smart_scan_page.dart';

class ScanResultPage extends StatefulWidget {
  const ScanResultPage({super.key, this.tag, this.imagePath});

  final File? imagePath;
  final String? tag;

  @override
  State<ScanResultPage> createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  bool isUploading = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey();

  Future<void> handleUpload() async {
    if (!mounted) return;

    setState(() => isUploading = true);

    try {
      await Future.delayed(const Duration(seconds: 5));

      if (!mounted) return;

      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(
            backgroundColor: HSLColor.fromColor(Theme.of(context).colorScheme.primary)
                .withSaturation(1)
                .toColor(),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 150, // Positions near top
            ),
            content: Text("File has been uploaded")),
      );
    } catch (e) {
      debugPrint('Upload error: $e');
    } finally {
      if (mounted) {
        setState(() => isUploading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Scan Result"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Result",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Hero(
                  tag: widget.tag ?? widget.imagePath!.path,
                  child: SizedBox(
                    height: 240,
                    width: 240,
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.file(
                        widget.imagePath!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "${DateFormat("MMMM dd, yyyy").format(DateTime.now())} - ${DateFormat("HH:mm aa").format(DateTime.now())}",
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      _buildInfoRow("Grade:", "JK: (Hand Strip)"),
                      _buildInfoRow("Local Name:", "Bakbak"),
                      _buildInfoRow("Price:", "Php 45.00"),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3 * 8.0),
                  child: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    alignment: WrapAlignment.center,
                    runSpacing: 8 * 3,
                    children: [
                      CustomButton(
                        isLoading: isUploading,
                        onPress: handleUpload,
                        label: "Upload to cloud storage",
                        type: CustomButtonType.primary,
                      ),
                      const SizedBox(width: 8),
                      CustomButton(
                        onPress: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const SmartScanPage()),
                        ),
                        label: "Retry",
                        type: CustomButtonType.secondary,
                      ),
                      CustomButton.ghost(
                        context: context,
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => HomeLayoutPage()),
                        ),
                        label: "Done",
                        // type: CustomButtonType.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
