import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sjpr/model/split_list_model.dart';
import 'package:sjpr/screen/splititems/split_items_bloc.dart';
import 'package:sjpr/screen/splititems/split_items_detail.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/widgets/common_button.dart';
/*
class SplitItemsListScreen extends StatefulWidget {
  final String id;
  const SplitItemsListScreen({super.key, required this.id});
  @override
  State<SplitItemsListScreen> createState() => _SplitItemsListScreenState();
}

class _SplitItemsListScreenState extends State<SplitItemsListScreen> {
  late SplitItemsBloc bloc;

  @override
  void initState() {
    bloc = SplitItemsBloc();
    bloc.getSplitItemList(context, "142"); //widget.id);
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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Split Items",
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: activeTxtColor,
                      fontSize: 24),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplitItemsDetailScreen(
                                  splitListItemData: null,
                                )));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: backGroundColor,
                        border: Border.all(color: activeTxtColor, width: 2)),
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
              child: StreamBuilder<List<SplitListData>?>(
                  stream: bloc.splitItemListStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    }
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      var splitItemList = snapshot.data;
                      return ListView(
                        children: ListTile.divideTiles(
                          context: context,
                          tiles: List.generate(splitItemList?.length ?? 0,
                              (index) {
                            return SlideMenu(
                              menuItems: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SplitItemsDetailScreen(
                                                  splitListItemData:
                                                      splitItemList?[index],
                                                )));
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {},
                                ),
                              ],
                              child: ListTile(
  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SplitItemsDetailScreen(
                                                splitListItemData:
                                                    splitItemList?[index],
                                              )));
                                },

                                dense: true,
                                contentPadding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                title: Text(
                                  (splitItemList?[index].categoryId != null &&
                                          splitItemList![index]
                                              .categoryId!
                                              .isNotEmpty)
                                      ? splitItemList[index].categoryId!
                                      : "Line Item $index",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: textColor),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Amount : ${splitItemList?[index].totalAmount ?? ""}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: textColor),
                                    ),
                                    Text(
                                      'Total Tax Amount : ${splitItemList?[index].taxAmount ?? ""}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: textColor),
                                    ),
                                  ],
                                ),
    trailing: SizedBox(
                                  //width: 100,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: textColor,
                                  ),
                                ),

                              ),
                            );
                          }),
                        ).toList(),
                      );
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgImages.folder,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            StringUtils.noLineItems,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
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
    );
  }

  @override
  updateWidget() {
    setState(() {});
  }
}

class SlideMenu extends StatefulWidget {
  final Widget child;
  final List<Widget> menuItems;

  const SlideMenu({super.key, required this.child, required this.menuItems});

  @override
  _SlideMenuState createState() => _SlideMenuState();
}

class _SlideMenuState extends State<SlideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.35, 0.0))
            .animate(CurveTween(curve: Curves.decelerate).animate(_controller));

    return GestureDetector(
      onHorizontalDragUpdate: (data) {
        // we can access context.size here
        setState(() {
          _controller.value -= (data.primaryDelta! / context.size!.width);
        });
      },
      onHorizontalDragEnd: (data) {
        if (data.primaryVelocity! > 2500) {
          _controller
              .animateTo(.0); //close menu on fast swipe in the right direction
        } else if (_controller.value >= .5 || data.primaryVelocity! < -2500) //
        {
          // fully open if dragged a lot to left or on fast swipe to left
          _controller.animateTo(1.0);
        } else // close if none of above
        {
          _controller.animateTo(.0);
        }
      },
      child: Stack(
        children: <Widget>[
          SlideTransition(position: animation, child: widget.child),
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Stack(
                      children: <Widget>[
                        Positioned(
                          right: .0,
                          top: .0,
                          bottom: .0,
                          width: constraint.maxWidth * animation.value.dx * -1,
                          child: Container(
                            color: activeTxtColor,
                            child: Row(
                              children: widget.menuItems.map((child) {
                                return Expanded(
                                  child: child,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
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
}*/
