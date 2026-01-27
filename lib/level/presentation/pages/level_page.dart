// screens/user_list_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/level/business_logic/bloc/level_bloc.dart';
import 'package:mystudy/level/presentation/widgets/level_widget.dart';
import 'package:mystudy/router/app_router.gr.dart';

@RoutePage()
class LevelPage extends StatelessWidget {
  const LevelPage({super.key}); // Passer AuthService dans le constructeur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('level List')),
      body: BlocBuilder<LevelBloc, LevelState>(
        builder: (context, state) {
          if (state is GetAllLevelsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllLevelsFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is GetAllLevelsSuccess) {
            return ListView.builder(
              itemCount: state.level.length,
              itemBuilder: (context, index) {
                final level = state.level[index];
                return LevelWidget(title: level.title);
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => UpdateStudentPage()));
          context.router.push(CreateLevelRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


