import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:webkit/controller/dashboard_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_dotted_line.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_list_extension.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/images.dart';
import 'package:webkit/views/layouts/layout.dart';

class DashboardPage extends StatefulWidget {
  const   DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
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
                    // MyBreadcrumb(
                    //   children: [
                    //     MyBreadcrumbItem(name: 'ecommerce'.tr()),
                    //     MyBreadcrumbItem(name: 'dashboard'.tr(), active: true),
                    //   ],
                    // ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      sizes: "lg-3",
                      displays: "none", // This item will not be displayed
                      child: MyCard(
                        borderRadius: BorderRadius.circular(12),
                        padding: const EdgeInsets.all(16),
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
                        width: 200,
                        height: 100,
                        splashColor: Colors.grey.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          MyText.bodyLarge(
                            "Total Members",
                            fontSize: 16,
                            fontWeight: 10,
                            muted: true,
                          ),
                          MySpacing.height(8),
                          MyText.titleLarge(
                            "0",
                            fontSize: 24,
                            fontWeight: 10,
                            color: Colors.blueAccent,
                          ),
                          ],
                        )
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-3",
                      displays: "none", // This item will not be displayed
                      child: MyCard(
                        borderRadius: BorderRadius.circular(12),
                        padding: const EdgeInsets.all(16),
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
                        width: 200,
                        height: 100,
                        splashColor: Colors.grey.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          MyText.bodyLarge(
                            "Premium Members",
                            fontSize: 16,
                            fontWeight: 10,
                            muted: true,
                          ),
                          MySpacing.height(8),
                          MyText.titleLarge(
                            "0",
                            fontSize: 24,
                            fontWeight: 10,
                            color: Colors.blueAccent,
                          ),
                          ],
                        )
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-3",
                      displays: "none", // This item will not be displayed
                      child: MyCard(
                        borderRadius: BorderRadius.circular(12),
                        padding: const EdgeInsets.all(16),
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
                        width: 200,
                        height: 100,
                        splashColor: Colors.grey.withOpacity(0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          MyText.bodyLarge(
                            "Free Members",
                            fontSize: 16,
                            fontWeight: 10,
                            muted: true,
                          ),
                          MySpacing.height(8),
                          MyText.titleLarge(
                            "0",
                            fontSize: 24,
                            fontWeight: 10,
                            color: Colors.blueAccent,
                          ),
                          ],
                        )
                      ),
                    ),
                    
                  ],
                )
              ),
            ],
          );
        },
      ),
    );
  }


  Widget buildResponseTimeByLocationData(String currentTime, String price, IconData icon, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LucideIcons.circleDotDashed,
              size: 16,
            ),
            MySpacing.width(8),
            MyText.bodyMedium(
              currentTime,
            ),
          ],
        ),
        MySpacing.height(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText.bodyLarge(
              price,
              fontSize: 20,
              fontWeight: 600,
              muted: true,
            ),
            MySpacing.width(8),
            Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCard(
    Color color,
    IconData icons,
    String accountType,
    String price,
    IconData trendingIcon,
    Color trendingIconColor,
    String percentage,
    String month,
  ) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5),
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyLarge(
                  accountType,
                  fontSize: 15,
                  fontWeight: 600,
                ),
                MyText.bodyLarge(
                  price,
                  fontWeight: 600,
                  fontSize: 20,
                ),
                Row(
                  children: [
                    Icon(
                      trendingIcon,
                      color: trendingIconColor,
                      size: 16,
                    ),
                    MySpacing.width(8),
                    MyText.bodyMedium(
                      "$percentage%",
                    ),
                    MySpacing.width(8),
                    Expanded(
                      child: MyText.bodyMedium(
                        month,
                        overflow: TextOverflow.ellipsis,
                        muted: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          MyContainer(
            height: 70,
            width: 70,
            paddingAll: 0,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: color.withAlpha(30),
            child: Icon(
              icons,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
