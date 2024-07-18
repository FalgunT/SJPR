
import 'package:flutter/material.dart';

class Utils{
  static listViewLoadMore({Function()? onLoadMore, Widget? child}) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            onLoadMore!();
          }
          return true;
        },
        child: child!);
  }
}