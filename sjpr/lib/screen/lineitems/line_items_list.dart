import 'package:flutter/material.dart';
import 'package:sjpr/model/lineitem_list_model.dart';
import 'package:sjpr/screen/lineitems/line_items_detail.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/widgets/empty_item_widget.dart';
import 'line_item_list_bloc.dart';

class LineItemsListScreen extends StatefulWidget {
  final String id;
  final String currencySign;
  final int isPurchase;
  final bool isReadOnly;

  const LineItemsListScreen(
      {super.key,
      required this.id,
      required this.currencySign,
      required this.isPurchase,
      required this.isReadOnly});

  @override
  State<LineItemsListScreen> createState() => _LineItemsListScreenState();
}

class _LineItemsListScreenState extends State<LineItemsListScreen> {
  late LineItemListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = LineItemListBloc();
    bloc.getLineItemList(context, widget.id);
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
      body: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            return false;
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Line Items",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: activeTxtColor,
                          fontSize: 24),
                    ),
                    widget.isReadOnly
                        ? Center()
                        : InkWell(
                            onTap: () {
                              onItemTap(lineitem_id: "");
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: backGroundColor,
                                  border: Border.all(
                                      color: activeTxtColor, width: 2)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: activeTxtColor,
                                    size: 16,
                                  ),
                                  Text(
                                    "Add",
                                    style: TextStyle(
                                        color: activeTxtColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: bloc.isWaitingForDetail,
                        builder: (context, value1, child) {
                          return ValueListenableBuilder(
                            valueListenable: bloc.lineItemListData,
                            builder: (context, value, child) {
                              return (value.isEmpty)
                                  ? value1 == false
                                      ? EmptyItemWidget(
                                          title: StringUtils.noLineItems,
                                          detail: "")
                                      : Container()
                                  : getView(value);
                            },
                          );
                        })),
                const SizedBox(
                  height: 20,
                ),
                /*const Divider(
              thickness: 4,
              color: Color.fromRGBO(44, 45, 51, 1),
            ),*/
                /* GestureDetector(
              onTap: () {
                summeryBottomSheet(context: context);
              },
              child: Text(
                "Summary",
                style: TextStyle(
                    color: activeTxtColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(44, 45, 51, 1),
                        borderRadius: BorderRadius.circular(8)),
                    height: 98,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Line items",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: textColor),
                        ),
                        Text(
                          "\u{20AC}1232.00",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: textColor),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(44, 45, 51, 1),
                        borderRadius: BorderRadius.circular(8)),
                    height: 98,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Out by",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: textColor),
                        ),
                        const Text(
                          "\u{20AC}1202.00",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.red),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(44, 45, 51, 1),
                        borderRadius: BorderRadius.circular(8)),
                    height: 98,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Items total",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: textColor),
                        ),
                        const Text(
                          "\u{20AC}1232.00",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.green),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )*/
              ],
            ),
          )),
    );
  }

  Widget getView(List<LineItemListData> value) {
    return value.isEmpty
        ? EmptyItemWidget(title: StringUtils.noLineItems, detail: "")
        : ListView.builder(
            shrinkWrap: true,
            itemCount: value.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: listTileBgColor,
                ),
                child: ListTile(
                  onTap: () async {
                    onItemTap(lineitem_id: value[index].id ?? "");
                  },
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  title: Text(
                    (value[index].name.isNotEmpty)
                        ? value[index].name
                        : (value[index].description.isNotEmpty)
                            ? value[index].description
                            : "Line Item ${index + 1}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: textColor),
                  ),
                  subtitle: Text(
                    value[index].categoryName ?? "",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: textColor),
                  ),
                  trailing: Wrap(
                      //Wrap - place in row if space, otherwise wrap
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.currencySign +
                                  value[index].totalAmount.toString() ??
                              "",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: textColor,
                        )
                      ]),
                ),
              );
            });
  }

  Future<void> onItemTap({required String lineitem_id}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LineItemsDetailScreen(
                  lineitem_id: lineitem_id,
                  invoice_id: widget.id,
                  currencySign: widget.currencySign,
                  isPurchase: widget.isPurchase,
                  isReadOnly: widget.isReadOnly,
                ))).then((response) async {
      if (!widget.isReadOnly) {
        await bloc.getLineItemList(context, widget.id);
      }

      setState(() {});
    });
  }
}

Widget commonRowWidget(
    {required title, required subtitle, required value, required onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: listTileBgColor,
      ),
      child: const ListTile(
        title: Text(""),
      ),
    ),
  );
}

summeryBottomSheet({
  required context,
}) {
  return showModalBottomSheet(
      backgroundColor: backGroundColor,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            //  height: MediaQuery.of(context).size.height*0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Summary",
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
                Text(
                  "Line items",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(44, 45, 51, 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Net",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          ),
                          Text(
                            "\u{20AC}1,232.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          ),
                          Text(
                            "\u{20AC} 0.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          ),
                          Text(
                            "\u{20AC}1,232.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Out by",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(44, 45, 51, 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Net",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.red),
                          ),
                          Text(
                            "\u{20AC}1,232.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.red),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          ),
                          Text(
                            "\u{20AC} 0.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.red),
                          ),
                          Text(
                            "\u{20AC}1,232.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Items total",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: textColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(44, 45, 51, 1),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Net",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.red),
                          ),
                          Text(
                            "\u{20AC}1,232.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.red),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          ),
                          Text(
                            "\u{20AC} 0.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: textColor),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.green),
                          ),
                          Text(
                            "\u{20AC}1,232.00",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
