import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/subject/business_logic/subject_bloc/subject_bloc.dart';
import 'package:mystudy/tools/themes/colors/app_colors.dart';
import 'package:mystudy/tools/widgets/shimmer_container.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({
    super.key,
    required this.image,
  });
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    int selectedLevel = 0;

    return BlocBuilder<SubjectBloc, SubjectState>(
      builder: (context, state) {
        if (state is GetAllSubjectsLoading) {
          return Container(
            height: 50,
            width: MediaQuery.sizeOf(context).width,
            padding: const EdgeInsets.all(5),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(6, (e) {
                return ShimmerContainer(
                  child: Container(
                    width: 80,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        } else if (state is GetAllSubjectsFailure) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is GetAllSubjectsSuccess) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 800,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.subject.length,
                  itemBuilder: (context, index) {
                    final subject = state.subject[index];

                    // Define background color and icon for each subject
                    Color backgroundColor = AppColors.primary;
                    IconData subjectIcon = Icons.help_outline; // Default icon

                    // Assign icons and colors based on subject
                    switch (subject.title.toLowerCase()) {
                      case 'mathematics':
                        backgroundColor = Colors.blue;
                        subjectIcon = Icons.calculate;
                        break;
                      case 'science':
                        backgroundColor = Colors.green;
                        subjectIcon = Icons.science;
                        break;
                      case 'history':
                        backgroundColor = Colors.brown;
                        subjectIcon = Icons.history;
                        break;
                      case 'language':
                        backgroundColor = Colors.red;
                        subjectIcon = Icons.language;
                        break;
                      case 'physics':
                        backgroundColor = Colors.pink;
                        subjectIcon = Icons.device_hub_outlined;
                        break;
                      case 'english':
                        backgroundColor = Colors.green;
                        subjectIcon = Icons.language;
                        break;
                      case 'ict':
                        backgroundColor = Colors.amberAccent;
                        subjectIcon = Icons.devices_other_rounded;
                        break;
                      default:
                        backgroundColor = AppColors.primary; // Default color
                        subjectIcon = Icons.book;
                    }

                    return InkWell(
                        onTap: () {
                          selectedLevel = subject.id;
                          print(selectedLevel);
                        },
                        child: Column(
                          children: [
                            Card(
                              child: Container(

                                  padding: const EdgeInsets.all(18),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: backgroundColor,
                                        child: Icon(subjectIcon,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Text(
                                        subject.title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
