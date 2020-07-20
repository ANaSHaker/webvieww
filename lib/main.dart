
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_splash/flutter_splash.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home: splassh(),
    );
  }
}

class splassh extends StatefulWidget {
  @override
  _splasshState createState() => _splasshState();
}

class _splasshState extends State<splassh> {
  @override
  Widget build(BuildContext context) {
    return  Splash(
      seconds: 3,
      navigateAfterSeconds:MyHomePage() ,
      image: Image.asset("assets/logo.png"),
      backgroundColor: Colors.black,
      photoSize: 100,
      loaderColor: Colors.white,
      loadingText: Text("one team mix",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState(){

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    FirebaseAdMob.instance.initialize(appId:"ca-app-pub-1297925267764389~1213699770");
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show(anchorType: AnchorType.bottom,horizontalCenterOffset: 10,anchorOffset: 80);

  }
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Development','Programming'],
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-1569716075637508/9164231587",
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: "ca-app-pub-1569716075637508/7818811589",
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
        });
  }



  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("one team mix"),
          centerTitle: true,
          backgroundColor: Colors.grey.shade900,
          elevation: 10,
          actions: [
            IconButton(
                color: Colors.white,
                icon: Icon(Icons.share),
                onPressed:() {
                  createInterstitialAd()
                    ..load()
                    ..show();
                  Share.share(
                      "Hey! Check out this app on Playstore. Movienator is a Movie and TV Shows Database app. If you love the app please review the app on playstore and share it with your friends. https://play.google.com/store/apps/details?id=com.example.moviegriller");
                }),],
    leading: Container(
    width: 100,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [

    IconButton(
    color: Colors.white,
    icon: Icon(Icons.star),

    onPressed: (){
      createInterstitialAd()
        ..load()
        ..show();
    LaunchReview.launch();
    },
    ),
    ],
    ),
    ),


    ),

    body:     MyPlaceholderWidget('https://www.youtube.com/channel/UCwabSoObZ0xUDoeJOtp5vBA?view_as=subscriber'),



    );
    }
  }



class MyPlaceholderWidget extends StatelessWidget {

  var url = 'https://www.youtube.com/channel/UCwabSoObZ0xUDoeJOtp5vBA?view_as=subscriber'  ;
  final key = UniqueKey();

  MyPlaceholderWidget(String url){
    this.url = url ;
  }

  @override
  Widget build(BuildContext context) {

    return WebView(
        key: key,
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: url,
        onWebViewCreated: (WebViewController webViewController){
        });


  }



}