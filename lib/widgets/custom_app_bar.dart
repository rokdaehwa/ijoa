import 'package:flutter/material.dart';
import 'package:ijoa/widgets/nm_icon_button.dart';

class NMAppBar extends StatelessWidget {
  final IconData leadingIcon;
  final String leadingTooltip;
  final Function leadingOnTap;
  final IconData trailingIcon;
  final String trailingTooltip;
  final Function trailingOnTap;
  final Widget title;

  const NMAppBar(
      {Key key,
      this.leadingIcon,
      this.leadingTooltip,
      this.leadingOnTap,
      this.trailingIcon,
      this.trailingTooltip,
      this.trailingOnTap,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildIcon(leadingIcon, leadingTooltip, leadingOnTap),
                Expanded(
                  child: Container(),
                ),
                _buildIcon(trailingIcon, trailingTooltip, trailingOnTap),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            title,
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, String tooltip, Function onTap) {
    if (icon == null) return Container();
    return Tooltip(
      message: tooltip,
      child: NMButton(
        icon: icon,
        onTap: onTap,
      ),
    );
  }
}
