import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sjpr/widgets/common_button.dart';
import 'package:sjpr/utils/color_utils.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  String classValue = "";
  String categoryValue = "";
  String productValue = "";
  String supplierValue = "";
  String currencyValue = "";
  String taxValue = "";
  String paymentMethod = "";
  List ownedByValue = [];
  List ownedByList = [
    "John Smith",
    "Luiz Caprio",
    "Jonas Junior",
    "Bruno Takashi",
    "Wilson Ulisses"
  ];

  multipleSelectBottomSheet({
    required context,
    required list,
    required title,
    required bottomSheetType,
  }) {
    List<String> checkBoxValue = [];
    return showModalBottomSheet(
        backgroundColor: listTileBgColor,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.65,
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
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Checkbox(
                              value: checkBoxValue.contains(list[index]),
                              activeColor: activeTxtColor,
                              checkColor: buttonTextColor,
                              onChanged: (value) {
                                setState(() {
                                  if (checkBoxValue.contains(list[index])) {
                                    checkBoxValue.remove(list[index]);
                                  } else {
                                    checkBoxValue.add(list[index]);
                                  }
                                  if (bottomSheetType == "Owned by") {
                                    ownedByValue = checkBoxValue;
                                    print("ownedByValue----$ownedByValue");
                                  }
                                });
                              }),
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
                  SizedBox(
                    height: 20,
                  ),
                  CommonButton(
                      content: "Done",
                      bgColor: buttonBgColor,
                      textColor: buttonTextColor,
                      outlinedBorderColor: buttonBgColor,
                      onPressed: () {})
                ],
              ),
            ),
          );
        });
  }

  singleSelectBottomSheet({
    required context,
    required list,
    required title,
    required bottomSheetType,
  }) {
    String checkBoxValue = '';
    return showModalBottomSheet(
        backgroundColor: listTileBgColor,
        context: context,
        builder: (context) {
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
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Checkbox(
                            value: checkBoxValue == list[index],
                            activeColor: activeTxtColor,
                            checkColor: buttonTextColor,
                            onChanged: (value) {
                              setState(() {
                                checkBoxValue = list[index];
                                if (bottomSheetType == "Category") {
                                  categoryValue = list[index];
                                }
                                if (bottomSheetType == "Product") {
                                  productValue = list[index];
                                }
                              });
                            }),
                        title: Text(
                          list[index],
                          style: TextStyle(
                              color: textColor,
                              //   categoryValue == categoryList[index]?activeTxtColor:textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    })
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    List categoryList = [
      "Equipment rental",
      "Office supplies",
      "Purchases",
      "Professional fees",
      "Services"
    ];
    List productList = ["Example", "Licence Fee", "Example", "Example"];
    List ownedByList = [
      "John Smith",
      "Luiz Caprio",
      "Jonas Junior",
      "Bruno Takashi",
      "Wilson Ulisses"
    ];

    return Scaffold(
      backgroundColor: backGroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          padding: const EdgeInsets.all(20),
          color: listTileBgColor,
          height: 90,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                  child: CommonButton(
                content: 'Submit',
                bgColor: buttonBgColor,
                textColor: buttonTextColor,
                outlinedBorderColor: buttonBgColor,
                onPressed: () {},
              )),
              SizedBox(
                width: 40,
              ),
              Expanded(
                  child: CommonButton(
                content: 'Retake',
                bgColor: Colors.black,
                textColor: activeTxtColor,
                outlinedBorderColor: buttonBgColor,
                onPressed: () {},
              )),
            ],
          )),
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
            children: <Widget>[
              Text(
                "Review",
                style: TextStyle(
                    color: activeTxtColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                width: MediaQuery.sizeOf(context).width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/image.png",
                      fit: BoxFit.fill,
                    )),
              ),
              Text(
                "Details Info",
                style: TextStyle(
                    color: activeTxtColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              commonRowWidget(
                  title: "Category",
                  value: categoryValue,
                  onTap: () {
                    singleSelectBottomSheet(
                        context: context,
                        list: categoryList,
                        title: "Category",
                        bottomSheetType: "Category");
                  }),
              commonRowWidget(
                  title: "Product/Service",
                  value: productValue,
                  onTap: () {
                    singleSelectBottomSheet(
                        context: context,
                        list: productList,
                        title: "Product/Service",
                        bottomSheetType: "Product");
                  }),
              commonRowWidget(
                  title: "Owned by",
                  value: ownedByValue.join(", "),
                  onTap: () {
                    multipleSelectBottomSheet(
                        context: context,
                        list: ownedByList,
                        title: "Owned By",
                        bottomSheetType: "Owned by");
                  }),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Description",
                style: TextStyle(
                    color: activeTxtColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF26282C)),
                child: Text(
                  "Posted invoice",
                  style: TextStyle(color: textColor),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CommonButton(
                  content: 'Publish description',
                  bgColor: Colors.grey,
                  textColor: Colors.white,
                  outlinedBorderColor: Colors.grey,
                  onPressed: () {}),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Document reference",
                style: TextStyle(
                    color: activeTxtColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              commonRowWidget(
                  title: "Class", value: "Liquidations", onTap: () {}),
              commonRowWidget(
                  title: "Location", value: "Lisbosa,Portugaol", onTap: () {}),
              commonRowWidget(
                  title: "Customer", value: "Bruno Luiz", onTap: () {}),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: listTileBgColor,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Paid",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
                    CupertinoSwitch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: activeTxtColor,
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
