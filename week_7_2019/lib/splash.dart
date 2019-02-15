import 'package:flutter/material.dart';

class Splash extends StatefulWidget {

  final Widget child;
  final GestureTapCallback onTap;


  const Splash({Key key, this.child, this.onTap}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashState();
  }

}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{

  static const double minRadius = 50;
  static const double maxRadius = 120;

  AnimationController controller;
  Tween<double> radiusTween;
  Tween<double> borderWidthTween;
  Animation<double> radiusAnimation;
  Animation<double> borderWidthanimation;
  AnimationStatus status;
  Offset _tapPosition;

  @override
  void initState() {//changes here = restart
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 400))
    ..addListener(() {
    setState(() {});
    })
    ..addStatusListener((listener) {
      status = listener;
    });
    radiusTween = Tween<double>(begin: 0, end: 50);
    radiusAnimation = radiusTween.animate(CurvedAnimation(parent: controller, curve: Curves.ease));
    borderWidthTween = Tween<double>(begin: 25,end: 0);
    borderWidthanimation = borderWidthTween.animate(CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  void _animate(){
    controller.forward(from: 0);
  }

  void _handleTap(TapUpDetails tapDetails){
    RenderBox renderBox = context.findRenderObject();
    _tapPosition = renderBox.globalToLocal(tapDetails.globalPosition);
    double radius = (renderBox.size.width > renderBox.size.height) ? renderBox.size.width : renderBox.size.height;
    double constrintRadius;
    if (radius > maxRadius) {
      constrintRadius = maxRadius;
    } else if (radius < minRadius) {
      constrintRadius = minRadius;
    } else{
      constrintRadius = radius;
    }
    radiusTween.end = constrintRadius * 0.6;
    borderWidthTween.begin = radiusTween.begin/ 2;
    borderWidthTween.end = radiusTween.end * 0.01;

    _animate();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      foregroundPainter: SplashPaint(
        radius: radiusAnimation.value,
        borderWidth: borderWidthanimation.value,
        status: status,
        tapPosition: _tapPosition
      ),
      child: GestureDetector(
        child: widget.child,
        onTapUp: _handleTap,
      )
    );
  }

}

class SplashPaint extends CustomPainter{

  final double radius;
  final double borderWidth;
  final Paint blackPaint;
  final AnimationStatus status;
  final Offset tapPosition;

  SplashPaint({@required this.radius, @required this.borderWidth, @required this.status, @required this.tapPosition}) : blackPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = borderWidth;

  @override
  void paint(Canvas canvas, Size size) { //Size is the size of the child
    if (status == AnimationStatus.forward) {
      canvas.drawCircle(tapPosition, radius, blackPaint);
    }
  }

  @override
  bool shouldRepaint(SplashPaint oldDelegate) {
    return radius != oldDelegate.radius;
  }

}