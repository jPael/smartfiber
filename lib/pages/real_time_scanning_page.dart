import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class RealTimeScanningPage extends StatefulWidget {
  const RealTimeScanningPage({super.key});

  @override
  RealTimeScanningPageState createState() => RealTimeScanningPageState();
}

class RealTimeScanningPageState extends State<RealTimeScanningPage> {
  late InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Real-time Scan"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri(
              "https://demo.roboflow.com/abaca-fiber-classification-yoklg-hwx5g/1?publishable_key=rf_sHDJ36qrcxOsoGblluznoTbsoT12"),
        ),
        androidOnPermissionRequest: (controller, origin, resources) async {
          return PermissionRequestResponse(
              resources: resources, action: PermissionRequestResponseAction.GRANT);
        },
        onWebViewCreated: (controller) {
          webView = controller;
        },
      ),
    );
  }
}
