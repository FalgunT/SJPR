import 'package:flutter_svg/svg.dart';
import 'package:sjpr/model/item_class.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/screen/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import '../dashboard/dashboard.dart';
import '../quickc/quick_catch.dart';

class ClientArea extends StatefulWidget {
  const ClientArea({super.key});

  @override
  State<ClientArea> createState() => _ClientAreaState();
}

class _ClientAreaState extends State<ClientArea> with TickerProviderStateMixin {
  final DashboardBloc bloc = DashboardBloc.getInstance();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Item>? _menu;
  List<QuickCatchItems> shares = [];
  List<Item> addItems() {
    List<Item> data = [];
    data.add(Item(
        index: 0,
        headerValue: StringUtils.directorship,
        leadingIcon: SvgImages.directorship,
        isExpanded: false));
    data.add(Item(
        index: 1,
        headerValue: StringUtils.shares,
        leadingIcon: SvgImages.shares,
        isExpanded: false));
    data.add(Item(
        index: 2,
        headerValue: StringUtils.myDocuments,
        leadingIcon: SvgImages.myDoc,
        isExpanded: false));
    data.add(Item(
        index: 3,
        headerValue: StringUtils.accSoftware,
        leadingIcon: SvgImages.accSw,
        isExpanded: false));
    data.add(Item(
        index: 4,
        headerValue: StringUtils.quickCatch,
        leadingIcon: SvgImages.menuQuickCatch,
        isExpanded: false));
    data.add(Item(
        index: 5,
        headerValue: StringUtils.myAccount,
        leadingIcon: SvgImages.myAcc,
        isExpanded: false));
    data.add(Item(
        index: 6,
        headerValue: StringUtils.quickPOS,
        leadingIcon: SvgImages.quickPos,
        isExpanded: false));
    data.add(Item(
        index: 7,
        headerValue: StringUtils.myReports,
        leadingIcon: SvgImages.menuMyRep,
        isExpanded: false));
    data.add(Item(
        index: 8,
        headerValue: StringUtils.myCommunications,
        leadingIcon: SvgImages.myComm,
        isExpanded: false));
    data.add(Item(
        index: 9,
        headerValue: StringUtils.myTasks,
        leadingIcon: SvgImages.myTasks,
        isExpanded: false));
    return data;
  }

  @override
  void initState() {
    super.initState();
    _menu = addItems();
    List<DashboardItems> meta = [], alphabet = [], lamborghini = [];
    meta.add(DashboardItems(SvgImages.qc1, 'YTD NBFT', '£30,000'));
    meta.add(DashboardItems(SvgImages.qc2, 'YTD Turnover', '£1.5m'));
    meta.add(DashboardItems(SvgImages.qc2, 'YTD Debt', '£2,500'));
    meta.add(DashboardItems(SvgImages.qc2, 'YTD Receivables', '£1,200'));
    shares.add(QuickCatchItems('Meta ltd15%', dashboardItems: meta));

    alphabet.add(DashboardItems(SvgImages.qc1, 'YTD NBFT', '£45,000'));
    alphabet.add(DashboardItems(SvgImages.qc2, 'YTD Turnover', '£2.5m'));
    alphabet.add(DashboardItems(SvgImages.qc2, 'YTD Debt', '£1,500'));
    alphabet.add(DashboardItems(SvgImages.qc2, 'YTD Receivables', '£1,500'));
    shares.add(QuickCatchItems('Alphabet ltd 90%', dashboardItems: alphabet));

    lamborghini.add(DashboardItems(SvgImages.qc1, 'YTD NBFT', '£30,000'));
    lamborghini.add(DashboardItems(SvgImages.qc2, 'YTD Turnover', '£2.5m'));

    shares
        .add(QuickCatchItems('Lamborghini 100%', dashboardItems: lamborghini));
  }

  void expansionCallBack(int index, bool isExpanded) {
    setState(() {
      for (int i = 0; i < _menu!.length; i++) {
        if (i != index) {
          _menu![i].isExpanded = false;
        }
      }

      if (index == 0 || index == 1) {
        bool newValue = !_menu![index].isExpanded;
        _menu![index].isExpanded = newValue;
        isExpanded = newValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        /*  appBar: AppBar(
         leading: const Icon(Icons.keyboard_arrow_down,color: Colors.white,),
       ),*/
        body: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          //decoration: const BoxDecoration(color: Color(0xFF010101)),
          child: Stack(
            children: [
              Container(
                height: 385,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetImages.imageBgLayer),
                    //fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.50, -3.00),
                    end: Alignment(0.5, 1),
                    colors: [Color(0x90000000), Color(0xff000000)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    AppBar(
                      backgroundColor: Colors.transparent,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 20),
                      child: Text(
                        StringUtils.clientArea,
                        style: const TextStyle(
                          color: Color(0xFFB4982A),
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'John Smith',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            ListView.builder(
                              padding: const EdgeInsets.all(8),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _menu!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = _menu!.elementAt(index);
                                return Card(
                                  color: const Color(0xFF151515),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ExpansionTile(
                                    leading: SvgPicture.asset(
                                      item.leadingIcon,
                                      /* height: 20,
                                     width: 20,*/
                                    ),
                                    trailing: item.isExpanded
                                        ? const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Colors.white,
                                          ),
                                    initiallyExpanded: item.isExpanded,
                                    expandedCrossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    expandedAlignment: Alignment.bottomCenter,
                                    //col: const Color(0xFF151515),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onExpansionChanged: (bool isExpanded) {
                                      expansionCallBack(index, isExpanded);
                                    },
                                    title: Text(
                                      item.headerValue ?? "",
                                      style: const TextStyle(
                                        color: Color(0xFFD4D4D4),
                                        fontSize: 15,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.24,
                                      ),
                                    ),
                                    children: [
                                      index == 0
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  left: 16, top: 8),
                                              child: ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 24),
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    var item =
                                                        _menu!.elementAt(index);
                                                    return Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          SvgImages.bullet,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          item.headerValue ??
                                                              "",
                                                          style:
                                                              const TextStyle(
                                                            color: Color(
                                                                0xFFD4D4D4),
                                                            fontSize: 15,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing:
                                                                -0.24,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            )
                                          : index == 1
                                              ? ListView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 12),
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: shares.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    var item =
                                                        shares.elementAt(index);
                                                    return Container(
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 8,
                                                          horizontal: 16),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16),
                                                      decoration:
                                                          ShapeDecoration(
                                                        color: Colors.black,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            item.title ?? "",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xFFBA9E2E),
                                                              fontSize: 15,
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              letterSpacing:
                                                                  -0.24,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  shares
                                                                          .elementAt(
                                                                              index)
                                                                          .dashboardItems
                                                                          ?.elementAt(
                                                                              0)
                                                                          .title ??
                                                                      "",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFFDFDFDF),
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    letterSpacing:
                                                                        -0.24,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  shares
                                                                          .elementAt(
                                                                              index)
                                                                          .dashboardItems
                                                                          ?.elementAt(
                                                                              0)
                                                                          .subTitle ??
                                                                      "",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFF2BB431),
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    letterSpacing:
                                                                        -0.24,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  shares
                                                                          .elementAt(
                                                                              index)
                                                                          .dashboardItems
                                                                          ?.elementAt(
                                                                              1)
                                                                          .title ??
                                                                      "",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFFDFDFDF),
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    letterSpacing:
                                                                        -0.24,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  shares
                                                                          .elementAt(
                                                                              index)
                                                                          .dashboardItems
                                                                          ?.elementAt(
                                                                              1)
                                                                          .subTitle ??
                                                                      "",
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xFFB4982A),
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Inter',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    letterSpacing:
                                                                        -0.24,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          shares
                                                                      .elementAt(
                                                                          index)
                                                                      .dashboardItems!
                                                                      .length >
                                                                  2
                                                              ? Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        shares.elementAt(index).dashboardItems?.elementAt(2).title ??
                                                                            "",
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color(0xFFDFDFDF),
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          letterSpacing:
                                                                              -0.24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        shares.elementAt(index).dashboardItems?.elementAt(2).subTitle ??
                                                                            "",
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color(0xFFF03333),
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          letterSpacing:
                                                                              -0.24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container(),
                                                          shares
                                                                      .elementAt(
                                                                          index)
                                                                      .dashboardItems!
                                                                      .length >
                                                                  3
                                                              ? Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        shares.elementAt(index).dashboardItems?.elementAt(3).title ??
                                                                            "",
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color(0xFFDFDFDF),
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          letterSpacing:
                                                                              -0.24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        shares.elementAt(index).dashboardItems?.elementAt(3).subTitle ??
                                                                            "",
                                                                        style:
                                                                            const TextStyle(
                                                                          color:
                                                                              Color(0xFFDFDFDF),
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Inter',
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          letterSpacing:
                                                                              -0.24,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Container(),
                                                        ],
                                                      ),
                                                    );
                                                  })
                                              : Container(),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        )),
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
