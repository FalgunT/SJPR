import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/category_list_model.dart';
import '../utils/color_utils.dart';

class ExpandableRadioList extends StatefulWidget {
  List<CategoryListData> catList;
  int selectedId;
  Function f;

  ExpandableRadioList(
      {super.key, required this.catList, required this.selectedId, required this.f});

  @override
  State<ExpandableRadioList> createState() => _ExpandableRadioListState();
}

class _ExpandableRadioListState extends State<ExpandableRadioList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*for (int i = 0; i < widget.catList.length; i++) {
      for (int j = 0; j < widget.catList[i].list!.length; j++) {
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.catList.length,
      itemBuilder: (_, int index) {
        return ExpansionTile(
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          shape: const Border(),
          initiallyExpanded: false,
          leading: Icon(Icons.photo_library, color: textColor),
          title: Text(
            widget.catList[index].name ?? "Category $index",
            style: TextStyle(color: textColor, fontSize: 18),
          ),
          children: getChildren(index),
        );
      },
    );
  }

  getChildren(int index) {
    List<Widget> children = [];
    for (int i = 0; i < widget.catList[index].list!.length; i++) {
      var item = widget.catList[index].list![i];
      children.add(Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: RadioListTile(
            title: Text(
              item.sub_category_name ?? "-",
              style: TextStyle(color: textColor),
            ),
            value: int.parse(item.sub_category_id!),
            onChanged: (val) {
              debugPrint('$val');
              setState(() {
                widget.selectedId = val as int;
                var selectedNm = item.sub_category_name!;
                //var selectedNm = widget.catList[index].list![i].sub_category_id!;
                widget.f(widget.selectedId,  selectedNm ?? "-");
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            groupValue: widget.selectedId),
      ));
    }
    return children;
  }
}
