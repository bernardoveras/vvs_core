import 'package:flutter/material.dart';

import 'circular_loader.dart';

class VvsIconButton extends StatelessWidget {
  VvsIconButton(
    IconData icon, {
    Key? key,
    VoidCallback? onPressed,
    Color? color,
    double radius = 4,
    double? width,
    double? height = 40,
    TextStyle? textStyle,
    Color? foregroundColor,
    bool outlined = false,
    bool loading = false,
    EdgeInsetsGeometry? padding,
    String? tooltip,
    BorderRadiusGeometry? borderRadius,
  }) : super(key: key) {
    _icon = icon;
    _onPressed = onPressed;
    _color = color;
    _width = width;
    _height = height;
    _foregroundColor = foregroundColor;
    _outlined = outlined;
    _padding = padding ?? EdgeInsets.zero;
    _loading = loading;
    _radius = radius;
    _borderRadius = borderRadius;
    _tooltip = tooltip;
  }

  late final String? _tooltip;
  late final IconData _icon;

  late final VoidCallback? _onPressed;

  /// Primary color from Theme by default
  late final Color? _color;

  ///  8 by default
  late final double _radius;
  late final BorderRadiusGeometry? _borderRadius;

  ///  40 by default
  late final double? _height;
  late final double? _width;

  /// Colors.white by default
  late final Color? _foregroundColor;

  late final bool _outlined;
  late final bool _loading;

  late final EdgeInsetsGeometry? _padding;

  Widget _buildLoadingAnimatedSwitcher(Widget child) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 150),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
      child: _loading ? _buildProgressIndicator() : child,
    );
  }

  Widget _buildChild(BuildContext context) => _buildLoadingAnimatedSwitcher(
        FittedBox(child: Icon(_icon)),
      );

  Widget _buildProgressIndicator() => const Center(
        child: CircularLoader(
          color: Colors.white,
          size: 16,
          lineWidth: 3,
        ),
      );

  Color _backgroundColor(BuildContext context) => _color ?? Theme.of(context).primaryColor;

  MaterialStateProperty<Color?>? _backgroundPropertyColor(BuildContext context) {
    if (_outlined) return MaterialStateProperty.all(Colors.transparent);

    return MaterialStateProperty.resolveWith<Color?>(
      (states) {
        bool disabled = states.contains(MaterialState.disabled);

        if (!disabled) {
          return _backgroundColor(context);
        } else {
          return Colors.grey.shade200;
        }
      },
    );
  }

  MaterialStateProperty<Color?>? _foregroundPropertyColor(BuildContext context) {
    return MaterialStateProperty.resolveWith<Color?>(
      (states) {
        bool disabled = states.contains(MaterialState.disabled);
        if (disabled == false) {
          if (_outlined) return _backgroundColor(context);

          return _foregroundColor;
        } else {
          return Colors.grey.shade400;
        }
      },
    );
  }

  MaterialStateProperty<RoundedRectangleBorder?>? _shapeProperty(BuildContext context) {
    return MaterialStateProperty.resolveWith<RoundedRectangleBorder?>(
      (states) {
        bool disabled = states.contains(MaterialState.disabled);

        return RoundedRectangleBorder(
          borderRadius: _borderRadius ?? BorderRadius.circular(_radius),
          side: BorderSide(
            color: disabled ? Colors.transparent : _backgroundColor(context),
            width: 1.5,
          ),
        );
      },
    );
  }

  MaterialStateProperty<Color?>? _overlayPropertyColor(BuildContext context) {
    return MaterialStateProperty.resolveWith<Color?>(
      (states) {
        bool disabled = states.contains(MaterialState.disabled);
        if (disabled == false) {
          if (_outlined) {
            return _color?.withOpacity(0.10) ?? Theme.of(context).primaryColor.withOpacity(0.10);
          }
        }
        return null;
      },
    );
  }

  ButtonStyle? _baseButtonStyle(BuildContext context) {
    return Theme.of(context).elevatedButtonTheme.style?.copyWith(
          backgroundColor: _backgroundPropertyColor(context),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: _borderRadius ?? BorderRadius.circular(_radius))),
          foregroundColor: MaterialStateProperty.all(_foregroundColor),
          padding: MaterialStateProperty.all(_padding),
        );
  }

  ButtonStyle? _buttonStyle(BuildContext context) {
    return _baseButtonStyle(context)?.copyWith(
      foregroundColor: _foregroundPropertyColor(context),
      backgroundColor: _backgroundPropertyColor(context),
      shape: _shapeProperty(context),
      overlayColor: _overlayPropertyColor(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _tooltip ?? '',
      child: SizedBox(
        key: key,
        height: _height,
        width: _width,
        child: ElevatedButton(
          child: _buildChild(context),
          onPressed: _onPressed,
          style: _buttonStyle(context),
        ),
      ),
    );
  }
}
