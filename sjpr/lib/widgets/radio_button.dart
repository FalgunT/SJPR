import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/utils/color_utils.dart';

import 'check_box.dart';

class RadioButtonList extends StatefulWidget {
  final List<CheckBoxItem> items;
  Function f;

  @override
  State<StatefulWidget> createState() {
    return _RadioButtonState();
  }

  RadioButtonList({super.key, required this.items, required this.f});
}

class _RadioButtonState extends State<RadioButtonList> {
  //List<int> selectedIds = <int>[];
  var selected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (_, int index) {
        return RadioListTile(
          title: Text(
            widget.items[index].text,
            style: TextStyle(color: textColor),
          ),
          value: index,
          onChanged: (val) {
            setState(() {
              selected = val;
              debugPrint('${selected.toString()}');
              widget.items[selected].isSelected = true;
              widget.f(widget.items[selected]);
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          groupValue: selected,
        );
      },
    );
  }
}
