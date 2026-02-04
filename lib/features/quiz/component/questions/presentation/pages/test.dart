import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mystudy/features/quiz/component/answers/data/models/answer_model.dart';

@RoutePage()
class CreateQuestionForm extends StatefulWidget {
  const CreateQuestionForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateQuestionFormState createState() => _CreateQuestionFormState();
}

class _CreateQuestionFormState extends State<CreateQuestionForm> {
  final _formKey = GlobalKey<FormState>();
  
  // Champs pour la question
  String content = '';
  String type = 'multiple_choice';
  String level = 'easy';
  String duration = '00:02:00';
  int? teacherId;

  // Liste des réponses
  List<AnswerModel> answers = [];
  
  // Champs temporaires pour la réponse en cours d'ajout
  String answerContent = '';
  bool isTrue = false;

  // Fonction pour ajouter une réponse à la liste des réponses
  void addAnswer() {
    setState(() {
      answers.add(AnswerModel( content: answerContent, isTrue: isTrue));
      answerContent = '';
      isTrue = false;
    });
  }

  // Fonction pour soumettre le formulaire
  void submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Création de l'objet QuestionModel
      // final question = QuestionModel(
      //   id: DateTime.now().millisecondsSinceEpoch,
      //   content: content,
      //   type: type,
      //   level: level,
      //   duration: duration,
      //   teacherId: teacherId,
      //   // answers: answers,
      // );

      // Utilisez votre service pour ajouter la question et les réponses
      // final questionService = QuestionService(QuestionRepository(), AnswerService());
      // await questionService.createQuestionWithAnswers(question, answers);

      // Afficher un message de succès
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Question et réponses créées avec succès!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Créer une Question')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Champ de contenu de la question
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contenu de la question'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le contenu de la question';
                  }
                  return null;
                },
                onSaved: (value) => content = value!,
              ),
              // Champ de type de question
              DropdownButtonFormField<String>(
                initialValue: type,
                items: ['multiple_choice', 'true_false'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() => type = newValue!),
                decoration: const InputDecoration(labelText: 'Type de question'),
              ),
              // Champ de niveau de question
              DropdownButtonFormField<String>(
                initialValue: level,
                items: ['easy', 'medium', 'hard'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) => setState(() => level = newValue!),
                decoration: const InputDecoration(labelText: 'Niveau de difficulté'),
              ),
              // Champ de durée
              TextFormField(
                decoration: const InputDecoration(labelText: 'Durée (format: HH:MM:SS)'),
                initialValue: duration,
                onSaved: (value) => duration = value!,
              ),
              const SizedBox(height: 16.0),
              
              // Section pour ajouter une réponse
              const Text('Ajouter une réponse', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contenu de la réponse'),
                onChanged: (value) => answerContent = value,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isTrue,
                    onChanged: (value) => setState(() => isTrue = value!),
                  ),
                  const Text('Est-ce la bonne réponse?')
                ],
              ),
              ElevatedButton(
                onPressed: addAnswer,
                child: const Text('Ajouter cette réponse'),
              ),
              
              const SizedBox(height: 16.0),
              
              // Affichage de la liste des réponses ajoutées
              const Text('Réponses ajoutées:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...answers.map((answer) => ListTile(
                title: Text(answer.content),
                trailing: answer.isTrue ? const Icon(Icons.check, color: Colors.green) : null,
              )),
              
              const SizedBox(height: 16.0),
              
              // Bouton pour soumettre le formulaire
              Center(
                child: ElevatedButton(
                  onPressed: submitForm,
                  child: const Text('Créer la question avec les réponses'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
