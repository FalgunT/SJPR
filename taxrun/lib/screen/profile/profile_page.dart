import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taxrun/common/common_background.dart';
import 'package:taxrun/common/image_utils.dart';
import 'package:taxrun/common/string_utils.dart';

class ProfilePage extends StatefulWidget {
  //final LoginBloc loginBloc;

  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
  ProfileData? profileData;

  @override
  void initState() {
    profileData = ProfileData(
      "7589478147",
      "United Kingdom",
      "Adil Benothman",
      "-",
      "49 Aspen Gardens, London, W6 9JE, United Kingdom",
      "-",
      "-",
      "-",
      "-",
    );

    super.initState();
    // bloc.getURLs(context);
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator InvoicesWidget - GROUP
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 200,
              child: Text(
                'Welcome To Driver App',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 24,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SvgPicture.asset(
              SvgImages.imageWalletForProfile,
              height: 60,
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          // padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.utr,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.utr ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.national,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.nationalInsurance ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.nameSurname,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.name ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.vatNum,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.vatNumber ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.address,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.address ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.companyNumber,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.companyNumber ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'Company Detail',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontFamily: 'Inter',
                  fontSize: 16,
                  letterSpacing:
                      0 /*percentages not used in flutter. defaulting to zero*/,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.companyUTR,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.companyUTR ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.companyName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.companyName ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6),
                ),
                color: Color.fromRGBO(255, 255, 255, 0.699999988079071),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      StringUtils.companyVAT,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      profileData?.companyVat ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Color.fromRGBO(74, 71, 71, 1),
                        fontFamily: 'Inter',
                        fontSize: 15,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ProfileData {
  String utr;
  String nationalInsurance;
  String name;
  String vatNumber;
  String address;
  String companyNumber;
  String companyUTR;
  String companyName;
  String companyVat;

  ProfileData(
      @required this.utr,
      @required this.nationalInsurance,
      @required this.name,
      @required this.vatNumber,
      @required this.address,
      @required this.companyNumber,
      @required this.companyUTR,
      @required this.companyName,
      @required this.companyVat);
}
