import 'package:flutter/material.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/utils/color_utils.dart';

class CheckBoxList extends StatefulWidget {
  final List<CheckBoxItem> items;
  final int? selectedCategoryIndex;
  Function f;

  @override
  State<StatefulWidget> createState() {
    return _CheckBoxState();
  }

  CheckBoxList(
      {super.key,
      required this.items,
      required this.f,
      required this.selectedCategoryIndex});
}

class _CheckBoxState extends State<CheckBoxList> {
  int? selectedCategoryIndex;
  var selected;
  @override
  void initState() {
    // TODO: implement initState
    selectedCategoryIndex = widget.selectedCategoryIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (_, int index) {
        return ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          shape: const Border(),
          initiallyExpanded: false,
          leading: Icon(Icons.photo_library, color: textColor),
          title: Text(
            widget.items[index].text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
          children: getChildren(index),
        );
      },
    );
  }

  getChildren(int index) {
    List<Widget> children = [];
    for (int i = 0; i < widget.items[index].myChildren.length; i++) {
      var item = widget.items[index].myChildren[i];
      children.add(Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: RadioListTile(
          title: Text(
            item.sub_category_name ?? "-",
            style: TextStyle(color: textColor),
          ),
          value: i,
          onChanged: (val) {
            setState(() {
              selected = val;
              debugPrint(selected.toString());
              SubCategoryData selectedData =
                  widget.items[index].myChildren[selected];
              selectedCategoryIndex = index;
              widget.f(index, selectedData);
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          groupValue:
              (selectedCategoryIndex == null || selectedCategoryIndex == index)
                  ? selected
                  : null,
        ),
      ));
    }
    return children;
  }
}

class CheckBoxItem {
  String itemId;
  late bool isSelected;
  late String text;
  late List<SubCategoryData> myChildren = [];

  CheckBoxItem(
      {required this.isSelected, required this.text, required this.itemId});

  CheckBoxItem.withChildren(
      {required this.isSelected,
      required this.text,
      required this.itemId,
      required this.myChildren});

  @override
  String toString() {
    return 'CheckBoxItem{itemId: $itemId, isSelected: $isSelected, text: $text, myChildren: $myChildren}';
  }
}
