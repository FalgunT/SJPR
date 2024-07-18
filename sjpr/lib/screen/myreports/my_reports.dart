import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/screen/dashboard/dashboard.dart';
import 'package:sjpr/screen/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class MyReports extends StatefulWidget {
  const MyReports({super.key});

  @override
  State<MyReports> createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> with TickerProviderStateMixin {
  final DashboardBloc bloc = DashboardBloc.getInstance();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DashboardItems> myReports = [];
  Map<String, double> dataMap = {
    "Flutter": 2,
    "React": 4,
    "Xamarin": 4,
    "Ionic": 5,
  };
  List<Color> colorList = [
    const Color(0xFFFFE57F),
    const Color(0xFF16BED5),
    const Color(0xFF1DDD8C),
    const Color(0xFFF76565),
  ];

  @override
  void initState() {
    super.initState();
    myReports.add(DashboardItems('#2CB531', 'YTD NPBT', '£35,000'));
    myReports.add(DashboardItems('#B5992A', 'YTD T/O ', '£500k'));
    myReports.add(DashboardItems('#F03333', 'YTD DLA', '£75k'));
    myReports.add(DashboardItems('#2CB531', 'YTD Shareholders Funds', '£250'));
    myReports.add(DashboardItems('#F03333', 'YTD C.TAX ', '£5690'));
    myReports.add(DashboardItems('#F03333', 'VAT', '£257'));
  }

  @override
  Widget build(BuildContext context) {
    //final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //backgroundColor: Colors.red,
        body: SingleChildScrollView(
          clipBehavior: Clip.antiAlias,
          //decoration: const BoxDecoration(color: Color(0xFF010101)),
          child: Stack(
            //alignment: AlignmentDirectional.topCenter,
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
                height: MediaQuery.of(context).size.height,
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
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 20),
                      child: Text(
                        StringUtils.myReports,
                        style: const TextStyle(
                          color: Color(0xFFB4982A),
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      //height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    StringUtils.teslaPlc,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      color: Color(0xFFBA9E2E),
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                ),
                                GridView.count(
                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.2,
                                  // Generate 100 widgets that display their index in the List.
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 20.0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children:
                                      List.generate(myReports.length, (index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF151515),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            myReports.elementAt(index).title ??
                                                "",
                                            style: const TextStyle(
                                              color: Color(0xFFCEC7C7),
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.24,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            myReports
                                                    .elementAt(index)
                                                    .subTitle ??
                                                "",
                                            style: TextStyle(
                                              color: HexColor(myReports
                                                      .elementAt(index)
                                                      .image ??
                                                  ""),
                                              fontSize: 13,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment(-1.00, -0.04),
                                          end: Alignment(1, 0.04),
                                          colors: [
                                            Color(0xFFB4982A),
                                            Color(0xFFFFDF62)
                                          ],
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            SvgImages.customerSales,
                                            height: 24,
                                            width: 24,
                                            //color: Colors.black,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text(
                                            'Customer Sales',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF151515),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              SvgImages.busPerformance,
                                              height: 24,
                                              width: 24,
                                              //color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Expanded(
                                              child: Text(
                                                'Business Performance',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: -0.24,
                                                ),
                                                maxLines: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  //mainAxisAlignment: MainAxisAlign4ment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF151515),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            SvgImages.cashFlow,
                                            height: 24,
                                            width: 24,
                                            colorFilter: const ColorFilter.mode(
                                                Colors.white, BlendMode.clear),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Text(
                                            'Cash flow forecast',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.24,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF151515),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        child: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              SvgImages.supplierBreakdown,
                                              height: 24,
                                              width: 24,
                                              //color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Text(
                                              'Suppliers breakdown',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF2C2D33),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 10,
                                        offset: Offset(0, 2),
                                        spreadRadius: 0,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Text(
                                          'Customer Sales',
                                          style: TextStyle(
                                            color: Color(0xFFBDBDBD),
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      PieChart(
                                        dataMap: dataMap,
                                        animationDuration:
                                            const Duration(milliseconds: 800),
                                        chartLegendSpacing: 32,
                                        chartRadius:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        colorList: colorList,
                                        initialAngleInDegree: 0,
                                        chartType: ChartType.disc,
                                        ringStrokeWidth: 32,
                                        //centerText: "HYBRID",
                                        legendOptions: const LegendOptions(
                                          showLegendsInRow: false,
                                          legendPosition: LegendPosition.right,
                                          showLegends: false,
                                          legendShape: BoxShape.circle,
                                          legendTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        chartValuesOptions:
                                            const ChartValuesOptions(
                                          showChartValueBackground: false,
                                          showChartValues: false,
                                          showChartValuesInPercentage: false,
                                          showChartValuesOutside: false,
                                          decimalPlaces: 1,
                                        ),
                                        // gradientList: ---To add gradient colors---
                                        // emptyColorGradient: ---Empty Color gradient---
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF165BAA)),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Text(
                                                'Product 1',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF16BED5)),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Text(
                                                'Product 3',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFF765A3)),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Text(
                                                'Product 2',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 20,
                                                height: 10,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFF1DDD8C)),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Text(
                                                'Product 4',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ]),
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

class QuickCatchItems {
  String? title;
  List<DashboardItems>? dashboardItems;
  QuickCatchItems(this.title, {required this.dashboardItems});
}
