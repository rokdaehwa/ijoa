import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/decorations/nm_box.dart';

class NMTextButton extends StatefulWidget {
  final Function onTap;
  final String text;
  final bool disabled;

  const NMTextButton({Key key, this.onTap, this.text, this.disabled = false})
      : super(key: key);

  @override
  _NMTextButtonState createState() => _NMTextButtonState();
}

class _NMTextButtonState extends State<NMTextButton> {
  bool _isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onTap: widget.disabled ? null : widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
        decoration:  widget.disabled
            ? nMboxInvert
            : _isPressed
                ? ConcaveDecoration(
                    depth: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))))
                : nMbox,
        child: Text(
          widget.text,
          style:  widget.disabled
              ? TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                )
              : TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
        ),
      ),
    );
  }
}
