import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectWithUs extends StatelessWidget {
  const ConnectWithUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const Center(
                child: Text(
              'Connect with us ',
              style: TextStyle(color: Colors.black, fontSize: 18),
            )),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                      height: 65.0,
                      width: 65.0,
                      child: Center(
                        child: IconButton(
                            onPressed: () async {
                              {
                                const url =
                                    'https://stackxsolutions.in/';
                                openBrowerURL(url: url, inApp: false);
                              }
                            },
                            icon: const Icon(
                              FontAwesomeIcons.globe,
                              color: Colors.blue,
                              size: 35,
                            )),
                      )),
                  SizedBox(
                      height: 65.0,
                      width: 65.0,
                      child: Center(
                        child: IconButton(
                            onPressed: () async {
                             openwhatsapp();
                            },
                            icon: const Icon(
                              FontAwesomeIcons.whatsappSquare,
                              color: Colors.green,
                              size: 35,
                            )),
                      )),
                  SizedBox(
                      height: 65.0,
                      width: 65.0,
                      child: Center(
                        child: IconButton(
                            onPressed: () async {
                              {
                                const url =
                                    'https://in.linkedin.com/company/stackxapps/';
                                openBrowerURL(url: url, inApp: false);
                              }
                            },
                            icon: const Icon(
                              FontAwesomeIcons.linkedin,
                              color: Colors.blue,
                              size: 35,
                            )),
                      )),
                ],
              ),
            ),
          ]),
    );
  }
  openwhatsapp() async{
  var whatsapp ="+917018036347";
  var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
  var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
  

  
    // android , web
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
    //  print('no whatsapp installed');
    }


  

}

  Future openBrowerURL({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }
}
