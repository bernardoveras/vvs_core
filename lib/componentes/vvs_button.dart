// coverage:ignore-file

// ignore_for_file: must_be_immutable

import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'circular_loader.dart';

enum Position { left, right }

class VvsButton extends StatelessWidget {
  VvsButton(
    String text, {
    Key? key,
    IconData? icon,
    VoidCallback? onPressed,
    Color? color,
    double radius = 4,
    double? width,
    double? height = 40,
    TextStyle? textStyle,
    Color? foregroundColor,
    bool outlined = false,
    bool loading = false,
    Position iconPosition = Position.left,
    EdgeInsetsGeometry? padding,
    String? tooltip,
    AlignmentGeometry alignment = Alignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    bool disabled = false,
    OutlinedBorder? shape,
    TooltipTriggerMode? toolTipTriggerMode,
    Color loadingProgressColor = Colors.white,
  }) : super(key: key) {
    assert(text.isNotEmpty, 'A propriedade "text" não pode ser vazia.');

    _text = text;
    _icon = icon;
    _onPressed = onPressed;
    _color = color;
    _width = width;
    _height = height;
    _textStyle = textStyle;
    _foregroundColor = foregroundColor;
    _outlined = outlined;
    _iconPosition = iconPosition;
    _padding = padding;
    _isText = false;
    _loading = loading;
    _radius = radius;
    _tooltip = tooltip;
    _toolTipTriggerMode = toolTipTriggerMode;
    _alignment = alignment;
    _mainAxisSize = mainAxisSize;
    _mainAxisAlignment = mainAxisAlignment;
    _disabled = disabled;
    _shape = shape;
    _loadingProgressColor = loadingProgressColor;
  }

  late final String _text;
  late final String? _tooltip;
  late final TooltipTriggerMode? _toolTipTriggerMode;
  late final IconData? _icon;

  late final VoidCallback? _onPressed;

  /// Primary color from Theme by default
  late final Color? _color;

  /// Circular progress indicator color
  late final Color _loadingProgressColor;

  ///  8 by default
  late final double _radius;

  ///  50 by default
  late final double? _height;
  late final double? _width;

  late final TextStyle? _textStyle;

  /// Colors.white by default
  late final Color? _foregroundColor;

  late final bool _outlined;
  late final bool _loading;
  late final bool _disabled;

  /// Position.right by default
  late final Position _iconPosition;

  late final EdgeInsetsGeometry? _padding;

  late final AlignmentGeometry _alignment;

  late final MainAxisSize _mainAxisSize; // MainAxisSize.min,
  late final MainAxisAlignment _mainAxisAlignment; // MainAxisAlignment.start;

  late final OutlinedBorder? _shape;

  late bool _isText;

  VvsButton.icon(
    String text, {
    Key? key,
    required IconData icon,
    VoidCallback? onPressed,
    Color? color,
    double radius = 4,
    double? width,
    double? height = 40,
    TextStyle? textStyle,
    Color? foregroundColor,
    bool outlined = false,
    Position iconPosition = Position.left,
    EdgeInsetsGeometry? padding,
    bool loading = false,
    String? tooltip,
    AlignmentGeometry alignment = Alignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    bool disabled = false,
    TooltipTriggerMode? toolTipTriggerMode,
    Color loadingProgressColor = Colors.white,
  }) : super(key: key) {
    assert(text.isNotEmpty, 'A propriedade "text" não pode ser vazia.');

    _text = text;
    _icon = icon;
    _onPressed = onPressed;
    _color = color;
    _width = width;
    _height = height;
    _radius = radius;
    _textStyle = textStyle;
    _foregroundColor = foregroundColor;
    _outlined = outlined;
    _iconPosition = iconPosition;
    _isText = false;
    _padding = padding;
    _loading = loading;
    _tooltip = tooltip;
    _alignment = alignment;
    _mainAxisSize = mainAxisSize;
    _mainAxisAlignment = mainAxisAlignment;
    _disabled = disabled;
    _toolTipTriggerMode = toolTipTriggerMode;
    _shape = null;
    _loadingProgressColor = loadingProgressColor;
  }

  VvsButton.text(
    String text, {
    Key? key,
    IconData? icon,
    VoidCallback? onPressed,
    double radius = 4,
    double? width,
    double? height = 40,
    TextStyle? textStyle,
    Color? color,
    Position iconPosition = Position.left,
    EdgeInsetsGeometry? padding,
    bool loading = false,
    String? tooltip,
    AlignmentGeometry alignment = Alignment.center,
    MainAxisSize mainAxisSize = MainAxisSize.min,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    bool disabled = false,
    TooltipTriggerMode? toolTipTriggerMode,
    Color loadingProgressColor = Colors.white,
  }) : super(key: key) {
    assert(text.isNotEmpty, 'A propriedade "text" não pode ser vazia.');

    _text = text;
    _foregroundColor = color;
    _isText = true;
    _icon = icon;
    _onPressed = onPressed;
    _color = color;
    _width = width;
    _height = height;
    _radius = radius;
    _textStyle = textStyle;
    _outlined = false;
    _iconPosition = iconPosition;
    _padding = padding;
    _loading = loading;
    _tooltip = tooltip;
    _alignment = alignment;
    _mainAxisSize = mainAxisSize;
    _mainAxisAlignment = mainAxisAlignment;
    _disabled = disabled;
    _toolTipTriggerMode = toolTipTriggerMode;
    _shape = null;
    _loadingProgressColor = loadingProgressColor;
  }

  double _calculateGap(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap = scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;

    return gap;
  }

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

  Widget _buildChild(BuildContext context) => _icon == null ? _buildText() : _buildChildWithIcon(context);

  Widget _buildText() => _buildLoadingAnimatedSwitcher(FittedBox(child: Text(_text)));

  Widget _buildChildWithIcon(BuildContext context) {
    return _buildLoadingAnimatedSwitcher(
      Row(
        mainAxisSize: _mainAxisSize,
        mainAxisAlignment: _mainAxisAlignment,
        children: <Widget>[
          if (_iconPosition == Position.left) ...{
            FittedBox(child: Icon(_icon)),
            SizedBox(width: _calculateGap(context)),
          },
          Flexible(child: _buildText()),
          if (_iconPosition == Position.right) ...{
            SizedBox(width: _calculateGap(context)),
            FittedBox(child: Icon(_icon)),
          },
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() => Center(
        child: CircularLoader(
          color: _loadingProgressColor,
          size: 16,
          lineWidth: 3,
        ),
      );

  Color _backgroundColor(BuildContext context) => _color ?? Theme.of(context).primaryColor;

  MaterialStateProperty<Color?>? _backgroundPropertyColor(BuildContext context) {
    if (_outlined) return MaterialStateProperty.all(Colors.transparent);
    if (_isText) return MaterialStateProperty.all(Colors.transparent);

    return MaterialStateProperty.resolveWith<Color?>(
      (states) {
        bool disabled = states.contains(MaterialState.disabled);

        if (disabled || _disabled) {
          return Colors.grey.shade200;
        } else {
          return _backgroundColor(context);
        }
      },
    );
  }

  MaterialStateProperty<Color?>? _foregroundPropertyColor(BuildContext context) {
    return MaterialStateProperty.resolveWith<Color?>(
      (states) {
        bool disabled = states.contains(MaterialState.disabled);
        if (disabled == false && _disabled == false) {
          if (_isText) return _foregroundColor ?? Theme.of(context).primaryColor;
          if (_outlined) return _backgroundColor(context);

          return _foregroundColor;
        } else {
          if (!_isText) return Theme.of(context).brightness == Brightness.light ? Colors.grey.shade400 : Colors.grey.shade300;

          return Colors.grey.shade400;
        }
      },
    );
  }

  MaterialStateProperty<OutlinedBorder?>? _shapeProperty(BuildContext context) {
    return MaterialStateProperty.resolveWith<OutlinedBorder?>(
      (states) {
        bool disabled = states.contains(MaterialState.disabled);

        return _shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
              side: _isText || !(_outlined || disabled)
                  ? BorderSide.none
                  : BorderSide(
                      color: disabled || _disabled ? Colors.transparent : _backgroundColor(context),
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
        if (disabled == false && _disabled == false) {
          if (_outlined) {
            return _color?.withOpacity(0.10) ?? Theme.of(context).primaryColor.withOpacity(0.10);
          }

          if (_isText) {
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
          shape: MaterialStateProperty.all(_shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius))),
          textStyle: MaterialStateProperty.all(_textStyle),
          foregroundColor: MaterialStateProperty.all(_foregroundColor),
          padding: MaterialStateProperty.all(_padding),
          alignment: _alignment,
          mouseCursor: MaterialStateProperty.resolveWith<MouseCursor?>(
            (states) {
              bool disabled = states.contains(MaterialState.disabled);
              if (disabled || _disabled) {
                return SystemMouseCursors.forbidden;
              }
              return null;
            },
          ),
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
      triggerMode: _toolTipTriggerMode,
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
