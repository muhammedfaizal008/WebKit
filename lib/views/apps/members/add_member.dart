import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/apps/members/add_member_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/my_textfield_form.dart';
import 'package:webkit/views/layouts/layout.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddMemberController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  final TextEditingController educationController = TextEditingController();

  @override
  void initState() {
    controller = Get.put(AddMemberController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<AddMemberController>(
        builder: (_) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                MyText(
                  "Add Member",
                  fontSize: 20,
                  fontWeight: 10,
                ),
                const SizedBox(height: 20),
                MyContainer(
                 child: Padding(
                   padding: const EdgeInsets.all(20),
                   child: Column(
                      children: [
                        MyTextFieldForm(
                          nameController: nameController,
                          labeltext: "Full Name",
                          hintText: "Enter your full name",
                          icondata: Icons.person,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        MyTextFieldForm(
                          nameController: ageController,
                          labeltext: "Age",
                          hintText: "Enter your age",
                          icondata: Icons.calendar_today,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter age';
                            }
                            return null;
                          },
                   
                        ),
                        const SizedBox(height: 10),
                        MyTextFieldForm(
                          nameController: locationController,
                          labeltext: "Location",
                          hintText: "Enter your location",
                          icondata: Icons.location_on,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter location';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        MyTextFieldForm(
                          nameController: professionController,
                          labeltext: "Profession",
                          hintText: "Enter your profession",
                          icondata: Icons.work,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter profession';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        MyTextFieldForm(
                          nameController: educationController,
                          labeltext: "Education",
                          hintText: "Enter your education",
                          icondata: Icons.school,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter education';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        MyButton(
                          backgroundColor: Colors.blue,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: Text(
                            "Add Member",
                            style: MyTextStyle.getStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: 10,
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Get.snackbar("Success", "Member added successfully");
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                 ),

                ),  
              ],
            ),
          ),
        ),
      ),
    );
  }
}


