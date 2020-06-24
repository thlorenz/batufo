import 'package:batufo/widgets/components/icon_widget.dart';
import 'package:flutter/material.dart';

class TextIconWidget extends StatelessWidget {
  final String iconName;
  final String pretext;
  final String posttext;
  final TextStyle style;
  final double iconSize;
  final MainAxisAlignment itemsAlignment;

  const TextIconWidget({
    @required this.iconName,
    @required this.style,
    this.iconSize = 20,
    this.pretext,
    this.posttext,
    this.itemsAlignment = MainAxisAlignment.start,
  })  : assert(pretext != null || posttext != null,
            'need either pre or post text'),
        super();

  Widget build(BuildContext context) {
    final icon = IconWidget(
      icon: iconName,
      size: iconSize,
    );
    final padding = Padding(padding: EdgeInsets.all(5.0));
    final pretextItem = pretext != null ? Text(pretext, style: style) : null;
    final posttextItem = posttext != null ? Text(posttext, style: style) : null;
    final items = pretextItem != null && posttextItem != null
        ? [
            pretextItem,
            padding,
            icon,
            padding,
            posttextItem,
          ]
        : pretextItem != null
            ? [
                pretextItem,
                padding,
                icon,
              ]
            : [
                icon,
                padding,
                posttextItem,
              ];
    return Row(mainAxisAlignment: itemsAlignment, children: items);
  }
}
