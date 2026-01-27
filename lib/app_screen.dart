import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mystudy/router/app_router.gr.dart';

@RoutePage()
class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context)  {
    return AutoTabsRouter(
      // Le `builder` permet de construire l'interface en fonction du changement d'index
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);

        return Scaffold(
          // appBar: AppBar(
          //   // title: const Text('My App'),
          //   automaticallyImplyLeading: false, // Désactive le bouton de retour
          // ),
          body: child, 
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: tabsRouter.activeIndex, // Suivi de l'index actif
            onTap: (index) {
              // Modifier l'index actif avec la méthode setActiveIndex
              tabsRouter.setActiveIndex(index);
            },



            items:  const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, color: Colors.black,),
                  label: 'Home',
                  activeIcon: Icon(Icons.home, color: Colors.purple,),
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.folder, color: Colors.purple,),

                  icon: Icon(Icons.folder_outlined, color: Colors.black,), label: 'Library'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.quiz, color: Colors.purple,),

                  icon: Icon(Icons.quiz_outlined, color: Colors.black,), label: 'QUIZ'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.create, color: Colors.purple,),
                  icon: Icon(Icons.create_outlined, color: Colors.black,), label: 'Personal Study'),
              BottomNavigationBarItem(
                  activeIcon: Icon(Icons.settings, color: Colors.purple,),

                  icon: Icon(Icons.settings, color: Colors.black,), label: 'Settings'),
            ],
          ),
        );
      },

      // Routes définies dans AutoRoute pour chaque onglet
      routes: [
        const StudentBoardRoute(),
        const SubjectListRoute(),
        const CreateQuizRoute(),
        QuizRoute(),
        GameRoute()  // N'oubliez pas d'ajouter les routes pour chaque onglet
      ],
    );
  }
}
