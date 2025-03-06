

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.heading,
    required this.collapsedtext,
    required this.expandedtext,
  });
 final String? heading;
 final String? collapsedtext;
 final String? expandedtext;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ExpandablePanel(
          header: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              heading.toString(),
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          collapsed: Text(collapsedtext.toString()),
          expanded: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(expandedtext.toString()),
          ),
        ),
      ),
    );
  }
}
