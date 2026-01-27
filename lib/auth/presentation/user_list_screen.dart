// screens/user_list_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/auth/business_logic/bloc/auth_bloc.dart';

@RoutePage()
class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key}); // Passer AuthService dans le constructeur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User List')),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is FetchUsersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchUsersFaillure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is FetchUsersSuccess) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  leading: Text(user.email),
                  title: Text(user.firstname),
                  subtitle: Text('ID: ${user.id}'),
                  // trailing: Text(user.country ?? ''),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
