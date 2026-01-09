import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label(this.label,
      {this.style, this.align, this.direction, this.color, this.fontSize});
  final String label;
  final TextStyle? style;
  final TextAlign? align;
  final TextDirection? direction;
  final Color? color;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    late TextStyle s;
    if (style != null) {
      s = style!.copyWith(color: color);
    } else {
      s = Theme.of(context).textTheme.labelMedium ?? TextStyle();
      if (color != null) {
        s = s.copyWith(color: color!);
      }
      s = s.copyWith(fontSize: fontSize ?? Theme.of(context).textTheme.labelMedium!.fontSize);
      //s = s.copyWith(fontWeight: FontWeight.normal);
    }

    return Text(
      label,
      style: s,
      textAlign: align,
      textDirection: direction,
    );
  }

  factory Label.title(String title, {Color? color, double? size}) {
    return Label(
      title,
      style:
          TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: size),
    );
  }

  factory Label.bold(String title, {Color? color}) {
    return Label(
      title,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  factory Label.italic(String title, {Color? color}) {
    return Label(
      title,
      style: TextStyle(
        color: color,
        fontStyle: FontStyle.italic,
      ),
    );
  }



  factory Label.captionTitle(BuildContext context, String? caption,
      {Color? color}) {
    Size size = MediaQuery.sizeOf(context);
    if (size.width < 600 || caption == null) {
      return Label("");
    }
    return Label(
      caption,
      style: TextStyle(
        color: color,
      ),
    );
  }
}