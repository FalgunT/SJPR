import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sjpr/common/app_theme.dart';
import 'package:sjpr/model/invoice_list_model.dart';
import 'package:sjpr/screen/invoice/invoice_detail.dart';
import 'package:sjpr/screen/invoice/invoice_list_bloc.dart';
import 'package:sjpr/utils/color_utils.dart';
import 'package:sjpr/utils/string_utils.dart';
import 'package:sjpr/widgets/delete_confirmation_dialog.dart';
import 'package:sjpr/widgets/empty_item_widget.dart';
import 'custom_camera2.dart';

class InvoiceListScreen extends StatefulWidget {
  final int isPurchase;

  const InvoiceListScreen({super.key, required this.isPurchase});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen>
    with TickerProviderStateMixin {
  final InvoiceBloc bloc = InvoiceBloc();
  late TabController _tabController;
  final _inboxScrollController = ScrollController(),
      _archiveScrollController = ScrollController();
  int _currentPageInbox = 0, _currentPageArchive = 0;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _init();
    _inboxScrollController.addListener(_loadMoreInbox);
    _archiveScrollController.addListener(_loadMoreArchive);
    _tabController = TabController(length: 2, vsync: this);

    // Listen for tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        print('Selected Tab: ${_tabController.index}');
      }
    });
  }

  void _loadMoreInbox() {
    if (_inboxScrollController.position.pixels ==
            _inboxScrollController.position.maxScrollExtent &&
        !_isLoading) {
      _currentPageInbox++;
      bloc.getInvoiceList(context,
          isBackground: false,
          isPurchase: widget.isPurchase,
          page: _currentPageInbox);
    }
  }

  void _loadMoreArchive() {
    if (_archiveScrollController.position.pixels ==
            _archiveScrollController.position.maxScrollExtent &&
        !_isLoading) {
      _currentPageArchive++;
      bloc.getArchiveList(context,
          isPurchase: widget.isPurchase, page: _currentPageArchive);
    }
  }

  void _init() {
    _currentPageInbox = 0;
    _currentPageArchive = 0;
    bloc.getInvoiceList(context,
        isBackground: false,
        isPurchase: widget.isPurchase,
        page: _currentPageInbox);
    bloc.getArchiveList(context,
        isPurchase: widget.isPurchase, page: _currentPageArchive);
    bloc.getProfile(context);
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
        title: Text(
          widget.isPurchase == 1
              ? StringUtils.catchBill
              : StringUtils.catchInvoice,
          style: const TextStyle(color: Colors.white),
        ),
        /*actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: appTheme.textColor,
              )),
        ],*/
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
            ValueListenableBuilder(
                valueListenable: bloc.compName,
                builder: (BuildContext context, value, Widget? child) {
                  return Text(
                    value,
                    style:
                        TextStyle(color: appTheme.activeTxtColor, fontSize: 20),
                  );
                }),
            ValueListenableBuilder(
                valueListenable: bloc.compEmail,
                builder: (BuildContext context, value, Widget? child) {
                  return Text(
                    value,
                    style: TextStyle(color: appTheme.textColor),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            DefaultTabController(
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
                        controller: _tabController,
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
                    child: TabBarView(
                        controller: _tabController,
                        children: [inboxListView(), archiveListView()]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*  Future<List<PlatformFile>?> _pickFile(int mode) async {
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
    */ /*print(result.files.first.name);
    print("Size in Bytes : ${result.files.first.size}");
    print(result.files.first.path);
    if (kDebugMode) {
      var bytes = result.files.first.size;
      double sizeInMB = bytes / (10241 * 1024);
      print("sizeInMB : $sizeInMB");
    }*/ /*
    return result.files;
  }*/

  Widget archiveListView() {
    return ValueListenableBuilder(
        valueListenable: bloc.isWaitingArchive,
        builder: (context, value1, child) {
          return ValueListenableBuilder(
            valueListenable: bloc.archiveListData,
            builder: (context, value, child) {
              return (value1 == false && value.isEmpty)
                  ? getEmptyWidget(
                      StringUtils.emptyArchive, StringUtils.archiveText)
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      shrinkWrap: true,
                      itemCount: value.length,
                      controller: _archiveScrollController,
                      itemBuilder: (BuildContext context, int index) {
                        var listData = value[index];
                        return getChild(listData);
                      });
            },
          );
        });
  }

  Widget inboxListView() {
    return ValueListenableBuilder(
        valueListenable: bloc.isWaitingInbox,
        builder: (context, value1, child) {
          return ValueListenableBuilder(
            valueListenable: bloc.inboxListData,
            builder: (context, value, child) {
              return (value1 == false && value.isEmpty)
                  ? getEmptyWidget(
                      StringUtils.emptyInbox, StringUtils.tapToCreateNewExpense)
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      shrinkWrap: true,
                      itemCount: value.length,
                      controller: _inboxScrollController,
                      itemBuilder: (BuildContext context, int index) {
                        var listData = value[index];
                        return getChild(listData);
                      });
            },
          );
        });
  }

  getEmptyWidget(String title, String details) {
    return EmptyItemWidget(title: title, detail: details);
  }

  getChild(InvoiceListData listData) {
    return InkWell(
      onTap: () async {
        if (_tabController.index == 1) {
          _showListDialog(listData);
          return;
        }
        if (listData.readStatus == "1") {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InvoiceDetailScreen(
                        id: listData.id!,
                        isPurchase: widget.isPurchase,
                        title: widget.isPurchase == 1
                            ? StringUtils.catchBill
                            : StringUtils.catchInvoice,
                        isReadOnly: false,
                      ))).then((onValue) {
            if (onValue) {
              _init();
            }
          });
        }
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
                      listData.supplierName ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      listData.date ?? '',
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    (listData.totalAmount == null ||
                            listData.totalAmount!.isEmpty)
                        ? "N/A"
                        : '${listData.currency ?? ""} ${bloc.getFormetted(listData.totalAmount ?? "")}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    bloc.getInvoiceStatus(listData.readStatus!),
                    style: TextStyle(
                        color: listData.readStatus == "4"
                            ? Colors.red
                            : Colors.green),
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

  void _showListDialog(InvoiceListData listData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: listTileBgColor,
          title: const Text(
            'Choose an option',
            style: TextStyle(color: Colors.white),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                Navigator.pop(context, 'Option 1');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InvoiceDetailScreen(
                              id: listData.id!,
                              isPurchase: widget.isPurchase,
                              isReadOnly: true,
                              title: widget.isPurchase == 1
                                  ? StringUtils.catchBill
                                  : StringUtils.catchInvoice,
                            )));
              },
              child: getOptionChild(
                  Icons.remove_red_eye_outlined, 'View Invoice Detail'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Option 2');

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteConfirmationDialog(
                      label: 'Delete Invoice',
                      onPressed: () async {
                        Navigator.pop(context, 'Yes Confirm');
                        bool res =
                            await bloc.DeleteInvoice(listData.id!, context);
                        if (res) {
                          //refresh page...
                          _init();
                        }
                      },
                    );
                  },
                );
              },
              child: getOptionChild(Icons.delete_forever, 'Delete Invoice'),
            ),
            listData.readStatus == '4'
                ? SimpleDialogOption(
                    onPressed: () async {
                      Navigator.pop(context, 'Option 3');
                      bool res = await bloc.MovetoInbox(listData.id!);
                      if (res) {
                        //refresh page...
                        _init();
                      }
                    },
                    child: getOptionChild(
                        Icons.move_to_inbox_outlined, 'Move to Inbox'),
                  )
                : const Center(),
          ],
        );
      },
    );
  }

  getOptionChild(IconData icon, String text) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.white,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ));
  }

  void _showPicker(BuildContext context) {
    _imgFromCamera(context);
    /*showModalBottomSheet(
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
                  shape: const Border(),
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
        });*/
  }

  Future<void> _imgFromCamera(BuildContext context) async {
    //Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const PictureCapture();
      }),
    ).then((response) async {
      if (response.models.isNotEmpty) {
        debugPrint('Mode--->${response.mode}');
        //  var file = XFile(invoice.path!, name: invoice.name, bytes: invoice.bytes, length: invoice.size);
        if (response.mode == 1) {
          await bloc.uploadInvoice(
              context, response.models[0].capturePath, widget.isPurchase);
        } else {
          await bloc.uploadMultiInvoice(context, response.models,
              response.mode == 2 ? 'multiple' : "combine", widget.isPurchase);
        }
        _currentPageInbox = 0;
        bloc.getInvoiceList(context,
            isBackground: true,
            isPurchase: widget.isPurchase,
            page: _currentPageInbox);
      }
    });
  }

  /*Future<void> _imgFromCamera(BuildContext context) async {
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
  }*/
/*
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
        List<CaptureModel> models = [];
        for (int i = 0; i < invoices.length; i++) {
          var file = XFile(invoices[0].path!,
              name: invoices[0].name,
              bytes: invoices[0].bytes,
              length: invoices[0].size);
          models.add(CaptureModel(
              capture: file, widget: const Center(), isSelect: false));
        }
        await bloc.uploadMultiInvoice(
            context, models, mode == 2 ? 'multiple' : "combine");
      }

      */ /*final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Use the picked file in your app as needed
      File imageFile = File(pickedFile.path);
      // Process the image file
      print('Image selected: ${imageFile.path}');
    }*/ /*
    }
  }*/

  @override
  void dispose() {
    _inboxScrollController.dispose();
    _archiveScrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}
