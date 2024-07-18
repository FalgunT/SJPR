import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sjpr/screen/lineitems/line_items_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/widgets/common_button.dart';

class LineItemsListScreen extends StatefulWidget {
  final String id;
  const LineItemsListScreen({super.key, required this.id});

  @override
  State<LineItemsListScreen> createState() => _LineItemsListScreenState();
}

class _LineItemsListScreenState extends State<LineItemsListScreen> {
  LineItemsBloc bloc = LineItemsBloc();
  String selectedValue = "";
  String categoryValue = "";
  String productValue = "";
  String classValue = "";
  String locationValue = "";
  String customerValue = "";
  ValueNotifier<String> selectedValueC = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueP = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueClass = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueL = ValueNotifier<String>("");
  ValueNotifier<String> selectedValueCustomer = ValueNotifier<String>("");

  List categoryList = [
    "None",
    "Accumulated Depreciation",
    "Ask My Accountant",
    "Buildings and Improvements",
    "Business Licenses and Permits",
    "Charitable Contributions",
    "Computer and Internet Expenses",
    "Counting Education",
    "Depreciation Expense"
  ];

  List productList = [
    "None",
    "Admin Fee",
    "Annual Return/Confirmation Statement",
    "Benefits",
    "Company Restoration",
    "Consultation On Liquidation",
    "CVA",
    "Business Event",
    "FCA Fees"
  ];

  List classList = [
    'None',
    "Bruno Portfolio",
    "Jonas Portfolio",
    "Luiz Portfolio",
    "Vitor Portfolio",
    "Wilson Portfolio"
  ];

  List locationList = [
    "None",
    "France",
    "Germany",
    "International",
    "Netherlands",
    "Portugal",
    "Saudi Arabia",
    "Spain",
    "United Kingdom"
  ];

  List customerList = [
    "None",
    "001 Client",
    "002 Client",
    "003 Client",
    "004 Client",
    "005 Client",
    "006 Client",
    "007 Client",
    "008 Client",
  ];

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
                  Text(
                    "List Item 01",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: activeTxtColor,
                        fontSize: 24),
                  ),
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
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromRGBO(44, 45, 51, 1),
                  ),
                  child: TextField(
                    maxLines: 5,
                    style: TextStyle(color: textColor, fontSize: 16),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "Description",
                        hintStyle: TextStyle(color: textColor, fontSize: 16)),
                  )),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder(
                  valueListenable: selectedValueC,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Category",
                        value: value,
                        onTap: () {
                          singleSelectBottomSheet(
                              context: context,
                              list: categoryList,
                              title: "Category",
                              bottomSheetType: "category");
                        },
                        context: context);
                  }),
              ValueListenableBuilder(
                  valueListenable: selectedValueP,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Product/Service",
                        value: value,
                        onTap: () {
                          singleSelectBottomSheet(
                              context: context,
                              list: productList,
                              title: "Product/Service",
                              bottomSheetType: "product");
                        },
                        context: context);
                  }),
              ValueListenableBuilder(
                  valueListenable: selectedValueClass,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Class",
                        value: value,
                        onTap: () {
                          singleSelectBottomSheet(
                              context: context,
                              list: classList,
                              title: "Class",
                              bottomSheetType: "class");
                        },
                        context: context);
                  }),
              ValueListenableBuilder(
                  valueListenable: selectedValueL,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Location",
                        value: value,
                        onTap: () {
                          singleSelectBottomSheet(
                              context: context,
                              list: locationList,
                              title: "Location",
                              bottomSheetType: "location");
                        },
                        context: context);
                  }),
              ValueListenableBuilder(
                  valueListenable: selectedValueCustomer,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Customer",
                        value: value,
                        onTap: () {
                          singleSelectBottomSheet(
                              context: context,
                              list: customerList,
                              title: "Customer",
                              bottomSheetType: "customer");
                        },
                        context: context);
                  }),
              commonRowWidget(
                  title: "Quantity",
                  value: "1.00",
                  onTap: () {},
                  context: context),
              commonRowWidget(
                  title: "Unit price (Excl.tax)",
                  value: "0.00",
                  onTap: () {},
                  context: context),
              commonRowWidget(
                  title: "Unit price (Incl.tax)",
                  value: "0.00",
                  onTap: () {},
                  context: context),
              commonRowWidget(
                  title: "Net", value: "0.00", onTap: () {}, context: context),
              commonRowWidget(
                  title: "Tax rate",
                  value: "none",
                  onTap: () {},
                  context: context),
              commonRowWidget(
                  title: "Tax", value: "0.00", onTap: () {}, context: context),
              commonRowWidget(
                  title: "Total Amount",
                  value: "0.0",
                  onTap: () {},
                  context: context),
            ],
          ),
        ),
      ),
    );
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
                                  color: selectedValue == list[index]
                                      ? activeTxtColor
                                      : textColor),
                            ),
                            value: list[index],
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                                if (bottomSheetType == "category") {
                                  categoryValue = selectedValue;
                                }
                                if (bottomSheetType == "product") {
                                  productValue = selectedValue;
                                }
                                if (bottomSheetType == "class") {
                                  classValue = selectedValue;
                                }
                                if (bottomSheetType == "location") {
                                  locationValue = selectedValue;
                                }
                                if (bottomSheetType == "customer") {
                                  customerValue = selectedValue;
                                }
                              });
                              selectedValueC.value = categoryValue;
                              selectedValueP.value = productValue;
                              selectedValueClass.value = classValue;
                              selectedValueL.value = locationValue;
                              selectedValueCustomer.value = customerValue;
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
