import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxrun/common/common_background.dart';
import 'package:taxrun/common/image_utils.dart';
import 'package:taxrun/common/string_utils.dart';

class MyWalletPage extends StatefulWidget {
  //final LoginBloc loginBloc;

  const MyWalletPage({Key? key}) : super(key: key);

  @override
  State<MyWalletPage> createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  @override
  Widget build(BuildContext context) {
    return const CommonBackground(
        title: StringUtils.myWallet,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: InvoicesWidget(),
          ),
        ));
  }
}

class InvoicesWidget extends StatefulWidget {
  const InvoicesWidget({super.key});

  @override
  State<InvoicesWidget> createState() => _InvoicesWidgetState();
}

class _InvoicesWidgetState extends State<InvoicesWidget> {
  List<DriverData> driverData = [];

  @override
  void initState() {
    driverData.add(DriverData(SvgImages.imageInvoices, "Invoices", "20"));
    driverData.add(DriverData(SvgImages.imagePayments, "Payments", "£200"));
    driverData.add(DriverData(SvgImages.imageContract, "Contract", "6 Month"));
    driverData.add(DriverData(SvgImages.imageVatBalance, "VAT Balance", "10%"));
    super.initState();
    // bloc.getURLs(context);
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator InvoicesWidget - GROUP
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
          primary: false,
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 8,
          childAspectRatio: 0.85,
          children: List.generate(driverData.length, (index) {
            return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        driverData[index].image,
                        height: 46,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        driverData[index].title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontFamily: 'Inter',
                          fontSize: 12,
                          letterSpacing:
                              0 /*percentages not used in flutter. defaulting to zero*/,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          driverData[index].desc,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(74, 71, 71, 1),
                            fontFamily: 'Inter',
                            fontSize: 18,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}

class DriverData {
  String image;
  String title;
  String desc;

  DriverData(@required this.image, @required this.title, @required this.desc);
}
