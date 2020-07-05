import 'package:flutter/material.dart';
import 'package:optr/components/cut_edges_decoration.dart';

/// Text Field component
class OptrTextField extends StatefulWidget {
  /// Value of the text field
  final String value;

  /// Label of text field
  final String label;

  /// Shoudl field outfocus
  final bool autofocus;

  /// Is this  a password
  final bool obscureText;

  /// Color
  Color color;

  /// Fired when field changes
  final Function(String) onChanged;

  /// TExt field constructor
  OptrTextField({
    this.label,
    this.value,
    this.color,
    this.obscureText = false,
    @required this.onChanged,
    this.autofocus = false,
  });

  @override
  _OptrTextFieldState createState() => _OptrTextFieldState();
}

class _OptrTextFieldState extends State<OptrTextField> {
  final TextEditingController textFieldController = TextEditingController();
  final _focus = FocusNode();
  String value;
  bool _obscureText = false;
  bool _hasFocus = false;

  @override
  void initState() {
    textFieldController.text = widget.value;
    value = widget.value;
    _obscureText = widget.obscureText;
    _focus.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void didUpdateWidget(OptrTextField oldWidget) {
    if (textFieldController.text != widget.value) {
      textFieldController.text = widget.value;
    }

    super.didUpdateWidget(oldWidget);
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focus.hasFocus;
    });
  }

  Widget _buildRevealButton() {
    if (!widget.obscureText) return null;

    var icon = _obscureText ? Icons.visibility : Icons.visibility_off;
    return IconButton(
        icon: Icon(icon),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    widget.color ??= Theme.of(context).accentColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: CutEdgesDecoration(
        color: Colors.black.withOpacity(0.8),
        lineColor: widget.color,
        lineStroke: 1.0,
        edges: const CutEdgeCorners.cross(10.0, 0.0),
        boxShadow: !_hasFocus
            ? [
                BoxShadow(
                  color: widget.color.withAlpha(100),
                  blurRadius: 6.0,
                  spreadRadius: 1.0,
                )
              ]
            : null,
      ),
      child: TextField(
        controller: textFieldController,
        onChanged: widget.onChanged,
        cursorColor: widget.color,
        textInputAction: TextInputAction.next,
        autofocus: widget.autofocus,
        autocorrect: false,
        obscureText: _obscureText,
        focusNode: _focus,
        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          suffixIcon: _buildRevealButton(),
          border: InputBorder.none,
          labelText: widget.label,
        ),
      ),
    );
  }
}
