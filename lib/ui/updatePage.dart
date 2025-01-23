import 'package:bloc_api/bloc/user_bloc.dart';
import 'package:bloc_api/widgets/textFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateDataPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const UpdateDataPage({super.key, required this.user});

  @override
  State<UpdateDataPage> createState() => _UpdateDataPageState();
}

class _UpdateDataPageState extends State<UpdateDataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user['userName'];
    designationController.text = widget.user['userDesignation'];
    numberController.text = widget.user['userRollNumber'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
        centerTitle: false,
        title: const Text("UpdateDataPage"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              maxLength: 15,
              controller: nameController,
              hintText: "Enter Your Name",
              labelText: "Full Name",
              iconWidget: const Icon(Icons.person),
            ),
            CustomTextField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Designation is required';
                }
                return null;
              },
              maxLength: 25,
              controller: designationController,
              hintText: "Enter Your Designation",
              labelText: "Designation",
              iconWidget: const Icon(Icons.business_center),
            ),
            CustomTextField(
                keyBoardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Number is required';
                  } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                controller: numberController,
                hintText: "Enter Your UserNumber",
                labelText: "User Number",
                iconWidget: const Icon(Icons.numbers),
                maxLength: 5),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<UserBloc>().add(
                        UpdateUserEvent(
                          widget.user['id'],
                          nameController.text,
                          designationController.text,
                          int.parse(numberController.text),
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "SAVE",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20.0,
                    letterSpacing: 2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
