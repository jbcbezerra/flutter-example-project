import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_cubit.dart';
import 'package:tdd_tutorial/src/authentication/presentation/views/widgets/add_user_dialog.dart';
import 'package:tdd_tutorial/src/authentication/presentation/views/widgets/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  void getUsers() {
    context.read<AuthCubit>().getUsersHandler();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.msg)));
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const LoadingColumn(msg: "Fetching Users")
              : state is CreatingUser
                  ? const LoadingColumn(msg: "Creating User")
                  : state is UsersLoaded
                      ? Center(
                          child: ListView.builder(
                          itemBuilder: (context, index) {
                            final user = state.users[index];
                            return ListTile(
                              leading: Image.network(user.avatar),
                              title: Text(user.name),
                              subtitle: Text(user.createdAt.substring(10)),
                            );
                          },
                          itemCount: state.users.length,
                        ))
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => AddUserDialog(
                          nameController: nameController,
                        ));
              },
              label: const Text("Add User")),
        );
      },
    );
  }
}
