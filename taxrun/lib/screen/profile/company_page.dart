import 'package:flutter/material.dart';
import 'package:taxrun/common/common_background.dart';
import 'package:taxrun/common/string_utils.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonBackground(title: StringUtils.company, body: CompanyWidget());
  }
}

class CompanyWidget extends StatefulWidget {
  const CompanyWidget({super.key});

  @override
  State<CompanyWidget> createState() => _CompanyWidgetState();
}

class _CompanyWidgetState extends State<CompanyWidget> {
  bool isExpand = false;
  List<CompanyData> companyDataList = [
    CompanyData(
        title: "DTDC International Express",
        lastYrEarning: "\u20AC 1000.33",
        lastWeekEarning: "\u20AC 400.33",
        ytdEarning: "\u20AC 1000.33"),
    CompanyData(
        title: "FedEx International",
        lastYrEarning: "\u20AC 1000.33",
        lastWeekEarning: "\u20AC 400.33",
        ytdEarning: "\u20AC 1000.33"),
    CompanyData(
        title: "UPS Worldwide",
        lastYrEarning: "\u20AC 1000.33",
        lastWeekEarning: "\u20AC 400.33",
        ytdEarning: "\u20AC 1000.33"),
    CompanyData(
        title: "DTDC International",
        lastYrEarning: "\u20AC 1000.33",
        lastWeekEarning: "\u20AC 400.33",
        ytdEarning: "\u20AC 1000.33"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: ListView.builder(
        itemCount: companyDataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 15), child: Container()
              /*Card(
              surfaceTintColor: const Color(0xFFA2EBE3),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  onExpansionChanged: (value) {
                    setState(() {
                      isExpand = value;
                    });
                  },
                  trailing: Icon(
                    isExpand ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    color: Colors.black,
                    size: 35,
                  ),
                  backgroundColor: const Color(0xFFA2EBE3),
                  collapsedBackgroundColor: const Color(0xFFA2EBE3),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFEBBF5A)),
                        child: Center(
                            child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          companyDataList[index].title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  children: [
                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                        child: Text(
                      StringUtils.totalEarning,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text(StringUtils.lastYr),
                            Text(
                              companyDataList[index].lastYrEarning,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(StringUtils.ytd),
                            Text(
                              companyDataList[index].ytdEarning,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Text(StringUtils.lastWeek),
                            Text(
                              companyDataList[index].lastWeekEarning,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),*/
              );
        },
      ),
    );
  }
}

class CompanyData {
  String title;
  String lastYrEarning;
  String ytdEarning;
  String lastWeekEarning;

  CompanyData(
      {required this.title,
      required this.lastYrEarning,
      required this.lastWeekEarning,
      required this.ytdEarning});
}
