import 'package:flutter/material.dart';

/// Kuwaiti Sadu Pattern Theme Colors
class SaduTheme {
  // Primary Sadu Colors (from traditional weaving)
  static const Color saduRed = Color(0xFFD32F2F);
  static const Color saduDarkRed = Color(0xFFB71C1C);
  static const Color saduBlack = Color(0xFF000000);
  static const Color saduWhite = Color(0xFFFFFFFF);
  static const Color saduCream = Color(0xFFFFF8E1);
  
  // Kuwaiti Flag Colors
  static const Color kuwaitiRed = Color(0xFFCE1126);
  static const Color kuwaitiGreen = Color(0xFF007A3D);
  static const Color kuwaitiBlack = Color(0xFF000000);
  static const Color kuwaitiWhite = Color(0xFFFFFFFF);
  
  // Answer colors (keep existing logic)
  static const Color correctGreen = Color(0xFF4CAF50);
  static const Color incorrectRed = Color(0xFFF44336);
  static const Color neutralWhite = Color(0xFFFFFFFF);
  
  // Team colors with Kuwaiti theme
  static const Color teamARed = kuwaitiRed;
  static const Color teamBGreen = kuwaitiGreen;
  
  // Background colors
  static const Color primaryBackground = Colors.white;
  static const Color secondaryBackground = Color(0xFFFAFAFA);
  
  // Gradient for Sadu elements
  static const LinearGradient saduGradient = LinearGradient(
    colors: [saduRed, saduDarkRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Box shadow for elevated elements
  static List<BoxShadow> saduShadow = [
    BoxShadow(
      color: saduBlack.withOpacity(0.1),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  /// Get Sadu pattern border decoration
  static BoxDecoration getSaduBorder({
    Color backgroundColor = Colors.white,
    double borderWidth = 4.0,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: Border.all(
        width: borderWidth,
        color: saduRed,
      ),
      boxShadow: saduShadow,
    );
  }
  
  /// Get geometric Sadu pattern decoration
  static BoxDecoration getGeometricSaduDecoration({
    Color? backgroundColor,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? Colors.white,
      borderRadius: borderRadius,
      gradient: backgroundColor == null ? saduGradient : null,
      boxShadow: saduShadow,
    );
  }
  
  /// Text style with Sadu theme
  static TextStyle getSaduTextStyle({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color color = saduBlack,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: 0.5,
    );
  }
  
  /// Button style with Sadu theme
  static ButtonStyle getSaduButtonStyle({
    Color backgroundColor = saduRed,
    Color foregroundColor = saduWhite,
    EdgeInsets? padding,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
    );
  }
  
  /// Circular Sadu pattern container (like the saudi.jpg image)
  static Widget circularSaduFrame({
    required Widget child,
    double size = 200,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: const DecorationImage(
          image: AssetImage('assets/images/saudi.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: size * 0.6,
          height: size * 0.6,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
  
  /// Rectangular Sadu pattern background
  static Widget rectangularSaduBackground({
    required Widget child,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Kuwaiti.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

