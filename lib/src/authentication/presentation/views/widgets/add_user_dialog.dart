import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_tutorial/src/authentication/presentation/cubit/auth_cubit.dart';

class AddUserDialog extends StatelessWidget {
  final TextEditingController nameController;

  const AddUserDialog({super.key, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'username'),
            ),
            ElevatedButton(
                onPressed: () {
                  final name = nameController.text.trim();
                  context.read<AuthCubit>().createUserHandler(
                      createdAt: DateTime.now().toString(),
                      name: name,
                      avatar: "https://i.pravatar.cc/300");
                  Navigator.of(context).pop();
                },
                child: const Text("Create User"))
          ],
        ),
      ),
    );
  }
}
