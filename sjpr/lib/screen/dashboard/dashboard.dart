import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sjpr/model/profile_model.dart';
import 'package:sjpr/screen/profile/profile_screen.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/screen/clienta/client_area.dart';
import 'package:sjpr/screen/dashboard/dashboard_bloc.dart';
import 'package:sjpr/screen/myreports/my_reports.dart';
import 'package:flutter/material.dart';
import 'package:sjpr/screen/quickc/quick_catch.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final DashboardBloc bloc = DashboardBloc.getInstance();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<DashboardItems> dashboardItems = [];

  @override
  void initState() {
    super.initState();
    bloc.getProfile(context, mounted);
    dashboardItems.add(DashboardItems(SvgImages.imageClientArea,
        StringUtils.clientArea, StringUtils.descClientArea));
    dashboardItems.add(DashboardItems(SvgImages.imageQuickCatch,
        StringUtils.quickCatch, StringUtils.descQuickCatch));
    dashboardItems.add(DashboardItems(SvgImages.imageMyReports,
        StringUtils.myReports, StringUtils.descMyReports));
    dashboardItems.add(DashboardItems(
        SvgImages.imageMyBusinesses, StringUtils.myBus, StringUtils.descMyBus));
    dashboardItems.add(DashboardItems(
        SvgImages.imageTaxCalc, StringUtils.taxCalc, StringUtils.descTaxCalc));
    dashboardItems.add(DashboardItems(SvgImages.imageTaxBusInfo,
        StringUtils.taxBusInfo, StringUtils.descTaxBusInfo));
  }

  @override
  Widget build(BuildContext context) {
    //final appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        //drawer: const NavBar(),
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
                      height: 48,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 28),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              StringUtils.welcomeDashboard,
                              style: const TextStyle(
                                color: Color(0xFFB4982A),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return const ProfileScreen();
                                }),
                              );
                            },
                            child: Container(
                              width: 62,
                              height: 41,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFD6BC51),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                children: [
                                  StreamBuilder<ProfileData?>(
                                      stream: bloc.profileStream,
                                      builder: (BuildContext context,
                                          AsyncSnapshot<ProfileData?>
                                              snapshot) {
                                        if (snapshot.hasData &&
                                            snapshot.data != null) {
                                          var profile = snapshot.data;
                                          if (profile != null &&
                                              profile.profileImage != null) {
                                            return Container(
                                              width: 33,
                                              height: 34,
                                              margin: const EdgeInsets.only(
                                                  left: 4),
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      profile.profileImage ??
                                                          ""),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: const OvalBorder(),
                                              ),
                                            );
                                          }
                                        }
                                        return Container(
                                          width: 33,
                                          height: 34,
                                          margin:
                                              const EdgeInsets.only(left: 4),
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(AssetImages
                                                  .personPlaceholder),
                                              fit: BoxFit.fill,
                                            ),
                                            shape: const OvalBorder(),
                                          ),
                                        );
                                      }),
                                  const Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFF8A7628),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const ScanDocumentPage();
                          }),
                        );
                      },
                      child: Container(
                        width: 180,
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF151515),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFB4982A)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Scan Document",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.56,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Icon(Icons.upload_file, color: Colors.white),
                          ],
                        ),
                      ),
                    ),*/
                    GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      padding: const EdgeInsets.all(12),
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(dashboardItems.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const ClientArea();
                                  }),
                                );
                                break;
                              case 1:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const QuickCatch();
                                  }),
                                );
                                break;
                              case 2:
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const MyReports();
                                  }),
                                );
                                break;
                              case 3:
                                break;
                              case 4:
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
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFB4982A)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0xFFFFCC00),
                                  blurRadius: 2,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  //clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(),
                                  child: SvgPicture.asset(
                                    dashboardItems.elementAt(index).image ?? "",
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  dashboardItems.elementAt(index).title ?? "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFB4982A),
                                    fontSize: 14,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.56,
                                  ),
                                ),
                                Text(
                                  dashboardItems.elementAt(index).subTitle ??
                                      "",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFEEEEEE),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
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

class DashboardItems {
  String? image;
  String? title;
  String? subTitle;
  DashboardItems(this.image, this.title, this.subTitle);
}
