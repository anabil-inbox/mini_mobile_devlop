import 'package:flutter/cupertino.dart';

//todo this for slide <---> page animation right to left
class SlideAnimation extends PageRouteBuilder {
  final page;

  SlideAnimation({this.page})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(1, 0);
              var end = Offset.zero;
              var tween = Tween(begin: begin, end: end);
             // var offsetAnmiation = animation.drive(tween);
              var curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInBack);
              return SlideTransition(
                position: /*offsetAnmiation*/ tween.animate(curvedAnimation),
                child: child,
              );
            });

  //todo this for scaling page animation size page
  SlideAnimation.scalesAnimation({this.page})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var tween = Tween(begin: begin, end: end);
              var curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInBack);
              return ScaleTransition(
                scale: tween.animate(curvedAnimation),
                child: child,
              );
            });

  //todo this for rotate page animation size page
  SlideAnimation.rotationsAnimation({this.page})
      : super(
            pageBuilder: (context, animation, secondaryAnimation) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0; //todo this we use it to rotate page 0 / 0.9
              var tween = Tween(begin: begin, end: end);
              var curvedAnimation =
                  CurvedAnimation(parent: animation, curve: Curves.linear);
              return RotationTransition(
                turns: tween.animate(curvedAnimation),
                child: child,
              );
            });

  //todo this for Size page animation size page
  SlideAnimation.sizeAnimation({this.page})
      : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ));
      });


  //todo this for fade page animation size page // like open image in face
  SlideAnimation.fadeAnimation({this.page})
      : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      });


  //todo this for curve and scale page animation s
  SlideAnimation.curveScaleAnimation({this.page})
      : super(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        var begin = 0.0;
        var end = 1.0; //todo this we use it to rotate page 0 / 0.9
        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
            parent: animation, curve: Curves.linearToEaseOut);
        return ScaleTransition(
          scale: tween.animate(curvedAnimation),
          child: RotationTransition(
            turns: tween.animate(curvedAnimation),
            child: child,
          ),
        );
      });
}





