import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:mystudy/tools/widgets/service_widget.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('home page is reached');
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/book.png'),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const badges.Badge(
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.lightBlue),
                badgeContent: Text(
                  '4',
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.notifications_outlined),
              ),
              IconButton(
                  onPressed: () {
                    getIt.get<ProfileBloc>().add(GetCurrentUserEvent());
                    context.router.push(const ProfileRoute());
                  },
                  icon: const Icon(Icons.person)),
              const SizedBox(
                width: 22,
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 45,
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'search books, courses',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  prefixIcon: const Icon(Icons.search)),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const Text(
            '  What\'s New?',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            height: 135,
            padding: const EdgeInsets.all(5),
            child: ListView(scrollDirection: Axis.horizontal, children: const [
              Service(
                  image: AssetImage('assets/images/book.png'),
                  text: 'Transfert'),
              Service(
                  image: AssetImage('assets/images/believe.png'),
                  text: 'Save Money'),
              Service(
                  image: AssetImage('assets/images/learning.png'),
                  text: 'withdraw'),
              Service(
                image: AssetImage('assets/images/book.png'),
                text: 'Set Goals',
              ),
              Service(
                image: AssetImage('assets/images/book.png'),
                text: 'Set Goals',
              ),
            ]),
          ),
          Container(
              padding: const EdgeInsets.all(7),
              child: const Column(children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/book.png'),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Buy a car')],
                    )
                  ],
                ),
                SizedBox(
                    width: 255,
                    child: LinearProgressIndicator(
                      value: 25 / 100,
                    ))
              ]))
        ],
      ),
      // bottomNavigationBar: Container(
      //   decoration: const BoxDecoration(
      //     color: Colors.white,
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         onPressed: () {},
      //         icon: const Icon(Icons.home_outlined),
      //         focusColor: Colors.blue,
      //       ),
      //       IconButton(onPressed: () {}, icon: const Icon(Icons.folder_open)),
      //       IconButton(
      //           onPressed: () {}, icon: const Icon(Icons.add_circle_outline)),
      //       IconButton(
      //           onPressed: () {}, icon: const Icon(Icons.note_alt_outlined)),
      //       IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
      //     ],
      //   ),
      // ),
    );
  }
}
