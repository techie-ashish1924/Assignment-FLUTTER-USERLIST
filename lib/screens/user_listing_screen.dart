import 'package:assignment/bloc/user_bloc.dart';
import 'package:assignment/bloc/user_event.dart';
import 'package:assignment/bloc/user_state.dart';
import 'package:assignment/model/user_model.dart';
import 'package:assignment/widgets/common_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchUserListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                context.read<UserBloc>().add(UserSearchEvent(user: value));
              },
            ),
          ),

          SizedBox(height: 10),

          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserListLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is UserListLoadedState) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<UserBloc>().add(RefreshUserListEvent());
                    },
                    child: state.userList!.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.userList?.length ?? 0,
                            itemBuilder: (context, index) {
                              return UserTile(
                                user:
                                    state.userList?[index] ??
                                    User(id: 0, name: "", email: ""),
                              );
                            },
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 1,

                            child: Center(child: Text("No User Present")),
                          ),
                  );
                } else if (state is UserListErrorState) {
                  return Center(
                    child: Text(state.msg ?? "OOPs something went wrong"),
                  );
                }
                return const Center(child: Text("Press button to fetch users"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
