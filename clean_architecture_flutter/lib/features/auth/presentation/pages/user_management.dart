import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class UserManagement extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Add User', style: TextStyle(fontSize: 20)),
          ),
          _buildAddUserForm(context),
          _buildUserList(context),
        ],
      ),
    );
  }

  Widget _buildAddUserForm(BuildContext context) {
    return Column(
      children: [
        TextField(controller: emailController, decoration: InputDecoration(labelText: 'User Email')),
        TextField(controller: roleController, decoration: InputDecoration(labelText: 'User Role')),
        ElevatedButton(
          onPressed: () {
            // Call the method to add user with role
            // context.read<AuthCubit>().addUser(emailController.text, roleController.text);
          },
          child: Text('Add User'),
        ),
      ],
    );
  }

  Widget _buildUserList(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthAuthenticated) {
            // Display the list of users
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.email),
                  subtitle: Text('Role: ${user.role}'),
                );
              },
            );
          } else {
            return Center(child: Text('No users available.'));
          }
        },
      ),
    );
  }
}
