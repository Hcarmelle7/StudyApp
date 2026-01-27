import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/quiz/presentation/widgets/score_widget.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:badges/badges.dart' as badges;
import 'package:mystudy/subject/presentation/widgets/subject_widget.dart';

@RoutePage()
class StudentBoardScreen extends StatelessWidget {
  const StudentBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 231, 231),
        appBar: AppBar(
          title: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              String username = "";
              if (state is GetCurrentUserSuccess) {
                username = state.user.firstname;
              }

              return Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/book.png'),
                  ),
                  Text(' Hello $username'),
                ],
              );
            },
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
                      // getIt.get<ProfileBloc>().add(GetCurrentUserEvent());
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 180,
                  child: Stack(
                    children: [
                      Card(
                        elevation: 20,
                        color: Colors.purple.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                              145, // Augmentez la hauteur pour inclure la barre de recherche
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:  Center(
                            child: Image.asset('assets/images/schedule.png'),

                          ),
                        ),
                      ),
                      Positioned(
                        top: 118,
                        left: 16,
                        right: 16,
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: InkWell(
                              onTap: () {
                                context.router.push(SeachDataRoute());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(Icons.search),
                                      SizedBox(width: 12,),
                                      Text('Search books, courses...')
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your last scores',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'see all',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w900),
                        ))
                  ],
                ),
                const SizedBox(height: 230, child: ScoreWidget()),
                const Text(
                  'Subjects',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SubjectWidget(
                    image: AssetImage('assets/images/book.png')),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
