import 'dart:convert';

import 'package:flutter/cupertino.dart';

class CategoryList {
  bool? status;
  String? error;
  String? message;
  Data? data;

  CategoryList({this.status, this.message, this.data});

  CategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      //debugPrint('--->${json['data'].runtimeType as String?}');
      print(json['data'].runtimeType);
      data = Data.fromJson(json['data']);
      //data =Data.fromJson((json['data'] as List).map((itemWord) => Data.fromJson(itemWord)));
      //data= (json['data'] as List).map((itemWord) => Data.fromJson(itemWord));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

// Class for Data
class Data {
  final List<CategoryListData> categories;

  Data({
    required this.categories,
  });

  factory Data.fromJson(List<dynamic> categoriesFromJson) {
    List<CategoryListData> categoryList = categoriesFromJson
        .map((item) => CategoryListData.fromJson(item))
        .toList();
    return Data(
      categories: categoryList,
    );
  }
}

class CategoryListData {
  String? id;
  String? name;
  List<SubCategoryData>? list;

  CategoryListData({
    this.id,
    this.name,
    this.list,
  });

  CategoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    var listFromJson = json['list'] as List;
    list = listFromJson.map((item) => SubCategoryData.fromJson(item)).toList();

    //var tagObjsJson = jsonDecode(json['list']) as List;
    //list  = json['list'].map((tagJson) => SubCategoryData.fromJson(tagJson)).toList() as List<SubCategoryData>?;

    /* list = json['list'].entries
        .map((entry) => SubCategoryData.fromJson(entry))
        .toList();*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['list'] = jsonEncode(list?.map((e) => e.toJson()).toList());
    return data;
  }
}

class SubCategoryData {
  /* "sub_category_id": "210",
     "sub_category_name": "Goodwill - Cost b/fwd",
     "sub_category_status": "1",
     "code": "4020"*/

   String? sub_category_id ;
   String? sub_category_name;
   String? sub_category_status;
   String? code;

  SubCategoryData(
      {required this.sub_category_id,
      required this.sub_category_name,
      required this.sub_category_status,
      required this.code});

  SubCategoryData.empty();

  SubCategoryData.fromJson(Map<String, dynamic> json) {
    sub_category_id = json['sub_category_id'];
    sub_category_name = json['sub_category_name'];
    sub_category_status = json['sub_category_status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_category_id'] = sub_category_id;
    data['sub_category_name'] = sub_category_name;
    data['sub_category_status'] = sub_category_status;
    data['code'] = code;
    return data;
  }

  @override
  String toString() {
    return 'SubCategoryData{sub_category_id: $sub_category_id, sub_category_name: $sub_category_name, sub_category_status: $sub_category_status, code: $code}';
  }
}
