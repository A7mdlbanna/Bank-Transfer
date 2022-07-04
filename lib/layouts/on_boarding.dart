import 'package:bank_app/shared/Network/local/cached_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gif_view/gif_view.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1C1C1E),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFF1C1C1E),
        child: Column(
          children: [
            const Expanded(child: GifView(image: AssetImage('assets/Crypto portfolio.gif'), loop: false, frameRate: 12,)),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Text('PARTNER', style: TextStyle(fontSize: 30, letterSpacing: 8.0, fontWeight: FontWeight.w300),),
            ),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
              child: Text('We Provide a penalty types of transfer features and fast, secure, and instant transfer', style: TextStyle(color: Color(0xFF626262), fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: TextButton(
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false);
                    CacheHelper.saveData('doneBoarding', true);
                  },
                  child: Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300), )),
            ),
          ],
        ),
      ),
    );
  }
}
