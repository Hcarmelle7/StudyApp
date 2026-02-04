import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mystudy/features/auth/business_logic/auth_bloc/auth_bloc.dart';
import 'package:mystudy/features/auth/data/model/user_model.dart';
import 'package:mystudy/features/level/business_logic/bloc/level_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/core/services/network/service_locator.dart';
import 'package:mystudy/core/themes/colors/app_colors.dart';

@RoutePage()
class LegisterPage extends StatefulWidget {
  const LegisterPage({super.key});

  @override
  State<LegisterPage> createState() => _LegisterState();
}

class _LegisterState extends State<LegisterPage> {
  final PageController _pageController = PageController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'student';
  int selectedLevel = 0;
  DateTime? _selectedDate;
  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            SizedBox(
              height: 195,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                minimumDate: DateTime(1900),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
            ),
            // Bouton pour fermer le Picker
            CupertinoButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  final List<String> _roles = ['student', 'teacher', 'school', 'parent'];
  final _formKey = GlobalKey<FormState>();
  int _currentPage = 0;
  bool isObscure = true;
  void _nextPage() {
    if (_currentPage < 5) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
          duration: const Duration(seconds: 01), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _register(BuildContext context) {
    final user = UserModel(
      email: _emailController.text,
      firstname: _firstnameController.text,
      lastname: _lastnameController.text,
      phone: _phoneController.text,
      birthday: _selectedDate,
      // country: _countryController.text,
      password: _passwordController.text,
      roles: [_selectedRole],
    );

    BlocProvider.of<AuthBloc>(context).add(RegisterEvent(user));
  }

  bool _isFormValid = false; // Variable pour savoir si le formulaire est valide

  void _validateForm(String value) {
    setState(() {
      _isFormValid = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _passwordController.text.length >= 8;
    });
  }

  // void _updateStudent(BuildContext context) {
  //   final Student =
  //       StudentModel(levelId: selectedLevel, birthday: _selectedDate);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Join StudyApp',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousPage,
              )
            : null,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            context.loaderOverlay.show();
          }
          if (state is RegisterSuccess) {
            if (state.user?.roles == 'student') {
              getIt.get<LevelBloc>().add(GetAllLevelsEvent());
              context.router.push(const UpdateStudentRoute());
            }
            else if (state.user?.roles == 'teacher') {
              return;
            }
            context.loaderOverlay.hide();
            getIt.get<LevelBloc>().add(GetAllLevelsEvent());
            context.router.push(const UpdateStudentRoute());
          } else if (state is RegisterFailure) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.error}')),
            );
          }
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/online_learning.png', // Remplacez par votre illustration
                    height: 250,
                    fit: BoxFit.fitWidth,
                  ),
                  const Text(
                      'Create an account to access quizzes, course summaries, and exercices tailored to your level. Enhance your learning and prepare for Exams with ease'),
                  const SizedBox(
                    height: 45,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black1,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        _nextPage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.apple,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            Text(
                              'Sign up with Apple',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black1,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        _nextPage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.facebook,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              'Sign up with facebook',
                              style: TextStyle(color: AppColors.white),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 12),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white2,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        _nextPage();
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 65,
                            ),
                            Text(
                              'sign up with email',
                              style: TextStyle(
                                  color: AppColors.black1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 38,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.router.push(LoginRoute());
                        },
                        child: const Text(
                          'Already have an account? Sign In',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey, // Ajoutez une clé de formulaire pour valider
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'What\'s your name?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text('Enter the name you use in real life'),
                    const SizedBox(
                      height: 22,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstnameController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'First name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field required'; // Message d'erreur si vide
                              }
                              return null; // Si valide
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _lastnameController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Last name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'field required'; // Message d'erreur si vide
                              }
                              return null; // Si valide
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          // Valider le formulaire
                          if (_formKey.currentState?.validate() ?? false) {
                            _nextPage(); // Si valide, passer à la page suivante
                          } else {
                            // Si invalides, afficher un message ou une alerte
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please fill in both fields.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 390,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.router.push(LoginRoute());
                          },
                          child: const Text(
                            'Already have an account? Sign In',
                            style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'What\'s your birthday?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Text('choose the date of your birth'),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => _showDatePicker(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                            filled: true,
                            // labelText: 'Date of birth',
                            labelText: _selectedDate != null
                                ? "${_selectedDate!.day} ${_selectedDate!.month} ${_selectedDate!.year}"
                                : "Select Date",
                            suffixIcon: const Icon(Icons.calendar_month),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {
                          _nextPage();
                        },
                        child: const Text(
                          'next',
                          style: TextStyle(color: AppColors.white),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What\'s your mobile number?',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text(
                        'Enter the monile number where you can be contacted. No one will see this on your profile'),
                    const SizedBox(height: 20),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),

                          //fillColor: Colors.purple.shade100,
                          filled: true,
                          labelText: 'Mobile Number',
                          hintStyle: const TextStyle(color: AppColors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            _nextPage();
                          },
                          child: const Text(
                            'next',
                            style: TextStyle(color: AppColors.white),
                          )),
                    )
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter your Email and Password?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text('Your password must be at least 8 characters'),
                  const SizedBox(
                    height: 22,
                  ),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintStyle: const TextStyle(color: AppColors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: _validateForm,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      hintStyle: const TextStyle(color: AppColors.white),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          icon: Icon(isObscure
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: _validateForm,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: (_isFormValid) ? _nextPage : null,
                      child: const Text(
                        'Next',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Put on your hat! \n Which team do you belong to?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: ListView(
                        children: _roles.map((role) {
                          // Personnalisation pour chaque rôle
                          IconData icon;
                          Color tileColor;
                          TextStyle textStyle;

                          // Appliquer des styles différents selon le rôle
                          switch (role) {
                            case 'student':
                              icon = Icons.school;
                              tileColor = Colors.blue.shade100;
                              textStyle = const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue);
                              break;
                            case 'teacher':
                              icon = Icons.person;
                              tileColor = Colors.purple.shade100;
                              textStyle = const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple);
                              break;
                            case 'school':
                              icon = Icons.business;
                              tileColor = Colors.orange.shade100;
                              textStyle = const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange);
                              break;
                            case 'parent':
                              icon = Icons.family_restroom;
                              tileColor = Colors.green.shade100;
                              textStyle = const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green);
                              break;
                            default:
                              icon = Icons.help;
                              tileColor = Colors.grey.shade100;
                              textStyle = const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black);
                          }

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    tileColor, // Background color for the tile
                                borderRadius: BorderRadius.circular(
                                    16.0), // Rounded corners
                                border: Border.all(
                                    color: textStyle.color!, width: 2),
                              ),
                              child: ListTile(
                                title: Text(
                                  role[0].toUpperCase() +
                                      role.substring(
                                          1), // Capitaliser le premier caractère
                                  style: textStyle,
                                ),
                                leading: Icon(icon, color: textStyle.color),
                                tileColor: tileColor,
                                trailing: Icon(Icons.arrow_forward,
                                    color: textStyle.color),
                                onTap: () {
                                  // Action spécifique pour chaque rôle
                                  print('$role sélectionné');
                                  if (role == 'student') {
                                    setState(() {
                                      _selectedRole = role;
                                    });
                                    _register(context);
                                  } else if (role == role) {
                                    setState(() {
                                      _selectedRole = 'teacher';
                                    });
                                    _register(context);
                                  } else if (role == 'school') {
                                    setState(() {
                                      _selectedRole = 'student';
                                    });
                                    _register(context);
                                  } else if (role == 'parent') {
                                    setState(() {
                                      _selectedRole = 'student';
                                    });
                                    _register(context);
                                  }
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
