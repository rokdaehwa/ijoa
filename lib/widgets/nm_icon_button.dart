import 'package:flutter/material.dart';
import 'package:ijoa/decorations/concave_decoration.dart';
import 'package:ijoa/decorations/nm_box.dart';

class NMButton extends StatefulWidget {
  final IconData icon;
  final Function onTap;
  final bool hasBadge;
  final Size size;
  const NMButton(
      {this.icon,
      this.onTap,
      this.hasBadge = false,
      this.size = const Size(55.0, 55.0)});

  @override
  _NMButtonState createState() => _NMButtonState();
}

class _NMButtonState extends State<NMButton> {
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
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            width: widget.size.width,
            height: widget.size.height,
            decoration: _isPressed
                ? ConcaveDecoration(
                    depth: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))))
                : nMbox,
            child: Icon(
              widget.icon,
              color: _isPressed ? fCD : fCL,
            )),
      ),
    );
  }
}
