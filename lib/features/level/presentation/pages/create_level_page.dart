// lib/screens/register_screen.dart
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/features/level/data/models/level_model.dart';
import 'package:mystudy/features/level/business_logic/bloc/level_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/core/services/network/service_locator.dart';
import 'package:mystudy/core/themes/colors/app_colors.dart';

@RoutePage()
// ignore: must_be_immutable
class CreateLevelPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();

  CreateLevelPage({super.key});

  void _register(BuildContext context) {
    final level = LevelModel(
      id: Random().nextInt(100),
      title: _titleController.text,
    );

    BlocProvider.of<LevelBloc>(context).add(CreateLevelEvent(level));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text('Inscription')),
      body: BlocListener<LevelBloc, LevelState>(
        listener: (context, state) {
          if (state is CreateLevelSuccess) {
            getIt.get<LevelBloc>().add(GetAllLevelsEvent());
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder: (context) => LoginScreen()),
            // );
          
            context.router.push(const LevelRoute());
          } else if (state is CreateLevelFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erreur : ${state.message}')));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    fillColor: AppColors.primary,
                    filled: true,
                    labelText: 'Nom',
                    labelStyle: const TextStyle(color: AppColors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
              BlocBuilder<LevelBloc, LevelState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is CreateLevelLoading
                        ? null
                        : () => _register(
                            context), // Désactiver le bouton si en chargement
                    child: state is CreateLevelLoading
                        ? const CircularProgressIndicator() // Affichez le CircularProgressIndicator
                        : const Text('Créer'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
