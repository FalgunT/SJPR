import 'package:flutter/material.dart';

import '../common/AppEnums.dart';
import '../model/category_list_model.dart';
import '../utils/color_utils.dart';
import 'AddNewItemDialog.dart';

class ExpandableRadioList extends StatefulWidget {
  List<CategoryListData> catList;
  int selectedId;
  Function f;
  void Function(String, String) onItemAdded;

  ExpandableRadioList(
      {super.key,
      required this.catList,
      required this.selectedId,
      required this.f,
      required this.onItemAdded});

  @override
  State<ExpandableRadioList> createState() => _ExpandableRadioListState();
}

class _ExpandableRadioListState extends State<ExpandableRadioList> {
  TextEditingController _searchTextController = new TextEditingController();
  late String filter;
  late List filtered;

  @override
  void initState() {
    filtered = widget.catList;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  filtermyList() {
    print(_searchTextController.text);
    filter = _searchTextController.text;
    if (filter.isEmpty) {
      filtered = widget.catList;
    } else {
      filtered = widget.catList.where((item) {
        final matchesTitle =
            item.name!.toLowerCase().contains(filter.toLowerCase());
        final filteredChildren = item.list!
            .where((child) => child.sub_category_name!
                .toLowerCase()
                .contains(filter.toLowerCase()))
            .toList();
        return matchesTitle || filteredChildren.isNotEmpty;
      }).map((item) {
        return CategoryListData(
          id: item.id,
          name: item.name,
          list: item.list!
              .where((child) => child.sub_category_name!
                  .toLowerCase()
                  .contains(filter.toLowerCase()))
              .toList(),
        );
      }).toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        leading: null,
        title: TextField(
          controller: _searchTextController,
          onChanged: filtermyList(),
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
              isDense: true,
              prefixIcon: Icon(
                Icons.search,
                color: textColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              fillColor: const Color.fromRGBO(44, 45, 51, 1),
              filled: true,
              hintText: "Search",
              hintStyle: TextStyle(color: textColor)),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: filtered.length,
        itemBuilder: (_, int index) {
          return ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            shape: const Border(),
            initiallyExpanded: false,
            //leading: /*Icon(Icons.category, color: textColor)*/,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  filtered[index].name ?? "Category $index",
                  style: TextStyle(color: textColor, fontSize: 18),
                ),
                OutlinedButton.icon(
                  style: const ButtonStyle(
                    //padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero), // Removes padding
                    visualDensity:
                        VisualDensity.compact, // Reduces overall space
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    //filtered[index].Navigator.pop(context);
                    AddNewItemDialog(
                        context: context,
                        title: "Add Category",
                        hint: 'Enter Category Name',
                        label: 'Category Name',
                        oldValue: "",
                        type: SheetType.category,
                        onPressed: (String v) {
                          widget.onItemAdded(v, filtered[index].id);
                        });
                  },
                  label: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  icon: const Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            children: getChildren(index),
          );
        },
      ),
    );
  }

  getChildren(int index) {
    List<Widget> children = [];
    for (int i = 0; i < filtered[index].list!.length; i++) {
      var item = filtered[index].list![i];
      children.add(Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: RadioListTile(
            title: Text(
              '${item.sub_category_name}(${item.code})',
              style: TextStyle(color: textColor),
            ),
            value: int.parse(item.sub_category_id!),
            onChanged: (val) {
              debugPrint('$val');
              setState(() {
                widget.selectedId = val as int;
                var selectedNm = item.sub_category_name!;
                //var selectedNm = widget.catList[index].list![i].sub_category_id!;
                widget.f(widget.selectedId, selectedNm ?? "-");
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            groupValue: widget.selectedId),
      ));
    }
    return children;
  }
}
