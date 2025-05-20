//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class AppbarBackgroundPainter extends CustomPainter {
    @override
    void paint(Canvas canvas, Size size) {
            
Path path_0 = Path();
    path_0.moveTo(size.width*0.07609085,size.height*0.05500309);
    path_0.cubicTo(size.width*0.07609085,size.height*0.3727273,size.width*0.05519695,size.height*0.4496091,size.width*0.1525424,size.height*0.4496091);
    path_0.cubicTo(size.width*0.2498881,size.height*0.4496091,size.width*0.2372881,size.height*0.4000000,size.width*0.2457627,size.height*0.05500309);
    path_0.cubicTo(size.width*0.2470153,size.height*0.004009109,size.width*0.9830508,size.height*0.01860873,size.width*0.9830508,size.height*0.01860873);
    path_0.lineTo(size.width*0.9830508,size.height*0.9766418);
    path_0.cubicTo(size.width*0.9830508,size.height*0.9766418,size.width*0.2457627,size.height*1.016260,size.width*0.2457627,size.height*0.9284673);
    path_0.cubicTo(size.width*0.2457627,size.height*0.5000000,size.width*0.2358712,size.height*0.5000000,size.width*0.1525424,size.height*0.5000000);
    path_0.cubicTo(size.width*0.06921339,size.height*0.5000000,size.width*0.07609085,size.height*0.6272727,size.width*0.07609085,size.height*0.9284673);
    path_0.cubicTo(size.width*0.07609085,size.height*1.001165,size.width*0.01694915,size.height*0.9766418,size.width*0.01694915,size.height*0.9766418);
    path_0.lineTo(size.width*0.01694915,size.height*0.01860873);
    path_0.cubicTo(size.width*0.01694915,size.height*0.01860873,size.width*0.07609085,size.height*0.01530282,size.width*0.07609085,size.height*0.05500309);
    path_0.close();

Paint paint0Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=2;
paint0Stroke.color=Color(0xff5EA275).withOpacity(1.0);
canvas.drawPath(path_0,paint0Stroke);

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.color = Color(0xffFBB428).withOpacity(1.0);
canvas.drawPath(path_0,paint0Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
}
}