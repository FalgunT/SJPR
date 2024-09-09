import 'package:flutter_svg/svg.dart';
import 'package:sjpr/screen/invoice/invoice_list.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/screen/dashboard/dashboard.dart';
import 'package:sjpr/screen/dashboard/dashboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/widgets/comming_soon_dialog.dart';

class QuickCatch extends StatefulWidget {
  const QuickCatch({super.key});

  @override
  State<QuickCatch> createState() => _QuickCatchState();
}

class _QuickCatchState extends State<QuickCatch> with TickerProviderStateMixin {
  final DashboardBloc bloc = DashboardBloc.getInstance();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<QuickCatchItems> quickCatchItems = [];

  @override
  void initState() {
    super.initState();
    List<DashboardItems> salesInvoices = [],
        purchaseInvoice = [],
        exportData = [],
        bankStatUpload = [],
        suppStatements = [];
    salesInvoices
        .add(DashboardItems(SvgImages.qc1, StringUtils.makeInvoices, ''));
    salesInvoices
        .add(DashboardItems(SvgImages.qc2, StringUtils.catchInvoice, ''));
    quickCatchItems.add(QuickCatchItems(StringUtils.salesInvoices,
        dashboardItems: salesInvoices));

    purchaseInvoice
        .add(DashboardItems(SvgImages.qc1, StringUtils.makeBill, ''));
    purchaseInvoice
        .add(DashboardItems(SvgImages.qc2, StringUtils.catchBill, ''));
    quickCatchItems.add(QuickCatchItems(StringUtils.purchaseInvoice,
        dashboardItems: purchaseInvoice));

    exportData.add(DashboardItems(SvgImages.qc1, StringUtils.exportData, ''));

    quickCatchItems
        .add(QuickCatchItems(StringUtils.export, dashboardItems: exportData));

    bankStatUpload
        .add(DashboardItems(SvgImages.qc1, StringUtils.catchBankStat, ''));
    bankStatUpload
        .add(DashboardItems(SvgImages.qc2, StringUtils.uploadStat, ''));
    quickCatchItems.add(QuickCatchItems(StringUtils.bankStatUpload,
        dashboardItems: bankStatUpload));

    suppStatements
        .add(DashboardItems(SvgImages.qc1, StringUtils.catchStat, ''));
    suppStatements
        .add(DashboardItems(SvgImages.qc2, StringUtils.uploadStatements, ''));
    quickCatchItems.add(QuickCatchItems(StringUtils.suppStatements,
        dashboardItems: suppStatements));
  }

  @override
  Widget build(BuildContext context) {
    //final appTheme = AppTheme.of(context);
    return Scaffold(
      key: _scaffoldKey,
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
              //height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                      StringUtils.quickCatch,
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
                    padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
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
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          itemCount: quickCatchItems.length,
                          itemBuilder: (context, index) => ListTile(
                            tileColor: const Color(0x20DADADA),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    quickCatchItems.elementAt(index).title ??
                                        "",
                                    textAlign: TextAlign.center,
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
                                  crossAxisCount: 2,
                                  // Generate 100 widgets that display their index in the List.
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 20.0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: List.generate(
                                      quickCatchItems
                                          .elementAt(index)
                                          .dashboardItems!
                                          .length, (index1) {
                                    return GestureDetector(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            if (index1 == 0) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const CommingSoonDialog();
                                                },
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const InvoiceListScreen(
                                                    isPurchase: 0,
                                                  );
                                                }),
                                              );
                                            }
                                            break;
                                          case 1:
                                            if (index1 == 0) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return const CommingSoonDialog();
                                                },
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                                  return const InvoiceListScreen(
                                                    isPurchase: 1,
                                                  );
                                                }),
                                              );
                                            }
                                            break;
                                          case 2:
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CommingSoonDialog();
                                              },
                                            );

                                            /*Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                return const ExportDataScreen();
                                              }),
                                            );*/
                                            break;
                                          case 3:
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CommingSoonDialog();
                                              },
                                            );
                                            break;
                                          case 4:
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CommingSoonDialog();
                                              },
                                            );
                                            break;
                                          case 5:
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CommingSoonDialog();
                                              },
                                            );
                                            break;
                                          case 6:
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CommingSoonDialog();
                                              },
                                            );
                                            break;
                                          case 7:
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return const CommingSoonDialog();
                                              },
                                            );
                                            break;
                                          default:
                                            break;
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        clipBehavior: Clip.antiAlias,
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF151515),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              //padding: const EdgeInsets.all(12),
                                              //width: 22,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  12,
                                              //clipBehavior: Clip.antiAlias,
                                              decoration: const BoxDecoration(),
                                              child: SvgPicture.asset(
                                                quickCatchItems
                                                        .elementAt(index)
                                                        .dashboardItems!
                                                        .elementAt(index1)
                                                        .image ??
                                                    "",
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              quickCatchItems
                                                      .elementAt(index)
                                                      .dashboardItems!
                                                      .elementAt(index1)
                                                      .title ??
                                                  "",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFFEEEEEE),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    30,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              maxLines: 3,
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            dense: true,
                            //trailing: item.trailingIcon,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
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
