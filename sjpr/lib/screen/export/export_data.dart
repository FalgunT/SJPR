import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/model/category_list_model.dart';
import 'package:sjpr/screen/export/export_data_bloc.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ExportDataScreen extends StatefulWidget {
  const ExportDataScreen({super.key});

  @override
  State<ExportDataScreen> createState() => _ExportDataScreenState();
}

class _ExportDataScreenState extends State<ExportDataScreen> {
  String? selectedValue = "";
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDayI, _selectedDayF;
  String initialDate = "";
  String finalDate = "";
  List categoryValue = [];
  List typeValue = [];
  List ownedByValue = [];
  List categoryList = [
    "Equipment rental",
    "Office supplies",
    "Purchases",
    "Professional fees",
    "Services"
  ];
  List typeList = [
    "Receipt",
    "ATM Withdrawal",
    "Invoice",
    "Professional fees",
    "Services",
    "Purchases"
  ];
  List ownedByList = [
    "John Smith",
    "Luiz Caprio",
    "Jonas Junior",
    "Bruno Takashi",
    "Wilson Ulisses"
  ];

  ValueNotifier<String> selectedValueE = ValueNotifier<String>(""),
      selectedValueI = ValueNotifier<String>(""),
      selectedValueF = ValueNotifier<String>(""),
      selectedValueC = ValueNotifier<String>(""),
      selectedValueT = ValueNotifier<String>(""),
      selectedValueO = ValueNotifier<String>("");
  final ExportDataBloc bloc = ExportDataBloc();

  @override
  void initState() {
    bloc.getCategoryList(context);
    super.initState();
  }

  calenderBottomSheet({
    required context,
    required dateType,
  }) {
    return showModalBottomSheet(
        backgroundColor: listTileBgColor,
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dateType,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(dateType == "Final Period"
                                ? _selectedDayF
                                : _selectedDayI);
                          },
                          icon: Icon(
                            Icons.close,
                            color: textColor,
                          ))
                    ],
                  ),
                  TableCalendar(
                      daysOfWeekHeight: 20,
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle:
                              TextStyle(color: activeTxtColor, fontSize: 18),
                          weekendStyle:
                              TextStyle(color: activeTxtColor, fontSize: 18)),
                      headerStyle: HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          leftChevronIcon: const Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                          titleTextStyle:
                              TextStyle(color: activeTxtColor, fontSize: 18)),
                      calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                              color: buttonBgColor, shape: BoxShape.circle),
                          selectedTextStyle: TextStyle(
                              color: buttonTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          weekendTextStyle: TextStyle(
                              color: textColor.withOpacity(0.5), fontSize: 18),
                          outsideDaysVisible: false,
                          todayDecoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          todayTextStyle: TextStyle(
                              color: buttonTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          defaultTextStyle: TextStyle(
                              color: textColor.withOpacity(0.5), fontSize: 18)),
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        if (dateType == "Final Period") {
                          return isSameDay(_selectedDayF, day);
                        } else {
                          return isSameDay(_selectedDayI, day);
                        }
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        _focusedDay = focusedDay;
                        if (!isSameDay(_selectedDayF, selectedDay) &&
                            dateType == "Final Period") {
                          setState(() {
                            _selectedDayF = selectedDay;
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(selectedDay);
                            finalDate = formattedDate;
                            selectedValueF.value = finalDate;
                          });
                        } else if (!isSameDay(_selectedDayI, selectedDay)) {
                          setState(() {
                            _selectedDayI = selectedDay;
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(selectedDay);
                            initialDate = formattedDate;
                            selectedValueI.value = initialDate;
                          });
                        }
                      }),
                ],
              ),
            );
          });
        });
  }

  checkListBottomSheet(
      {required context,
      required list,
      required title,
      required bottomSheetType,
      required checkBoxValue}) {
    return showModalBottomSheet(
        backgroundColor: listTileBgColor,
        context: context,
        builder: (context) {
          var oldCheckBoxValue = [];
          oldCheckBoxValue.addAll(checkBoxValue);
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                // height: MediaQuery.of(context).size.height * 0.65,
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
                              if (bottomSheetType == "Category") {
                                categoryValue = oldCheckBoxValue;
                              }
                              if (bottomSheetType == "Type") {
                                typeValue = oldCheckBoxValue;
                              }
                              if (bottomSheetType == "Owned by") {
                                ownedByValue = oldCheckBoxValue;
                              }
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: textColor,
                            ))
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                if (checkBoxValue.contains(list[index])) {
                                  checkBoxValue.remove(list[index]);
                                } else {
                                  checkBoxValue.add(list[index]);
                                }
                                if (bottomSheetType == "Category") {
                                  categoryValue = checkBoxValue;
                                }
                                if (bottomSheetType == "Type") {
                                  typeValue = checkBoxValue;
                                }
                                if (bottomSheetType == "Owned by") {
                                  ownedByValue = checkBoxValue;
                                }
                              });
                              /*selectedValueC.value =
                                  categoryValue.join(", ").toString();
                              selectedValueT.value =
                                  typeValue.join(", ").toString();
                              selectedValueO.value =
                                  ownedByValue.join(", ").toString();*/
                            },
                            leading: Checkbox(
                                value: checkBoxValue.contains(list[index]),
                                activeColor: activeTxtColor,
                                checkColor: buttonTextColor,
                                onChanged: (value) {}),
                            title: Text(
                              list[index],
                              style: TextStyle(
                                  color: textColor,
                                  //   categoryValue == categoryList[index]?activeTxtColor:textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(
                        content: "Done",
                        bgColor: buttonBgColor,
                        textColor: buttonTextColor,
                        outlinedBorderColor: buttonBgColor,
                        onPressed: () {
                          selectedValueC.value =
                              categoryValue.join(", ").toString();
                          selectedValueT.value =
                              typeValue.join(", ").toString();
                          selectedValueO.value =
                              ownedByValue.join(", ").toString();
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Export Data",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: activeTxtColor,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              ValueListenableBuilder(
                  valueListenable: selectedValueE,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Excel template",
                        value: value,
                        onTap: () {
                          showModalBottomSheet(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.sizeOf(context).height * 0.4),
                              backgroundColor: listTileBgColor,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.4,
                                    padding: const EdgeInsets.all(20),
                                    child: ListView(
                                      shrinkWrap: true,
                                      //padding: EdgeInsets.all(4),
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Excel template",
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
                                                )),
                                          ],
                                        ),
                                        SizedBox(
                                          //height: 40,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: RadioListTile(
                                            activeColor: activeTxtColor,
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 6,
                                                    right: 0,
                                                    bottom: 0,
                                                    top: 0),
                                            title: Text(
                                              'Capium',
                                              style: TextStyle(
                                                  color:
                                                      selectedValue == "Capium"
                                                          ? activeTxtColor
                                                          : textColor),
                                            ),
                                            value: "Capium",
                                            groupValue: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue = "Capium";
                                              });
                                              selectedValueE.value =
                                                  selectedValue ?? "";
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          //height: 40,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: RadioListTile(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 6,
                                                    right: 0,
                                                    bottom: 0,
                                                    top: 0),
                                            activeColor: activeTxtColor,
                                            title: Text(
                                              'QuickBooks',
                                              style: TextStyle(
                                                  color: selectedValue ==
                                                          "QuickBooks"
                                                      ? activeTxtColor
                                                      : textColor),
                                            ),
                                            value: "QuickBooks",
                                            groupValue: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue = "QuickBooks";
                                              });
                                              selectedValueE.value =
                                                  selectedValue ?? "";
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          //height: 40,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: RadioListTile(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 6,
                                                    right: 0,
                                                    bottom: 0,
                                                    top: 0),
                                            activeColor: activeTxtColor,
                                            title: Text(
                                              'Xero',
                                              style: TextStyle(
                                                  color: selectedValue == "Xero"
                                                      ? activeTxtColor
                                                      : textColor),
                                            ),
                                            value: "Xero",
                                            groupValue: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue = "Xero";
                                              });
                                              selectedValueE.value =
                                                  selectedValue ?? "";
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          //height: 40,
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: RadioListTile(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 6,
                                                    right: 0,
                                                    bottom: 0,
                                                    top: 0),
                                            activeColor: activeTxtColor,
                                            title: Text(
                                              'FreeAgent',
                                              style: TextStyle(
                                                  color: selectedValue ==
                                                          "FreeAgent"
                                                      ? activeTxtColor
                                                      : textColor),
                                            ),
                                            value: "FreeAgent",
                                            groupValue: selectedValue,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValue =
                                                    "FreeAgent"; // Update _selectedValue when option 1 is selected
                                              });
                                              selectedValueE.value =
                                                  selectedValue ?? "";
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              });
                          setState(() {});
                        });
                  }),
              ValueListenableBuilder(
                  valueListenable: selectedValueI,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Initial period",
                        value: initialDate,
                        onTap: () {
                          calenderBottomSheet(
                              context: context, dateType: "Initial period");
                        });
                  }),
              ValueListenableBuilder(
                  valueListenable: selectedValueF,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Final period",
                        value: finalDate,
                        onTap: () {
                          calenderBottomSheet(
                              context: context, dateType: "Final Period");
                        });
                  }),
              ValueListenableBuilder(
                valueListenable: selectedValueC,
                builder: (context, value, _) {
                  // This builder will only get called when the _counter
                  // is updated.
                  return commonRowWidget(
                      title: "Category",
                      value: value,
                      onTap: () {
                        checkListBottomSheet(
                            context: context,
                            list: categoryList,
                            title: "Category",
                            bottomSheetType: "Category",
                            checkBoxValue: categoryValue);
                      });
                },
              ),
              ValueListenableBuilder(
                  valueListenable: selectedValueT,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Type",
                        value: value,
                        onTap: () {
                          checkListBottomSheet(
                              context: context,
                              list: typeList,
                              title: "Type",
                              bottomSheetType: "Type",
                              checkBoxValue: typeValue);
                        });
                  }),
              ValueListenableBuilder(
                  valueListenable: selectedValueO,
                  builder: (context, value, _) {
                    return commonRowWidget(
                        title: "Owned by",
                        value: value,
                        onTap: () {
                          checkListBottomSheet(
                              context: context,
                              list: ownedByList,
                              title: "Owned by",
                              bottomSheetType: "Owned by",
                              checkBoxValue: ownedByValue);
                        });
                  }),
              /*StreamBuilder<List<CategoryListData>?>(
                  stream: bloc.categoryListStream,
                  builder: (context, snapshot) {
                    List<CategoryListData> temp = snapshot.data!. ((element) => element.categoryName);
                    return ValueListenableBuilder(
                      valueListenable: selectedValueC,
                      builder: (context, value, _) {
                        // This builder will only get called when the _counter
                        // is updated.
                        return commonRowWidget(
                            title: "Category",
                            value: value,
                            onTap: () {
                              checkListBottomSheet(
                                  context: context,
                                  list: temp,
                                  title: "Category",
                                  bottomSheetType: "Category",
                                  checkBoxValue: categoryValue);
                            });
                      },
                    );
                  }),*/
              const SizedBox(
                height: 50,
              ),
              CommonButton(
                  content: "Export data",
                  bgColor: buttonBgColor,
                  textColor: buttonTextColor,
                  outlinedBorderColor: buttonBgColor,
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}

Widget commonRowWidget({required title, required value, required onTap}) {
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
                color: textColor, fontSize: 17, fontWeight: FontWeight.bold),
          )),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: textColor, fontSize: 17),
            ),
          ),
          const SizedBox(
            width: 5,
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
