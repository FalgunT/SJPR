import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/common_button.dart';

class LineItemsDetailScreen extends StatefulWidget {
  final String id;

  const LineItemsDetailScreen({super.key, required this.id});

  @override
  State<LineItemsDetailScreen> createState() => _LineItemsDetailScreenState();
}

class _LineItemsDetailScreenState extends State<LineItemsDetailScreen> {
  LineItemsBloc bloc = LineItemsBloc();

  @override
  void initState() {
    if (widget.id != null && widget.id.isNotEmpty) {
      bloc.getLineItemDetail(context, widget.id);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                  valueListenable: bloc.lineItemName,
                  builder: (context, value, _) {
                    return Text(
                      bloc.lineItemName.value,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: activeTxtColor,
                          fontSize: 24),
                    );
                  }),
              CommonButton(
                  textFontSize: 16,
                  height: 30,
                  content: "Delete",
                  bgColor: backGroundColor,
                  textColor: activeTxtColor,
                  outlinedBorderColor: activeTxtColor,
                  onPressed: () {})
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            height: 112,
            width: MediaQuery
                .sizeOf(context)
                .width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(44, 45, 51, 1),
            ),
            child: ValueListenableBuilder(
                valueListenable: bloc.txtController,
                builder: (context, value, _) {
                  return TextField(
                    controller: bloc.txtController,
                    maxLines: 5,
                    style: TextStyle(color: textColor, fontSize: 16),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "Description",
                        hintStyle:
                        TextStyle(color: textColor, fontSize: 16)),
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          ValueListenableBuilder(
              valueListenable: bloc.selectedValueC,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Category",
                    value: value,
                    onTap: () {
                      singleSelectBottomSheet(
                          context: context,
                          list: bloc.categoryList,
                          title: "Category",
                          bottomSheetType: "category");
                    },
                    context: context);
              }),
          ValueListenableBuilder(
              valueListenable: bloc.selectedValueP,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Product/Service",
                    value: value,
                    onTap: () {
                      singleSelectBottomSheet(
                          context: context,
                          list: bloc.productList,
                          title: "Product/Service",
                          bottomSheetType: "product");
                    },
                    context: context);
              }),
          ValueListenableBuilder(
              valueListenable: bloc.selectedValueClass,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Class",
                    value: value,
                    onTap: () {
                      singleSelectBottomSheet(
                          context: context,
                          list: bloc.classList,
                          title: "Class",
                          bottomSheetType: "class");
                    },
                    context: context);
              }),
          ValueListenableBuilder(
              valueListenable: bloc.selectedValueL,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Location",
                    value: value,
                    onTap: () {
                      singleSelectBottomSheet(
                          context: context,
                          list: bloc.locationList,
                          title: "Location",
                          bottomSheetType: "location");
                    },
                    context: context);
              }),
          ValueListenableBuilder(
              valueListenable: bloc.selectedValueCustomer,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Customer",
                    value: value,
                    onTap: () {
                      singleSelectBottomSheet(
                          context: context,
                          list: bloc.customerList,
                          title: "Customer",
                          bottomSheetType: "customer");
                    },
                    context: context);
              }),

          ValueListenableBuilder(
              valueListenable: bloc.selectedQuatity,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Quantity",
                    value: bloc.selectedQuatity.value,
                    onTap: () {},
                    context: context);
              }),

          ValueListenableBuilder(
              valueListenable: bloc.selectedUnitPrice,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Unit price ", /*(Excl.tax)*/
                    value: bloc.selectedUnitPrice.value,
                    onTap: () {},
                    context: context);
              }),


          /* commonRowWidget(
                  title: "Unit price (Incl.tax)",
                  value: "0.00",
                  onTap: () {},
                  context: context),*/

          ValueListenableBuilder(
              valueListenable: bloc.selectedNetAmt,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Net",
                    value: bloc.selectedNetAmt.value,
                    onTap: () {},
                    context: context);
              }),

          ValueListenableBuilder(
              valueListenable: bloc.selectedTaxRate,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Tax rate",
                    value: bloc.selectedTaxRate.value,
                    onTap: () {},
                    context: context);
              }),

          ValueListenableBuilder(
              valueListenable: bloc.selectedTaxAmt,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Tax",
                    value: bloc.selectedTaxAmt.value,
                    onTap: () {},
                    context: context);
              }),

          ValueListenableBuilder(
              valueListenable: bloc.selectedTotalAmt,
              builder: (context, value, _) {
                return commonRowWidget(
                    title: "Total Amount",
                    value: bloc.selectedTotalAmt.value,
                    onTap: () {},
                    context: context);
              }),
              CommonButton(
                  textFontSize: 16,

                  content: "Save",
                  bgColor: buttonBgColor,
                  textColor: buttonTextColor,
                  outlinedBorderColor: buttonBgColor,
                  onPressed: () {})
          ],
        ),
      ),
    ),);
  }

  singleSelectBottomSheet({
    required context,
    required list,
    required title,
    required bottomSheetType,
  }) {
    return showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: textColor,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextField(
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
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return RadioListTile(
                                activeColor: activeTxtColor,
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                contentPadding: const EdgeInsets.only(
                                    left: 6, right: 0, bottom: 0, top: 0),
                                title: Text(
                                  list[index],
                                  style: TextStyle(
                                      color: bloc.selectedValue == list[index]
                                          ? activeTxtColor
                                          : textColor),
                                ),
                                value: list[index],
                                groupValue: bloc.selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    bloc.selectedValue = value;
                                    if (bottomSheetType == "category") {
                                      bloc.selectedValueC.value = value;
                                    } else if (bottomSheetType == "product") {
                                      bloc.selectedValueP.value = value;
                                    } else if (bottomSheetType == "class") {
                                      bloc.selectedValueClass.value = value;
                                    } else if (bottomSheetType == "location") {
                                      bloc.selectedValueL.value = value;
                                    } else if (bottomSheetType == "customer") {
                                      bloc.selectedValueCustomer.value = value;
                                    }
                                  });
                                },
                              );
                            }),
                      ),

                    ],
                  ),
                );
              });
        });
  }
}

Widget commonRowWidget(
    {required title, required value, required onTap, required context}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: listTileBgColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: textColor, fontSize: 17),
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: textColor,
          )
        ],
      ),
    ),
  );
}
