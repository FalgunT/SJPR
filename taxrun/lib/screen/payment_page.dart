import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxrun/common/common_background.dart';
import 'package:taxrun/common/string_utils.dart';

class PaymentPage extends StatefulWidget {
  //final LoginBloc loginBloc;

  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return const CommonBackground(
        title: StringUtils.payment,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: PaymentWidget(),
          ),
        ));
  }
}

class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  List<PaymentData> paymentData = [];

  @override
  void initState() {
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));
    paymentData.add(PaymentData('#TR0042 ', "842.33", "742.00", "100.33"));

    super.initState();
    // bloc.getURLs(context);
  }

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator PaymentWidget - GROUP
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.separated(
        itemCount: paymentData.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemBuilder: (context, index) {
          return Container(
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
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Invoices',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          paymentData[index].invoices,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Amount',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          paymentData[index].amount,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Payment',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          paymentData[index].payment,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          'VAT Balance',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          paymentData[index].vat,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontFamily: 'Inter',
                            fontSize: 15,
                            letterSpacing:
                                0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PaymentData {
  String invoices;
  String amount;
  String payment;
  String vat;

  PaymentData(@required this.invoices, @required this.amount,
      @required this.payment, @required this.vat);
}
