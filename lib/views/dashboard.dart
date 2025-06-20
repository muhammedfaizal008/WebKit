import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:webkit/controller/dashboard_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:webkit/widgets/wave_painter.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
    controller.listenToTotalUserUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "dashboard".tr(),
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'dashboard'.tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              MyFlex(
                children: [
                  // Row for the four member cards
                    MyFlexItem(
                      sizes: "lg-2 md-4 sm-6 xs-12",
                      child: MemberStatCard(label: "Total Members", value: controller.totalUsers),
                    ),
                    MyFlexItem(
                      sizes: "lg-2 md-4 sm-6 xs-12",
                      child: MemberStatCard(label: "Free Members", value: controller.freeUsers),
                    ),
                    MyFlexItem(
                      sizes: "lg-2 md-4 sm-6 xs-12",
                      child: MemberStatCard(label: "Basic Members", value: controller.basicUsers),
                    ),
                    MyFlexItem(
                      sizes: "lg-2 md-4 sm-6 xs-12",
                      child: MemberStatCard(label: "Pro Members", value: controller.proUsers),
                    ),
                    MyFlexItem(
                      sizes: "lg-2 md-4 sm-6 xs-12",
                      child: MemberStatCard(label: "Premium Members", value: controller.premiumUsers),
                    ),
                    // MyFlexItem(
                    //   sizes: "lg-2 md-4 sm-6 xs-12",
                    //   child: MemberStatCard(label: "Blocked Members", value: controller.blockedUsers),
                    // ),
              
                  // Earnings cards remain as columns below
                  // MyFlexItem(
                  //   sizes: "lg-12 md-12 sm-12 xs-12",
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       // Earnings cards in a Column (2 rows)
                  //       Expanded(
                  //         flex: 1,
                  //         child: MyCard(
                  //           height: 432,
                  //           borderRadius: BorderRadius.circular(12),
                  //           color: Colors.white,
                  //           padding: const EdgeInsets.all(16),
                  //           bordered: true,
                  //           border: Border.all(color: Colors.grey.shade300),
                  //           clipBehavior: Clip.antiAlias,
                  //           shadow: MyShadow(
                  //             blurRadius: 8,
                  //             color: Colors.black12,
                  //             offset: const Offset(0, 4),
                  //           ),
                  //           child: Center(
                  //             child: MyText.bodyLarge("Graph Goes Here",
                  //                 fontSize: 18),
                  //           ),
                  //         ),
                  //       ),
                  //       MySpacing.width(16),
                  //       Expanded(
                  //         flex: 1,
                  //         child: Column(
                  //           children: [
                  //             Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: earningsCard(
                  //                       "Total Earnings", "\$0.00"),
                  //                 ),
                  //                 MySpacing.width(16),
                  //                 Expanded(
                  //                   child: earningsCard(
                  //                       "Last Month Earnings", "\$0.00"),
                  //                 ),
                  //               ],
                  //             ),
                  //             MySpacing.height(16),
                  //             Row(
                  //               children: [
                  //                 Expanded(
                  //                   child: earningsCard(
                  //                       "Last 6 Months Earnings", "\$0.00"),
                  //                 ),
                  //                 MySpacing.width(16),
                  //                 Expanded(
                  //                   child: earningsCard(
                  //                       "Last 12 Months Earnings",
                  //                       "\$0.00"),
                  //                 ),
                  //               ],
                  //             ),
                  //           ],
                  //         ),
                  //       ),
              
                  //       // Placeholder for Graph
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget earningsCard(String title, String amount) {
  return MyCard(
    borderRadius: BorderRadius.circular(12),
    padding: const EdgeInsets.all(0),
    color: Colors.white,
    border: Border.all(color: Colors.grey.shade300),
    bordered: true,
    clipBehavior: Clip.antiAlias,
    boxShape: BoxShape.rectangle,
    shadow: MyShadow(
      blurRadius: 8,
      color: Colors.black12,
      offset: const Offset(0, 4),
    ),
    height: 200,
    splashColor: Colors.grey.withOpacity(0.1),
    child: Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: WavePainter(
              color: Colors.green.shade200,
              amplitude: 20,
            ),
          ),
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: WavePainter(
              color: Colors.green.shade400.withOpacity(0.3),
              amplitude: 10,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText.bodyLarge(title, fontSize: 16, fontWeight: 20),
                MySpacing.height(8),
                MyText.titleLarge(amount,
                    fontSize: 16, fontWeight: 20, color: Colors.green),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
class MemberStatCard extends StatelessWidget {
  final String label;
  final RxInt value;
  final Color waveColor;
  const MemberStatCard({
    required this.label,
    required this.value,
    this.waveColor = Colors.blueAccent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      borderRadius: BorderRadius.circular(12),
      padding: const EdgeInsets.all(0),
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300),
      bordered: true,
      clipBehavior: Clip.antiAlias,
      boxShape: BoxShape.rectangle,
      shadow: MyShadow(
        blurRadius: 8,
        color: Colors.black12,
        offset: const Offset(0, 4),
      ),
      height: 200,
      splashColor: Colors.grey.withOpacity(0.1),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(
                color: waveColor.withOpacity(.6),
                amplitude: 20,
              ),
            ),
          ),
          Positioned.fill(
            child: CustomPaint(
              painter: WavePainter(
                color: waveColor.withOpacity(0.4),
                amplitude: 10,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyText.titleLarge(label, fontSize: 20, fontWeight: 600),
                  MySpacing.height(16),
                  Obx(() => MyText.titleLarge(
                        value.toString(),
                        fontSize: 24,
                        fontWeight: 800,
                        color: waveColor,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

