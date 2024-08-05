import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/api_response_class.dart';
import 'package:sjpr/model/api_response_location.dart';
import 'package:sjpr/model/product_list_model.dart';
import 'package:sjpr/utils/color_utils.dart';

import '../model/api_response_costomer.dart';
import 'check_box.dart';

class RadioButtonList1 extends StatefulWidget {
  final List items;
  int selectedId;
  Function f;

  @override
  State<StatefulWidget> createState() {
    return _RadioButtonState();
  }

  RadioButtonList1(
      {super.key,
      required this.items,
      required this.selectedId,
      required this.f});
}

class _RadioButtonState extends State<RadioButtonList1> {
  //List<int> selectedIds = <int>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (_, int index) {
        return RadioListTile(
          title: Text(
            getName(widget.items[index]),
            style: TextStyle(color: textColor),
          ),
          value: int.parse(widget.items[index].id),
          onChanged: (val) {
            debugPrint('$val');
            setState(() {
              widget.selectedId = val as int;
              var selectedNm = getName(widget.items[index]);
              widget.f(widget.selectedId, selectedNm);
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
          groupValue: widget.selectedId,
        );
      },
    );
  }

  getName(obj) {
    if (obj is Customer) {
      return obj.customerName;
    } else if (obj is Record1) {
      return obj.location;
    } else if (obj is CData) {
      return obj.className;
    } else if (obj is ProductServicesListData) {
      return obj.productServicesName;
    }
  }

}
