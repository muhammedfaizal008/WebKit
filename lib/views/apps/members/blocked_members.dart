import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/controller/apps/members/blocked_members_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/views/layouts/layout.dart';

class BlockedMembers extends StatelessWidget with UIMixin {
   BlockedMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlockedMembersController>(
      init: BlockedMembersController(),
      builder: (controller) {
        return Layout(
          child: Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Blocked Users", fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Users"),
                        MyBreadcrumbItem(name: "Blocked Users", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: _buildMainContent(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainContent(BlockedMembersController controller) {
    // if (controller.isLoading.value) {
    //   return  Center(child: CircularProgressIndicator());
    // }

    return Column(
      children: [
        _buildTableHeader(),
        _buildEmptyState(),
        _buildTableFooter(controller),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      child: Row(
        children: [
          MyText.titleMedium("Blocked Users", fontWeight: 600),
          const Spacer(),
          _buildSearchField(),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),)
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 300,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search blocked users...',
          prefixIcon: Icon(LucideIcons.search, size: 20),
          isDense: true,
          contentPadding: MySpacing.xy(12, 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      width: double.infinity,
      // padding: MySpacing.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.userX, size: 48, color: Colors.grey.shade400),
          MySpacing.height(16),
          MyText.titleMedium(
            "No blocked users found",
            color: Colors.grey.shade600,
          ),
          MySpacing.height(8),
          MyText.bodySmall(
            "When you block users, they will appear here",
            color: Colors.grey.shade500,
          ),
        ],
      ),
    );
  }

  Widget _buildTableFooter(BlockedMembersController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText.bodySmall(
            "Showing 0-0 of 0",
            color: Colors.grey.shade600,
          ),
          _buildPaginationControls(controller),
        ],
      ),
    );
  }

  Widget _buildPaginationControls(BlockedMembersController controller) {
    return Row(
      children: [
        IconButton(
          onPressed: null, // Disabled since no pages
          icon: Icon(LucideIcons.chevronLeft),
          tooltip: "Previous page",
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: contentTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: contentTheme.primary.withOpacity(0.3)),
          ),
          child: MyText.bodyMedium(
            "0 of 0",
            fontWeight: 600,
            color: contentTheme.primary,
          ),
        ),
        IconButton(
          onPressed: null, // Disabled since no pages
          icon: Icon(LucideIcons.chevronRight),
          tooltip: "Next page",
        ),
      ],
    );
  }
}