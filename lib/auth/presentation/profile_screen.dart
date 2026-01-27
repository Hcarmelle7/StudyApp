import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: const Text('Edit'))],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is GetCurrentUserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetCurrentUsersFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is GetCurrentUserSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Center(
                          child: ClipOval(
                            child: Image.network(
                              '$baseUrl/${state.user.profilePicture!}',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          '${state.user.firstname} ${state.user.lastname}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        // Text('+237 ${state.user.phone} '),
                        const SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 50),
                            ),
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.white,
                                  ),
                                  // SizedBox(
                                  //   width: 25,
                                  // ),
                                  Text(
                                    'Change your Profile Picture',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  getParametre(context),
                ],
              ),
            ); // TODO CONTINUE
          }
          return Container();
        },
      ),
    );
  }

  Widget getParametre(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      child: Column(
        children: [
          // const Text('data'),
          const SizedBox(
            height: 8,
          ),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.nightlight_sharp),
            ),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.school_outlined),
            ),
            title: Text('My class'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.deepPurple,
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.notifications_active),
            ),
            title: Text('notification and sounds'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.deepPurple,
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.security),
            ),
            title: Text('security'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.deepPurple,
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.help_outline),
            ),
            title: Text('help center'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.deepPurple,
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.info_outlined),
            ),
            title: Text('about'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('token');
                  prefs.remove('role');
                  context.router.pushAndPopUntil(LoginRoute(),
                      predicate: (router) => false);
                },
                child: const Text(
                  'Log Out',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
          ),

          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: const Text(
                  'Delete account',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )),
          ),

          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }
}
