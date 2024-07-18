import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxrun/common/common_background.dart';
import 'package:taxrun/common/custom_separator.dart';
import 'package:taxrun/common/image_utils.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonBackground(title: "Invoice", body: InvoiceWidget());
  }
}

class InvoiceWidget extends StatefulWidget {
  const InvoiceWidget({super.key});

  @override
  State<InvoiceWidget> createState() => _InvoiceWidgetState();
}

class _InvoiceWidgetState extends State<InvoiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  color: Colors.green,
                  child: Container(
                    /*padding: const EdgeInsets.all(12),
                    color: Colors.white,*/
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          SvgImages.invoiceBg,
                          /*   alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,*/
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "TaxRun REF number",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "R-079629",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Per Day",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "3/9/2024",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            MySeparator(),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Week Number",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "WK8",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Routes Completed",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "4",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Route pay",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "781",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Additional",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "30",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Total Miles",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "106",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Van rental",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      "230",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Other Deductions",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MySeparator(),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Net Pay before fee"),
                                Text("842.33")
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            /* DottedBorder(
                              color: const Color(0xFFEBBF5A),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                color: const Color(0xFFFFFDFB),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Gross Pay After Deductions (Ex VAT)",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("842.33")
                                  ],
                                ),
                              ),
                            ),*/
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            );
          }),
    );
  }
}
