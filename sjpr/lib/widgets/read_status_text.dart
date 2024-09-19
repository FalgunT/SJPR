import 'package:flutter/material.dart';

class ReadStatusText extends StatelessWidget {
  const ReadStatusText({
    super.key,
    required this.readStatus,
  });

  final String? readStatus;

  @override
  Widget build(BuildContext context) {
    return Text(
      getInvoiceStatus(readStatus!),
      style: TextStyle(color: readStatus == "4" ? Colors.red : Colors.green),
    );
  }

  String getInvoiceStatus(String id) {
    switch (id) {
      case '0':
        return 'updating';
      case '1':
        return 'To review';
      case '2':
        return 'Pending';
      case '3':
        return 'Processing';
      case '4':
        return 'Canceled';
      case '5':
        return 'Published';
    }
    return 'Unknown';
  }
}
