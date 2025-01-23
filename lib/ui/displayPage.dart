import 'package:bloc_api/bloc/user_bloc.dart';
import 'package:bloc_api/ui/addPage.dart';
import 'package:bloc_api/ui/updatePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayDataPage extends StatefulWidget {
  const DisplayDataPage({super.key});

  @override
  State<DisplayDataPage> createState() => _DisplayDataPageState();
}

class _DisplayDataPageState extends State<DisplayDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.withOpacity(0.2),
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: Text("HomePage"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddDataPage()));
                },
                icon: const Icon(
                  Icons.add,
                  size: 30,
                )),
          )
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserSuccessState) {
            return state.data.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final user = state.data[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name : ${user['userName']}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  "Designation: ${user['userDesignation']}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Number: ${user['userRollNumber']}",
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Colors.blueGrey,
                                          width: 1.2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateDataPage(
                                                        user: user)));
                                      },
                                      child: const Text(
                                        "UPDATE",
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Colors.red,
                                          width: 1.2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      onPressed: () {
                                        context.read<UserBloc>().add(
                                              DeleteUserEvent(user['id']),
                                            );
                                      },
                                      child: const Text(
                                        "REMOVE",
                                        style: TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "No Users Found!",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 22.0,
                      ),
                    ),
                  );
          } else if (state is UserErrorState) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}
