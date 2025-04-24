import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/free_members_controller.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/views/layouts/layout.dart';

class FreeMembers extends StatefulWidget {
  const FreeMembers({super.key});

  @override
  State<FreeMembers> createState() => _FreeMembersState();
}

class _FreeMembersState extends State<FreeMembers> with SingleTickerProviderStateMixin, UIMixin {
  late FreeMembersController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FreeMembersController());
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
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  MyText(
                    "Free Members",
                    fontSize: 20,
                    fontWeight: 20,
                  ),
                  Spacer(),
                  MyButton(
                    backgroundColor: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: MyText("Add Free Member", color: Colors.white),
                    onPressed: () {
                      Get.toNamed("/user/add_member");
                    }
                  ),

                ],
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.discover.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 350,
                                // childAspectRatio: 1,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 320),
                        itemBuilder: (context, index) {
                          return MyCard(
                            shadow: MyShadow(elevation: 0.5),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                MyContainer.none(
                                  paddingAll: 8,
                                  borderRadiusAll: 5,
                                  child: PopupMenuButton(
                                    offset: const Offset(0, 10),
                                    position: PopupMenuPosition.under,
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem(
                                          padding: MySpacing.xy(16, 8),
                                          height: 10,
                                          child: MyText.bodySmall("Action")),
                                      PopupMenuItem(
                                          padding: MySpacing.xy(16, 8),
                                          height: 10,
                                          child:
                                              MyText.bodySmall("Another action")),
                                      PopupMenuItem(
                                          padding: MySpacing.xy(16, 8),
                                          height: 10,
                                          child: MyText.bodySmall(
                                              "Somethings else here"))
                                    ],
                                    child: const Icon(
                                      LucideIcons.moreVertical,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyContainer.roundBordered(
                                      paddingAll: 4,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: MyContainer.rounded(
                                        height: 100,
                                        paddingAll: 0,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Image.asset(
                                          controller.discover[index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    MyText.bodyMedium(
                                      controller.discover[index].name,
                                      fontSize: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          LucideIcons.mail,
                                          size: 16,
                                        ),
                                        MySpacing.width(8),
                                        MyText.bodyMedium(
                                          controller.opportunities[index].email,
                                          fontSize: 16,
                                          fontWeight: 500,
                                          muted: true,
                                        ),
                                      ],
                                    ),
                                    MyText.bodyMedium(
                                      controller.discover[index].address,
                                      fontSize: 16,
                                      muted: true,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LucideIcons.linkedin,
                                            color: Color(0xff0A66C2),
                                            size: 20,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LucideIcons.facebook,
                                            color: Color(0xff3b5998),
                                            size: 20,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            LucideIcons.github,
                                            color: Color(0xff3b5998),
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
 

          ],
        );
      }),
    );
  }
}