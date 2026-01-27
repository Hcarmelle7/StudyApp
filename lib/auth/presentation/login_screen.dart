import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/auth/business_logic/bloc/auth_bloc.dart';
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/quiz/business_logic/score_bloc/score_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:mystudy/tools/themes/colors/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../subject/business_logic/subject_bloc/subject_bloc.dart';

@RoutePage()
// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> _isObscure = ValueNotifier<bool>(true);

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _passwordController.text;

      BlocProvider.of<AuthBloc>(context).add(LoginEvent(email, password));
    }
  }

  bool stateButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColorScheme.surface,
      // appBar: AppBar(title: const Text('Login')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String> userRole =
              prefs.getStringList('role') ?? ['ROLE_STUDENT'];
          if (state is LoginSuccess) {
            // getIt.get<StudentBloc>().add(GetAllStudentsEvent());
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => RegisterScreen()));
            // context.router.push(HomeRoute());
            if (userRole.first == 'ROLE_STUDENT') {
              getIt.get<ProfileBloc>().add(GetCurrentUserEvent());
              getIt.get<SubjectBloc>().add(GetAllSubjectEvent());
              getIt.get<ScoreBloc>().add(GetAllScoresEvent());
              if (!context.mounted) return;
              context.router.pushAndPopUntil(const StudentBoardRoute(),
                  predicate: (router) => false);
            } else if (userRole.first == 'ROLE_TEACHER') {
              if (!context.mounted) return;
              context.router.pushAndPopUntil(const TeacherBoardRoute(),
                  predicate: (router) => false);
            } else {
              if (!context.mounted) return;
              context.router.pushAndPopUntil(const HomeRoute(),
                  predicate: (router) => false);
            }
            // context.router.pushAndPopUntil(
            //   const AppRoute(),
            //   predicate: (router) => false,
            // );
          } else if (state is LoginFailure) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.message}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 23),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/book.png', // Remplacez par votre illustration
                    height: 100,
                  ),
                  const Text(
                    'Login',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 70),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        fillColor: AppColors.white,
                        filled: true,
                        hintText: 'Email address',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom d\'utilisateur';
                      }
                      return null; // Validation réussie
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isObscure,
                    builder: (context, isObscure, child) {
                      return TextFormField(
                        controller: _passwordController,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _isObscure.value = !isObscure;
                                },
                                icon: Icon(isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                            fillColor: AppColors.white,
                            filled: true,
                            hintText: 'Mot de passe',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre mot de passe';
                          }
                          return null; // Validation réussie
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkColorScheme.primary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: state is LoginLoading
                            ? null
                            : () => _login(
                                context), // Désactiver le bouton si en chargement
                        child: state is LoginLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                'Se connecter',
                                style: TextStyle(color: AppColors.white),
                              ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Naviguer vers ForgotPasswordScreen
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 55),
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            context.router.push(const LegisterRoute());
                          },
                          color: AppColors.darkColorScheme.primary,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Register',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
