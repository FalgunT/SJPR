// stores ExpansionPanel state information
class Item {
  Item({
    required this.index,
    this.expandedValue,
    required this.leadingIcon,
    this.headerValue,
    this.isExpanded = false,
  });

  int index;
  String leadingIcon;
  String? headerValue;
  List<String>? expandedValue;
  bool isExpanded;
}
