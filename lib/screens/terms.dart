import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Terms extends StatefulWidget {
  final bool hizmet;
  const Terms({Key? key, required this.hizmet}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? Colors.black : Colors.grey[200],
      // appBar: AppBar(
      //   leading: Container(),
      //   title: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       Image.asset(
      //         'assets/orta.png',
      //         height: 40,
      //         width: 60,
      //       ),
      //     ],
      //   ),
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      //   centerTitle: true,
      //   backgroundColor: context.isDarkMode ? Colors.grey[900] : Colors.white,
      // ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: widget.hizmet
                    ? WebView(
                        initialUrl:
                            'https://www.duogether.com/hizmet-sartlari.html',
                        javascriptMode: JavascriptMode.unrestricted,
                      )
                    : WebView(
                        initialUrl:
                            'https://www.duogether.com/gizlilik-politikasi.html',
                        javascriptMode: JavascriptMode.unrestricted,
                      ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Material(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Geri',
                            style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
