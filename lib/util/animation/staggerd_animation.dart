import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StaggeredAnimation {
  StaggeredAnimation._();


  //todo this widget will take  widget like this // [  Column , ListView  , GridView]
  static Widget routAnimationWidget({Widget? child}){
    return AnimationLimiter(child: child!);
  }//end

  //todo this will be inside the #routAnimationWidget children
  //todo this widget will take list of widget like this // [ Row , Column , btn  , txt]
  static List<Widget>? columnAnimation( {List<Widget>? child}) {
    return AnimationConfiguration.toStaggeredList(
      duration: const Duration(milliseconds: 375),
      childAnimationBuilder: (widget) => SlideAnimation(
        horizontalOffset: 50.0,
        child: FadeInAnimation(
          child: widget,
        ),
      ),
      children: child!,
    );
  }//end


  //todo this will be inside the #routAnimationWidget children
  //todo this widget will take  widget like grid view component and column count and index
  static gridViewAnimation({Widget? child , int? index , int? columnCount}){
    return AnimationConfiguration.staggeredGrid(
      position: index!,
      duration: const Duration(milliseconds: 375),
      columnCount: columnCount!,
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: child!,
        ),
      ),
    );
  }//end

  //todo this will be inside the #routAnimationWidget children
  //todo this widget will take  widget like  view component and index
  static listViewAnimation({Widget? child , int? index}){
    return AnimationConfiguration.staggeredList(
      position: index!,
      duration:  Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: child!,
        ),
      ),
    );
  }//end


}
