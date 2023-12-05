import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class smallButton extends StatelessWidget {
  Widget? icon;
  Widget? btntext;
  VoidCallback? onTap;
  var height;
  var width;
  smallButton(
      {super.key,
        this.icon,
        this.btntext,
        this.onTap,
        this.height,
        this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 7.h),
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.w),
            gradient:
            gradientColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(
              width: 10,
            ),
            btntext!,
          ],
        ),
      ),
    );
  }
}
class text extends StatelessWidget {
  var myText;
  double? fontSize = 50.sp;
  var fontWeight;

  double? letterSpacing;

  text({
    super.key,
    required this.myText,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      myText,
      style: TextStyle(
        fontSize: fontSize ?? 25.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontFamily: "Poppins",
        letterSpacing: letterSpacing ?? 0.0,
      ),
    );
  }
}
 Gradient gradientColor = LinearGradient(
  colors: [
    complColor,
    mainColor,
  ],
);
const Color mainColor = Color(0xFF17CADF);
const Color complColor = Color(0xFF76E6A1);