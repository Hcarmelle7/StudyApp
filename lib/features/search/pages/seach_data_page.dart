import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/core/services/network/service_locator.dart';
import 'package:mystudy/features/subject/business_logic/subject_bloc/subject_bloc.dart';

import '../../subject/data/models/subject_model.dart';
import '../../../core/themes/colors/app_colors.dart';
import '../../../core/widgets/shimmer_container.dart';

@RoutePage()
class SeachDataPage extends StatefulWidget {
  const SeachDataPage({super.key});

  @override
  State<SeachDataPage> createState() => _SeachDataPageState();
}


class _SeachDataPageState extends State<SeachDataPage> {
    TextEditingController controller = TextEditingController();
    //final List<SubjectModel> _subject = [];
    int selectedLevel = 0;


    void init() async {
       getIt.get<SubjectBloc>().add(GetAllSubjectEvent());

    }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 231, 231),

        appBar: AppBar(
            elevation: 25,
            title: TextField(
                controller: controller,
                onChanged: (value) {
                    setState(() {
                    });
                },
                decoration: InputDecoration(
                    //fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search books, courses...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.search),
                ),
            ),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<SubjectBloc, SubjectState>(
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
                                          SubjectModel subject = state.subject[index];

                                          if(controller.text.trim().isEmpty) {
                                            return Container();
                                          }

                                          if(!subject.title.toLowerCase().contains(controller.text.toLowerCase())) {
                                            return Container();
                                          }
          
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
          ),
        )
    );
  }
}
