import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: 40,
              color: Colors.red[900],
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Image.asset(
                'assets/orta.png',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'İnternetiniz yok\nBu durumda duo bulamazsınız',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.grey[200]),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
