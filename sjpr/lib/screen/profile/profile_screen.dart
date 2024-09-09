import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sjpr/model/profile_model.dart';
import 'package:sjpr/screen/dashboard/dashboard_bloc.dart';
import 'package:sjpr/screen/profile/general_setting.dart';
import 'package:sjpr/screen/profile/profile_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';

import '../../common/app_theme.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_text_filed.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DashboardBloc bloc = DashboardBloc.getInstance();
  ProfileBloc pBloc = ProfileBloc();
  File file = File('');

  @override
  void initState() {
    super.initState();
    bloc.getProfile(context, mounted);
  }

  pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (kDebugMode) {
      print("pickedVideo!.path-$pickedImage");
    }
    if (pickedImage != null) {
      setState(() {
        file = File(pickedImage.path);
      });
    }
  }

  Future<void> bottomSheetDialog() {
    return showModalBottomSheet(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * 0.3),
        context: context,
        backgroundColor: backGroundColor,
        builder: (context) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Capture Or Select Image From",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.25,
                  child: ListView(
                    children: ListTile.divideTiles(
                        //          <-- ListTile.divideTiles
                        context: context,
                        tiles: [
                          ListTile(
                            onTap: () {
                              pickImage(ImageSource.camera);
                            },
                            title: Text(
                              "Camera",
                              style: TextStyle(color: textColor),
                            ),
                            leading: Icon(
                              Icons.camera_alt,
                              size: 25,
                              color: activeTxtColor,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              pickImage(ImageSource.gallery);
                            },
                            title: Text(
                              "Gallery",
                              style: TextStyle(color: textColor),
                            ),
                            leading: Icon(
                              Icons.image,
                              size: 25,
                              color: activeTxtColor,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            title: Text(
                              "Cancel",
                              style: TextStyle(color: textColor),
                            ),
                            leading: Icon(
                              Icons.clear,
                              size: 25,
                              color: activeTxtColor,
                            ),
                          ),
                        ]).toList(),
                  ),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    ProfileData? profile;
    return Scaffold(
        backgroundColor: profileBgColor,
        appBar: null,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(20),
              child:
                  /* StreamBuilder<ProfileData?>(
                stream: bloc.profileStream,
                builder: (BuildContext context,
                    AsyncSnapshot<ProfileData?> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data != null) {
                    var profile = snapshot.data;
                    if (profile != null &&
                        profile.profileImage != null) {
                      return Image.network(
                        profile.profileImage!,
                        height: 100,
                        width: 100,
                      );
                    }
                  }
                  return Image.asset(
                    AssetImages.personPlaceholder,
                    height: 100,
                    width: 100,
                  );
                })*/
                  StreamBuilder<ProfileData?>(
                      stream: bloc.profileStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<ProfileData?> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          profile = snapshot.data;
                        }
                        return Column(
                          children: [
                            const SizedBox(
                              height: 120,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Stack(
                                  children: [
                                    Center(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(150),
                                            child: file.path == ''
                                                ? ((profile != null &&
                                                        profile!.profileImage !=
                                                            null)
                                                    ? Image.network(
                                                        profile!.profileImage!,
                                                        height: 100,
                                                        width: 100,
                                                      )
                                                    : Image.asset(
                                                        AssetImages
                                                            .personPlaceholder,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                        width: 100,
                                                      ))
                                                : Image.file(
                                                    file,
                                                    height: 100,
                                                    fit: BoxFit.fill,
                                                    width: 100,
                                                  ))),
                                    Positioned(
                                        bottom: 5,
                                        left: 20,
                                        right: 20,
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: buttonTextColor,
                                              shape: BoxShape.circle),
                                          child: Center(
                                              child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              bottomSheetDialog();
                                            },
                                            icon: SvgPicture.asset(
                                              SvgImages.edit,
                                            ),
                                          )),
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.21,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: buttonTextColor,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Center(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                    color: listTileBgColor,
                                    borderRadius: BorderRadius.circular(32)),
                                child: Text(
                                  "${profile?.firstname ?? ""} ${profile?.lastname ?? ""}",
                                  style: TextStyle(
                                      color: activeTxtColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: profileListBgColor,
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const GeneralSettingScreen()));
                                },
                                leading: SvgPicture.asset(
                                  SvgImages.generalSettings,
                                ),
                                title: const Text("General Settings"),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: profileListBgColor,
                              ),
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  SvgImages.person,
                                ),
                                title: const Text("Accounts"),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: profileListBgColor,
                              ),
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  SvgImages.outstandingPaperwork,
                                ),
                                title: const Text("Outstanding Paperwork"),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: profileListBgColor),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                                /* width: MediaQuery.sizeOf(context)
                                                        .width *
                                                    0.2,*/
                                                child: Text("Open on Camera")),
                                            Transform.scale(
                                              scale: 0.8,
                                              child: CupertinoSwitch(
                                                activeTrackColor:
                                                    listTileBgColor,
                                                thumbColor: activeTxtColor,
                                                value: true,
                                                onChanged: (bool value) {},
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: profileListBgColor),
                                        padding: const EdgeInsets.all(15),
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              /* width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.2,*/
                                              child: Text(
                                                "Save to Gallery",
                                              ),
                                            ),
                                            Transform.scale(
                                              scale: 0.8,
                                              child: CupertinoSwitch(
                                                activeTrackColor:
                                                    listTileBgColor,
                                                thumbColor: activeTxtColor,
                                                value: true,
                                                onChanged: (bool value) {
                                                  // setState(() {
                                                  //   switchValue = value;
                                                  // });
                                                },
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            /*const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: profileListBgColor),
                                child: const Column(
                                  children: [Icon(Icons.chat), Text("Chat")],
                                ))),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: profileListBgColor),
                                child: const Column(
                                  children: [Icon(Icons.help), Text("Help")],
                                ))),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: profileListBgColor),
                                child: const Column(
                                  children: [Icon(Icons.info), Text("About")],
                                ))),
                      ],
                    ),*/
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                showNewPasswordSheet();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: profileListBgColor,
                                ),
                                child: ListTile(
                                  leading: SvgPicture.asset(
                                    SvgImages.import,
                                  ),
                                  title: const Text("Reset Password"),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                bloc.logout(context, mounted);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: listTileBgColor),
                                child: ListTile(
                                  leading: SvgPicture.asset(
                                    SvgImages.logout,
                                  ),
                                  title: Text(
                                    "Log Out",
                                    style: TextStyle(
                                      color: activeTxtColor,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: activeTxtColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Image.asset(
                                AssetImages.profileLogo,
                                color: Colors.black,
                              ),
                            )
                          ],
                        );
                      })),
        ));
  }

  GlobalKey<FormState> formforgetDetailKey = GlobalKey<FormState>();

  showNewPasswordSheet() {
    final appTheme = AppTheme.of(context);

    showModalBottomSheet(
        backgroundColor: appTheme.listTileBgColor,
        isScrollControlled: true,
        isDismissible: false,
        // Prevents tapping outside to dismiss
        enableDrag: false,
        context: context,
        builder: (BuildContext context) {
          final bottom = EdgeInsets.fromViewPadding(
                  WidgetsBinding.instance.window.viewInsets,
                  WidgetsBinding.instance.window.devicePixelRatio)
              .bottom;
          return Wrap(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, bottom),
                /*   padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), */
                // Add bottom padding to avoid keyboard overlap
                child: Form(
                  key: formforgetDetailKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Reset Password",
                              style: TextStyle(
                                  color: appTheme.textColor, fontSize: 18),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                                color: appTheme.textColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: pBloc.oldpasswordController,
                        hintText: "Old password",
                        isPassword: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: pBloc.passwordController,
                        hintText: "New password",
                        isPassword: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        controller: pBloc.confirmpasswordController,
                        hintText: "Confirm password",
                        isPassword: true,
                        validation: (String? val) {
                          if (val == null || val.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonButton(
                          content: "Submit",
                          bgColor: appTheme.buttonBgColor,
                          textColor: appTheme.buttonTextColor,
                          outlinedBorderColor: appTheme.buttonBgColor,
                          onPressed: () async {
                            if (formforgetDetailKey.currentState!.validate()) {
                              var res =
                                  await pBloc.ResetPassword(context, true);
                              if (res) {
                                Navigator.pop(context);
                              }
                            }
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
