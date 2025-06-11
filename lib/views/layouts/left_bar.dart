import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/services/url_service.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/theme/theme_customizer.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/images.dart';
import 'package:webkit/widgets/custom_pop_menu.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {  
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;

  const LeftBar({super.key, this.isCondensed = false});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;

  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return MyCard(
      paddingAll: 0,
      shadow: MyShadow(position: MyShadowPosition.centerRight, elevation: 0.2),
      child: AnimatedContainer(
        color: leftBarTheme.background,
        width: isCondensed ? 75 : 280,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!widget.isCondensed) MySpacing.width(16),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/dashboard');
                    },
                    child: Image.asset(
                      Images.logoIcon,
                      height: widget.isCondensed ? 24 : 32,
                      color: contentTheme.primary,
                    ),
                  ),
                  if (!widget.isCondensed) MySpacing.width(16),
                  if (!widget.isCondensed)
                    Expanded(
                      // <-- Use Expanded instead of Flexible
                      child: MyText.labelLarge(
                        "Matrimony App",
                        style: GoogleFonts.raleway(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.primary,
                          letterSpacing: 1,
                        ),
                        maxLines: 1,
                        overflow:
                            TextOverflow.ellipsis, // <-- Prevents overflow
                        softWrap: false,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              physics: const PageScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NavigationItem(
                    iconData: LucideIcons.layoutDashboard,
                    title: "dashboard".tr(),
                    isCondensed: isCondensed,
                    route: '/dashboard',
                  ),

                  //-----------------Members-----------------//
                  MenuWidget(
                    iconData: LucideIcons.contact,
                    isCondensed: isCondensed,
                    title: "Customers",
                    children: [
                      MenuItem(
                        title: "All Customers",
                        route: '/user/free_members',
                        isCondensed: true,
                      ),
                      // MenuItem(
                      //   title: "Premium Users".tr(),
                      //   route: '/user/premium_members',
                      //   isCondensed: widget.isCondensed,
                      // ),
                      MenuItem(
                        title: "Blocked Users".tr(),
                        route: '/user/blocked_members',
                        isCondensed: true,
                      ),
                      
                    ],
                  ),
                  MenuWidget(
                    iconData: LucideIcons.contact,
                    isCondensed: isCondensed,
                    title: "Staff",
                    children: [
                      MenuItem(
                        title: "All Staff",
                        route: '/staff/all_staff',
                        isCondensed: widget.isCondensed,
                      ),
                      MenuItem(
                        title: "Staff Roles ".tr(),
                        route: '/staff/staff_roles',
                        isCondensed: widget.isCondensed,
                      ),

                    ],
                  ),
                  MenuWidget(
                    iconData: Icons.admin_panel_settings_outlined,
                        title: "Masters",
                        isCondensed: widget.isCondensed,
                        children: [
                              MenuItem(title: "Gender", route: '/user/profileAttribute/gender', isCondensed: widget.isCondensed),
                              MenuItem(title: "Mother Tongue", route: '/user/profileAttribute/mother_tongue', isCondensed: widget.isCondensed),
                              MenuItem(title: "Marital Status", route: '/user/profileAttribute/marital_status', isCondensed: widget.isCondensed),
                              MenuItem(title: "Education", route: '/user/profileAttribute/education', isCondensed: widget.isCondensed),
                              MenuItem(title: "Occupation", route: '/user/profileAttribute/occupation', isCondensed: widget.isCondensed),
                              MenuItem(title: "Annual Income", route: '/user/profileAttribute/annual_income', isCondensed: widget.isCondensed), 
                              MenuItem(title: "Physical Status", route: '/user/profileAttribute/physical_status', isCondensed: widget.isCondensed),
                            
                              MenuItem(title: "Religion",route: '/user/profileAttribute/religion',isCondensed: widget.isCondensed,),
                              MenuItem(title: "Caste",route: '/user/profileAttribute/caste',isCondensed: widget.isCondensed,),
                              MenuItem(title: "Zodiac Sign", route: '/user/profileAttribute/zodiac_sign', isCondensed: widget.isCondensed),
                              MenuItem(title: "Star", route: '/user/profileAttribute/stars', isCondensed: widget.isCondensed),
                              MenuItem(title: "Horoscope", route: '/user/profileAttribute/horoscope', isCondensed: widget.isCondensed),
                           
                              MenuItem(title: "Country", route: '/user/profileAttribute/country', isCondensed: widget.isCondensed),
                              MenuItem(title: "State", route: '/user/profileAttribute/state', isCondensed: widget.isCondensed),
                              MenuItem(title: "Resident Status", route: '/user/profileAttribute/residentStatus', isCondensed: widget.isCondensed),
                              MenuItem(title: "Citizen Ship", route: '/user/profileAttribute/citizenShip', isCondensed: widget.isCondensed),
                            
                              MenuItem(title: "Eating habits", route: '/user/profileAttribute/eating_habits', isCondensed: widget.isCondensed),
                              MenuItem(title: "Drinking habits", route: '/user/profileAttribute/drinking_habits', isCondensed: widget.isCondensed),
                              MenuItem(title: "Smoking habits", route: '/user/profileAttribute/smoking_habits', isCondensed: widget.isCondensed),

                              MenuItem(title: "Family Values", route: '/user/profileAttribute/family_values', isCondensed: widget.isCondensed),
                              MenuItem(title: "Family type", route: '/user/profileAttribute/family_type', isCondensed: widget.isCondensed),
                              MenuItem(title: "Family Status", route: '/user/profileAttribute/family_status', isCondensed: widget.isCondensed),
                            
                        ],
                      ),

                  //-----------------Settings-----------------//
                  MenuItem(
                    iconData: LucideIcons.settings,
                    title: "Settings".tr(),
                    isCondensed: isCondensed,
                    route: '/settings',
                  ),
                  

                  
                  MySpacing.height(32),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? MySpacing.empty()
        : Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(
              label.toUpperCase(),
              color: leftBarTheme.labelColor,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.clip,
              fontWeight: 700,
            ),
          );
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;

  const MenuWidget({super.key, required this.iconData, required this.title, this.isCondensed = false, this.active = false, this.children = const []});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      // onChangeExpansion(false);
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    // popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    // var route = Uri.base.fragment;
    // isActive = widget.children.any((element) => element.route == route);

    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (_) => hideFn = _,
        onChange: (_) {
          // popupShowing = _;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover ? leftBarTheme.activeItemBackground : Colors.transparent,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive) ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer.bordered(
          paddingAll: 8,
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: const EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
                tilePadding: MySpacing.zero,
                initiallyExpanded: isActive,
                maintainState: true,
                onExpansionChanged: (_) {
                  LeftbarObserver.notifyAll(widget.title);
                  onChangeExpansion(_);
                },
                trailing: RotationTransition(
                  turns: _iconTurns,
                  child: Icon(
                    LucideIcons.chevronDown,
                    size: 18,
                    color: leftBarTheme.onBackground,
                  ),
                ),
                iconColor: leftBarTheme.activeItemColor,
                childrenPadding: MySpacing.x(12),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.iconData,
                      size: 20,
                      color: isHover || isActive ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                    ),
                    MySpacing.width(18),
                    Expanded(
                      child: MyText.labelLarge(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        color: isHover || isActive ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                      ),
                    ),
                  ],
                ),
                collapsedBackgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                backgroundColor: Colors.transparent,
                children: widget.children),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    // LeftbarObserver.detachListener(widget.title);
  }
}   

  class MenuItem extends StatefulWidget {
    final IconData? iconData;
    final String title;
    final bool isCondensed;
    final String? route;

    const 
    
    MenuItem({
      super.key,
      this.iconData,
      required this.title,
      this.isCondensed = false,
      this.route,
    });

    @override
    _MenuItemState createState() => _MenuItemState();
  }

  class _MenuItemState extends State<MenuItem> with UIMixin {
    bool isHover = false;

    @override
    Widget build(BuildContext context) {
      bool isActive = UrlService.getCurrentUrl() == widget.route;
      return GestureDetector(
        onTap: () {
          if (widget.route != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Notify all observers that a menu item was clicked
              Get.toNamed(widget.route!);
            });

            // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
          }
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 4), // Match with MenuWidget
            padding: MySpacing.xy(12, 10  ), // Consistent padding
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            width: double.infinity, // Ensure full width
            child: Row(
              children: [
                if (widget.iconData != null)
                  Icon(
                    widget.iconData,
                    size: 18,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                if (!widget.isCondensed) MySpacing.width(12),
                Expanded(
                  child: MyText.labelLarge(
                    widget.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                    fontWeight: 10,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  });

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;

    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(16, 0, 16, 4), // Match with MenuWidget
          padding: MySpacing.xy(12, 10), // Reduced height
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Icon(
                  widget.iconData,
                  color: isHover || isActive
                      ? leftBarTheme.activeItemColor
                      : leftBarTheme.onBackground,
                  size: 18,
                ),
              if (!widget.isCondensed) MySpacing.width(8),
              if (!widget.isCondensed)
                Expanded(
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    fontSize: 12.5,
                    fontWeight: 20,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
// //-----------------Chat-----------------//
                  // NavigationItem(
                  //   iconData: LucideIcons.messageSquare,
                  //   title: "chat".tr(),
                  //   route: '/chat',
                  //   isCondensed: isCondensed,
                  // ),
                  // NavigationItem(
                  //   iconData: LucideIcons.mail,
                  //   title: "Mail Box",
                  //   route: '/mailbox',
                  //   isCondensed: isCondensed,
                  // ),
                  // //-----------------Contact-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.contact,
                  //   isCondensed: isCondensed,
                  //   title: "Users",
                  //   children: [
                  //     MenuItem(
                  //       title: "Free Members",
                  //       route: '/contacts/members',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     // MenuItem(
                  //     //   title: "profile".tr(),
                  //     //   route: '/contacts/profile',
                  //     //   isCondensed: widget.isCondensed,
                  //     // ),
                  //     MenuItem(
                  //       title: "Premium Members".tr(),
                  //       route: '/contacts/edit-profile',
                  //       isCondensed: widget.isCondensed,
                  //     )
                  //   ],
                  // ),

                  // //-----------------CRM-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.users,
                  //   isCondensed: isCondensed,
                  //   title: 'CRM',
                  //   children: [
                  //     MenuItem(
                  //       title: "Contacts",
                  //       route: '/crm/contacts',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Opportunities",
                  //       route: '/crm/opportunities',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),

                  // // -----------------Ecommerce-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.store,
                  //   isCondensed: isCondensed,
                  //   title: "ecommerce".tr(),
                  //   children: [
                  //     MenuItem(
                  //       title: "products".tr(),
                  //       isCondensed: isCondensed,
                  //       route: '/apps/ecommerce/products',
                  //     ),
                  //     MenuItem(
                  //       title: "add_product".tr(),
                  //       isCondensed: isCondensed,
                  //       route: '/apps/ecommerce/add_product',
                  //     ),
                  //     MenuItem(
                  //       title: "product_detail".tr(),
                  //       isCondensed: isCondensed,
                  //       route: '/apps/ecommerce/product-detail',
                  //     ),
                  //     MenuItem(
                  //       title: "customers".tr(),
                  //       isCondensed: isCondensed,
                  //       route: '/apps/ecommerce/customers',
                  //     ),
                  //     MenuItem(
                  //       title: "invoice".tr(),
                  //       isCondensed: isCondensed,
                  //       route: '/apps/ecommerce/invoice',
                  //     ),
                  //   ],
                  // ),
                  // //-----------------File-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.folderPlus,
                  //   isCondensed: isCondensed,
                  //   title: "file".tr(),
                  //   children: [
                  //     MenuItem(
                  //       title: "manager".tr(),
                  //       route: '/apps/files',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "upload".tr(),
                  //       route: '/apps/file-uploader',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),

                  // //-----------------Project-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.briefcase,
                  //   isCondensed: isCondensed,
                  //   title: "Projects",
                  //   children: [
                  //     MenuItem(
                  //       title: "Project List",
                  //       route: '/projects/project-list',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Project Detail",
                  //       route: '/projects/project-detail',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Create Project",
                  //       route: '/projects/create-project',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),

                  // //-----------------KanBan-----------------//
                  // NavigationItem(
                  //   iconData: LucideIcons.squareKanban,
                  //   title: "Kanban",
                  //   route: '/kanban',
                  //   isCondensed: isCondensed,
                  // ),

                  // //-----------------NFT Dashboard-----------------//
                  // NavigationItem(
                  //   iconData: LucideIcons.circleDollarSign,
                  //   title: "NFT Dashboard",
                  //   route: '/NFTDashboard',
                  //   isCondensed: isCondensed,
                  // ),
                  // NavigationItem(
                  //   iconData: LucideIcons.shoppingCart,
                  //   title: "Customer",
                  //   route: '/shopping-customer',
                  //   isCondensed: isCondensed,
                  // ),
                  // NavigationItem(
                  //   iconData: LucideIcons.dumbbell,
                  //   title: "Fitness",
                  //   route: '/fitness',
                  //   isCondensed: isCondensed,
                  // ),
                  // NavigationItem(
                  //   iconData: LucideIcons.mailbox,
                  //   title: "Mail Box",
                  //   route: '/mila_box',
                  //   isCondensed: isCondensed,
                  // ),

                  // labelWidget("pages".tr()),

                  // //-----------------Landing-----------------//
                  // NavigationItem(
                  //   iconData: LucideIcons.presentation,
                  //   title: "landing".tr(),
                  //   route: '/ui/landing',
                  //   isCondensed: isCondensed,
                  // ),

                  // //-----------------Auth-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.shieldAlert,
                  //   isCondensed: isCondensed,
                  //   title: "auth".tr(),
                  //   children: [
                  //     MenuItem(
                  //       title: "login".tr(),
                  //       route: '/auth/login',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "login2".tr(),
                  //       route: '/auth/login1',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "register".tr(),
                  //       route: '/auth/register',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "register2".tr(),
                  //       route: '/auth/register1',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "forgot_password".tr(),
                  //       route: '/auth/forgot-password',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "forgot_password2".tr(),
                  //       route: '/auth/forgot_password1',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "reset_password".tr(),
                  //       route: '/auth/reset_password',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "reset_password2".tr(),
                  //       route: '/auth/reset_password1',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "locked".tr(),
                  //       route: '/auth/locked',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "locked2".tr(),
                  //       route: '/auth/locked1',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),

                  // //-----------------Error-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.alertCircle,
                  //   isCondensed: isCondensed,
                  //   title: 'Error',
                  //   children: [
                  //     MenuItem(
                  //       title: "ERROR-404",
                  //       route: '/error-404',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "ERROR-500",
                  //       route: '/error-500',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Coming Soon",
                  //       route: '/coming-soon',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Maintenance",
                  //       route: '/maintenance',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),

                  // //-----------------Extra Pages-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.bookOpenCheck,
                  //   isCondensed: isCondensed,
                  //   title: "Extra Pages",
                  //   children: [
                  //     MenuItem(
                  //       title: "FAQs".tr(),
                  //       route: '/faqs',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "pricing".tr(),
                  //       route: '/pricing',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "TimeLine",
                  //       isCondensed: isCondensed,
                  //       route: '/timeline',
                  //     ),
                  //   ],
                  // ),

                  // //-----------------Forms-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.formInput,
                  //   isCondensed: isCondensed,
                  //   title: "form".tr(),
                  //   children: [
                  //     MenuItem(
                  //       title: "basic".tr(),
                  //       route: '/form/basic',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Form Mask".tr(),
                  //       route: '/form/form-mask',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Quill Editor".tr(),
                  //       route: '/form/quill-editor',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "validation".tr(),
                  //       route: '/form/validation',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "wizard".tr(),
                  //       route: '/form/wizard',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),
                  // //-----------------UI Widget-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.layoutGrid,
                  //   isCondensed: isCondensed,
                  //   title: "widgets".tr(),
                  //   children: [
                  //     MenuItem(
                  //       title: "buttons".tr(),
                  //       route: '/ui/buttons',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "cards".tr(),
                  //       route: '/ui/cards',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "tabs".tr(),
                  //       route: '/ui/tabs',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "dialogs".tr(),
                  //       route: '/ui/dialogs',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "carousels".tr(),
                  //       route: '/ui/carousels',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "drag_drop".tr(),
                  //       route: '/ui/drag-drop',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "notifications".tr(),
                  //       route: '/ui/notification',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),

                  // NavigationItem(
                  //   iconData: LucideIcons.file,
                  //   title: "starter".tr(),
                  //   route: '/starter',
                  //   isCondensed: isCondensed,
                  // ),
                  // //-----------------Other-----------------//
                  // labelWidget("other".tr()),
                  // NavigationItem(
                  //   iconData: LucideIcons.table2,
                  //   title: "basic_tables".tr(),
                  //   route: '/other/basic_tables',
                  //   isCondensed: isCondensed,
                  // ),
                  // NavigationItem(
                  //   iconData: LucideIcons.barChartBig,
                  //   title: "syncfusion_charts".tr(),
                  //   route: '/other/syncfusion_charts',
                  //   isCondensed: isCondensed,
                  // ),
                  // NavigationItem(
                  //   iconData: LucideIcons.barChart,
                  //   title: "fl_chart".tr(),
                  //   route: '/other/fl_chart',
                  //   isCondensed: isCondensed,
                  // ),
                  // //-----------------Maps-----------------//
                  // MenuWidget(
                  //   iconData: LucideIcons.map,
                  //   isCondensed: isCondensed,
                  //   title: "maps".tr(),
                  //   children: [
                  //     MenuItem(
                  //       title: "Sf Maps".tr(),
                  //       route: '/maps/sf-maps',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //     MenuItem(
                  //       title: "Google Maps".tr(),
                  //       route: '/maps/google-maps',
                  //       isCondensed: widget.isCondensed,
                  //     ),
                  //   ],
                  // ),

                  // MySpacing.height(16),
                  // if (!isCondensed)
                  //   Center(
                  //     child: MyButton(
                  //         borderRadiusAll: AppStyle.buttonRadius.small,
                  //         elevation: 0,
                  //         padding: MySpacing.xy(12, 16),
                  //         onPressed: () {
                  //           UrlService.goToPurchase();
                  //         },
                  //         backgroundColor: theme.colorScheme.primary,
                  //         child: MyText.labelMedium(
                  //           'purchase_now'.tr(),
                  //           color: theme.colorScheme.onPrimary,
                  //         )),
                  //   ),