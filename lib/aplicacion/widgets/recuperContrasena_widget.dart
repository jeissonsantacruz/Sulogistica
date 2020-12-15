  import 'dart:async';
import 'package:flutter/material.dart';
// Plugins
import 'package:webview_flutter/webview_flutter.dart';

import 'appBar_widget.dart';

// Clase que crea un Web view para recuperar la contraseña

class RecuperarContrasena extends StatelessWidget {
  final Completer<WebViewController> _controller =Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onPressed: (){
          Navigator.of(context).pop();
        },
      ),
      body: WebView(
        initialUrl: 'https://www.su-web.net/vistas/dsbqusuario.html?vers=1.1',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      )
    );
  }
}