import 'package:flutter/material.dart';
import 'package:sjpr/model/api_response_class.dart';
import 'package:sjpr/model/api_response_location.dart';
import 'package:sjpr/model/product_list_model.dart';
import 'package:sjpr/utils/color_utils.dart';
import '../model/api_response_costomer.dart';
import '../model/api_response_taxrate.dart';
import '../model/currency_model.dart';
import '../model/payment_methods.dart';
import '../model/publish_to.dart';
import '../model/type_list_model.dart';

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
  TextEditingController _searchTextController = new TextEditingController();
  late String filter;
  late List filtered;

  @override
  void initState() {
    filtered = widget.items;
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
      filtered = widget.items;
    } else {
      filtered = widget.items.where((e) {
        return getName(e).toLowerCase().contains(filter.toLowerCase());
      }).toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return RadioListTile(
            title: Text(
              getName(filtered[index]),
              style: TextStyle(color: textColor),
            ),
            value: int.parse(filtered[index].id),
            onChanged: (val) {
              debugPrint('$val');
              setState(() {
                widget.selectedId = val as int;
                var selectedNm = getName(filtered[index]);
                widget.f(widget.selectedId, selectedNm);
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            groupValue: widget.selectedId,
          );
        },
      ),
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
    } else if (obj is DataItem) {
      return obj.taxRate;
    } else if (obj is TypeListData) {
      return obj.typeName;
    } else if (obj is CurrencyModel) {
      return obj.currency_name;
    } else if (obj is PaymentMethodsModel) {
      return obj.method_name;
    } else if (obj is PublishToModel) {
      return obj.name;
    } else
      return '';
  }
}
