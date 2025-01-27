import 'package:bloc_api/bloc/user_bloc.dart';
import 'package:bloc_api/widgets/textFormField.dart';
import 'package:bloc_api/widgets/toastDialog.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddDataPage extends StatefulWidget {
  const AddDataPage({super.key});

  @override
  State<AddDataPage> createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
        centerTitle: false,
        title: const Text("AddDataPage"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            String displayCountry = "";
            if (state is CountryState) {
              displayCountry = state.countrySelected;
            }

            return Form(
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
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all()),
                      width: double.infinity,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            exclude: <String>['KN', 'MF'],
                            onSelect: (Country country) {
                              context.read<UserBloc>().add(
                                    CountryEvent(
                                        "${country.flagEmoji} ${country.name}"),
                                  );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.public),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  displayCountry == ""
                                      ? const Text("Choose Country")
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            "Country:  $displayCountry",
                                          ),
                                        ),
                                ],
                              ),
                              displayCountry == ""
                                  ? const Icon(Icons.arrow_drop_down)
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: Text(
                              "Let us know you’re working—check here!",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {
                      DateTime now = DateTime.now();
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(now);
                      if (_formKey.currentState!.validate()) {
                        if (displayCountry != "") {
                          context.read<UserBloc>().add(
                                AddUserEvent(
                                  nameController.text,
                                  designationController.text,
                                  int.parse(numberController.text),
                                  isChecked,
                                  formattedDate,
                                  "",
                                  displayCountry,
                                ),
                              );
                          toastDialog(
                            context: context,
                            message: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Padding(
                                padding: EdgeInsets.only(left: 14.0),
                                child: Text(
                                  "Data has been added successfully!",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            leadingIcon: const Icon(Icons.verified),
                            animationDuration: const Duration(seconds: 1),
                            displayDuration: const Duration(seconds: 2),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text("Country is Required Fields!"),
                              ),
                            ),
                          );
                        }
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
            );
          },
        ),
      ),
    );
  }
}
