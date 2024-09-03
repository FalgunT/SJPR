import 'package:flutter/material.dart';
import 'package:sjpr/screen/lineitems/line_items_detail.dart';
import 'package:sjpr/widgets/radio_button_list.dart';

import '../common/AppEnums.dart';
import '../model/category_list_model.dart';
import '../utils/color_utils.dart';
import 'AddNewItemDialog.dart';
import 'expandable_radio_list.dart';

class CommonBottomSheetDialog {
  final BuildContext context;
  final List list;
  final String title;
  final int ItemId;
  final SheetType bottomSheetType;
  final Function Addf;
  final Function onItemSelected;

  CommonBottomSheetDialog({
    required this.context,
    required this.list,
    required this.title,
    required this.ItemId,
    required this.bottomSheetType,
    required this.Addf,
    required this.onItemSelected,
  });

  Show() {
    return showModalBottomSheet(
        backgroundColor: Colors.black,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height/1.5,
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
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          isAddButtonRequired()
                              ? OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    AddNewItemDialog(
                                        context: context,
                                        title: "Add $title",
                                        hint: 'Enter $title Name',
                                        label: '$title Name',
                                        oldValue: "",
                                        type: bottomSheetType,
                                        onPressed: (String v) {
                                          debugPrint('F() called--->, $v');
                                          Addf(v);
                                          /* if (bottomSheetType ==
                                              SheetType.product) {

                                          } else if (bottomSheetType ==
                                              SheetType.itemclass) {
                                            bloc.addClass(context, v);
                                          } else if (bottomSheetType ==
                                              SheetType.location) {
                                            bloc.addlocation(context, v);
                                          } else if (bottomSheetType ==
                                              SheetType.customer) {
                                            bloc.addCustomer(context, v);
                                          }*/
                                        });
                                  },
                                  label: const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )
                              : Center(),
                          const SizedBox(
                            width: 16,
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
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  bottomSheetType == SheetType.category
                      ? Expanded(
                          child: ExpandableRadioList(
                            catList: list as List<CategoryListData>,
                            selectedId: ItemId,
                            f: (id, name) {
                              debugPrint('--->f() called');
                              onItemSelected(id, name);
                            },
                          ),
                        )
                      : Expanded(
                          child: RadioButtonList1(
                            items: list,
                            selectedId: ItemId,
                            f: (id, name) {
                              debugPrint('--->f() called');
                              onItemSelected(id, name);
                            },
                          ),
                        ),
                ],
              ),
            );
          });
        });
  }

  isAddButtonRequired() {
    return (bottomSheetType != SheetType.category &&
        bottomSheetType != SheetType.taxrate &&
        bottomSheetType != SheetType.type &&
        bottomSheetType != SheetType.currency &&
        bottomSheetType != SheetType.paymentmethods &&
        bottomSheetType != SheetType.publishto);
  }
}

/*
  String getBottomSheetTitle(int index, SheetType bottomSheetType) {
    if (bottomSheetType == SheetType.customer) {
      return bloc.customerList[index].customerName;
    } else if (bottomSheetType == SheetType.location) {
      return bloc.locationList[index].location;
    } else if (bottomSheetType == SheetType.itemclass) {
      return bloc.classList[index].className;
    } else if (bottomSheetType == SheetType.product) {
      return bloc.productList[index].productServicesName!;
    }
    return '';
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
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          bottomSheetType != SheetType.category
                              ? OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);

                                    AddNewItemDialog(
                                        context: context,
                                        title: "Add $title",
                                        hint: 'Enter $title Name',
                                        label: '$title Name',
                                        oldValue: "",
                                        type: bottomSheetType,
                                        onPressed: (String v) {
                                          debugPrint('F() called--->, $v');
                                          if (bottomSheetType ==
                                              SheetType.product) {
                                            bloc.addProductService(context, v);
                                          } else if (bottomSheetType ==
                                              SheetType.itemclass) {
                                            bloc.addClass(context, v);
                                          } else if (bottomSheetType ==
                                              SheetType.location) {
                                            bloc.addlocation(context, v);
                                          } else if (bottomSheetType ==
                                              SheetType.customer) {
                                            bloc.addCustomer(context, v);
                                          }
                                        });
                                  },
                                  label: const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                )
                              : Center(),
                          const SizedBox(
                            width: 16,
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
                  bottomSheetType == SheetType.category
                      ? Expanded(
                          child: ExpandableRadioList(
                            catList:
                                bloc.categoryList as List<CategoryListData>,
                            f: (id, name) {
                              debugPrint('--->f() called');
                              bloc.lineitemdetail.value.categoryId = '$id';
                              bloc.selectedValueC.value = name;
                            },
                            selectedId: getCategoryId(),
                          ),
                        )
                      : Expanded(
                          child: RadioButtonList1(
                            items: list,
                            selectedId: getId(bottomSheetType),
                            f: (id, name) {
                              debugPrint('--->f() called');
                              SetName(id, name, bottomSheetType);
                            },
                          ),
                        ),
                ],
              ),
            );
          });
        });
  }*/
