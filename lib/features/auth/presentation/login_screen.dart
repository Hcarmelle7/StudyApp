import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/features/auth/business_logic/auth_bloc/auth_bloc.dart';
import 'package:mystudy/features/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/features/quiz/business_logic/score_bloc/score_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/core/services/network/service_locator.dart';
import 'package:mystudy/core/themes/colors/app_colors.dart';
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

  @override
  Widget build(BuildContext context) {
    // Récupérer la taille de l'écran pour le responsive
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 600;

    return Scaffold(
      backgroundColor: AppColors.darkColorScheme.surface,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          List<String> userRole =
              prefs.getStringList('role') ?? ['ROLE_STUDENT'];

          if (state is LoginSuccess) {
            // Logique de navigation conservée intacte
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
          } else if (state is LoginFailure) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.message}')),
            );
          }
        },
        child: Center(
          // Center permet de centrer le formulaire sur les grands écrans (tablette/web)
          child: SingleChildScrollView(
            // Padding dynamique : moins de padding sur petits écrans pour gagner de la place
            padding: EdgeInsets.symmetric(
                vertical: 20, horizontal: size.width > 600 ? 0 : 23),
            child: Center(
              child: ConstrainedBox(
                // Contrainte cruciale : Le formulaire ne dépassera jamais 500px de large
                constraints: const BoxConstraints(maxWidth: 500),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/book.png',
                        // Taille d'image relative à la hauteur de l'écran (max 120, min 80)
                        height: size.height * 0.15 > 580
                            ? 120
                            : (size.height * 0.15 < 80
                                ? 80
                                : size.height * 0.15),
                      ),
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w900),
                      ),
                      // Espace relatif (7% de la hauteur de l'écran) au lieu de fixe (70)
                      SizedBox(height: isSmallScreen ? 30 : size.height * 0.07),

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
                          return null;
                        },
                      ),
                      const SizedBox(
                          height:
                              15), // Réduit légèrement pour le confort visuel

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
                              return null;
                            },
                          );
                        },
                      ),

                      const SizedBox(height: 25),

                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.darkColorScheme.primary,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: state is LoginLoading
                                ? null
                                : () => _login(context),
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

                      // Espace relatif
                      SizedBox(height: isSmallScreen ? 30 : size.height * 0.05),

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
                      // Espace en bas pour éviter que le bouton soit collé sur petits écrans
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
