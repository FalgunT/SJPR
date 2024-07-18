import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/screen/invoice/invoice_detail.dart';
import 'package:sjpr/screen/invoice/invoice_list_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/image_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'custom_camera.dart';

class ServicesModel {
  String? name;
  String? date;
  String? price;
  String? status;

  ServicesModel({
    this.date,
    this.price,
    this.status,
    this.name,
  });
}

List<ServicesModel> archiveList = [
  ServicesModel(
    name: "Amazon",
    date: "22th feb,2024",
    price: "\u{20AC} 628.10",
    status: "Published 17/12",
  ),
  ServicesModel(
    name: "London Expert",
    date: "16th feb,2024",
    price: "\u{20AC} 38.10",
    status: "Published 13/12",
  ),
  ServicesModel(
    name: "Ebay",
    date: "19th feb,2024",
    price: "\u{20AC} 517.16",
    status: "Published 05/12",
  ),
  ServicesModel(
    name: "Google Services",
    date: "25th feb,2024",
    price: "\u{20AC} 518.16",
    status: "Published 24/11",
  ),
  ServicesModel(
    name: "Space Dinner",
    date: "20th f/eb,2024",
    price: "\u{20AC} 518.16",
    status: "Published 21/11",
  )
];

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen>
    with TickerProviderStateMixin {
  final InvoiceBloc bloc = InvoiceBloc();

  @override
  void initState() {
    bloc.getInvoiceList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme.of(context);
    return Scaffold(
      backgroundColor: appTheme.backGroundColor,
      appBar: AppBar(
        backgroundColor: appTheme.backGroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: appTheme.textColor,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: appTheme.textColor,
              )),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () async {
          _showPicker(context);
          /* var invoice = await _pickFile();
          if (invoice != null) {
            var file = XFile(invoice.path!,
                name: invoice.name, bytes: invoice.bytes, length: invoice.size);
            if (invoice != null) {
              await bloc.uploadInvoice(context, file);
              bloc.getInvoiceList(context);
            }
          }*/
          /* Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return const CustomCamera();
            }),
          );*/
        },
        child: Container(
            color: const Color.fromRGBO(30, 34, 38, 33),
            height: 90,
            width: double.infinity,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: appTheme.buttonBgColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    color: appTheme.buttonTextColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Take a pic",
                    style: TextStyle(
                        color: appTheme.buttonTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            )),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Decaprio Digital Marketing",
              style: TextStyle(color: appTheme.activeTxtColor, fontSize: 20),
            ),
            Text(
              'luiz@decaprio.com.uk',
              style: TextStyle(color: appTheme.textColor),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<InvoiceList?>(
                stream: bloc.invoiceListStream,
                builder: (context, snapshot) {
                  return DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(39, 40, 44, 1),
                          ),
                          child: TabBar(
                              unselectedLabelColor: appTheme.textColor,
                              dividerColor: appTheme.backGroundColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding: const EdgeInsets.all(5),
                              labelColor: const Color.fromRGBO(182, 147, 52, 1),
                              indicatorColor: appTheme.backGroundColor,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: appTheme.backGroundColor),
                              tabs: const [Text("Inbox"), Text("Archive")]),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.6,
                          child: TabBarView(children: [
                            inboxListView(snapshot),
                            archiveListView(snapshot)
                          ]),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Future<List<PlatformFile>?> _pickFile(int mode) async {
    // opens storage to pick files and the picked file or files
    // are assigned into result and if no file is chosen result is null.
    // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: mode == 1 ? false : true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      allowCompression: true,
    );
    // if no file is picked
    if (result == null) return null;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    /*print(result.files.first.name);
    print("Size in Bytes : ${result.files.first.size}");
    print(result.files.first.path);
    if (kDebugMode) {
      var bytes = result.files.first.size;
      double sizeInMB = bytes / (10241 * 1024);
      print("sizeInMB : $sizeInMB");
    }*/
    return result.files;
  }

  Widget archiveListView(AsyncSnapshot<InvoiceList?> snapshot) {
    if (!snapshot.hasData) {
      return Container();
    }
    if (snapshot.data != null &&
        snapshot.data!.archiveData != null &&
        snapshot.data!.archiveData!.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          shrinkWrap: true,
          itemCount: snapshot.data!.archiveData!.length,
          itemBuilder: (BuildContext context, int index) {
            var listData = snapshot.data!.archiveData!;
            if (listData.isNotEmpty) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceDetailScreen(
                                id: listData[index].id!,
                              )));
                },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listData[index].supplierName ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                listData[index].date ?? '',
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (listData[index].totalAmount == null ||
                                      listData[index].totalAmount!.isEmpty)
                                  ? "N/A"
                                  : '${listData[index].currency ?? ""} ${listData[index].totalAmount ?? ""}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              listData[index].readStatus ?? "",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    )),
              );
            }
          });
    }
    return Column(
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
          StringUtils.emptyArchive,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          StringUtils.archiveText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }

  Widget inboxListView(AsyncSnapshot<InvoiceList?> snapshot) {
    if (!snapshot.hasData) {
      return Container();
    }
    if (snapshot.data != null &&
        snapshot.data!.data != null &&
        snapshot.data!.data!.isNotEmpty) {
      return ListView.builder(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          shrinkWrap: true,
          itemCount: snapshot.data!.data!.length,
          itemBuilder: (BuildContext context, int index) {
            var listData = snapshot.data!.data!;
            if (listData.isNotEmpty) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InvoiceDetailScreen(
                                id: listData[index].id!,
                              )));
                },
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                listData[index].supplierName ?? "",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Text(
                                listData[index].date ?? '',
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (listData[index].totalAmount == null ||
                                      listData[index].totalAmount!.isEmpty)
                                  ? "N/A"
                                  : '${listData[index].currency ?? ""} ${listData[index].totalAmount ?? ""}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              listData[index].readStatus == "1"
                                  ? "To review"
                                  : "Canceled",
                              style: TextStyle(
                                  color: listData[index].readStatus == "1"
                                      ? Colors.green
                                      : listData[index].readStatus == "Canceled"
                                          ? Colors.red
                                          : Colors.amber),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )
                      ],
                    )),
              );
            }
          });
    }
    return Column(
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
          StringUtils.emptyInbox,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          StringUtils.tapToCreateNewExpense,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        )
      ],
    );
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: listTileBgColor,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Wrap(
              children: <Widget>[
                const SizedBox(
                  height: 24,
                ),
                ListTile(
                  // leading: Icon(Icons.photo_library, color: textColor),
                  title: Text(
                    "Upload Invoice From",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera, color: textColor),
                  title: Text('Camera',
                      style: TextStyle(color: textColor, fontSize: 18)),
                  onTap: () {
                    _imgFromCamera(context);
                    //Navigator.of(context).pop();
                  },
                ),
                ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  shape: Border(),
                  initiallyExpanded: true,
                  leading: Icon(Icons.photo_library, color: textColor),
                  title: Text(
                    "Gallery",
                    style: TextStyle(color: textColor, fontSize: 18),
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          SvgImages.single,
                          width: 16,
                          height: 16,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Single',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                        onTap: () {
                          _imgFromGallery(context, 1);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          SvgImages.multiple,
                          width: 16,
                          height: 16,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Multiple',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                        onTap: () {
                          _imgFromGallery(context, 2);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          SvgImages.combine,
                          color: Colors.white,
                          width: 16,
                          height: 16,
                        ),
                        title: Text(
                          'Combined',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                        onTap: () {
                          _imgFromGallery(context, 3);
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> _imgFromCamera(BuildContext context) async {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const CustomCamera();
      }),
    ).then((response) async {
      if (response.models.isNotEmpty) {
        //  var file = XFile(invoice.path!, name: invoice.name, bytes: invoice.bytes, length: invoice.size);
        if (response.mode == 1) {
          await bloc.uploadInvoice(context, response.models[0].capture);
        } else {
          await bloc.uploadMultiInvoice(context, response.models,
              response.mode == 2 ? 'multiple' : "combine");
        }
        bloc.getInvoiceList(context);
      }
    });
  }

  Future<void> _imgFromGallery(BuildContext context, int mode) async {
    List<PlatformFile>? invoices = await _pickFile(mode);
    if (invoices != null) {
      if (mode == 1) {
        //single...
        var file = XFile(invoices[0].path!,
            name: invoices[0].name,
            bytes: invoices[0].bytes,
            length: invoices[0].size);
        await bloc.uploadInvoice(context, file);
        bloc.getInvoiceList(context);
      } else {
        //multiple or combined...
        List<CaptureModel> models =[];
        for(int i=0;i<invoices.length;i++){
          var file = XFile(invoices[0].path!,
              name: invoices[0].name,
              bytes: invoices[0].bytes,
              length: invoices[0].size);
          models.add(CaptureModel(capture: file, widget: Center(), isSelect: false));
        }
        await bloc.uploadMultiInvoice(context, models, mode == 2 ? 'multiple' : "combine");
      }

      /*final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Use the picked file in your app as needed
      File imageFile = File(pickedFile.path);
      // Process the image file
      print('Image selected: ${imageFile.path}');
    }*/
    }
  }
}
