import 'dart:ui';

import 'package:easy_opener/easy_opener.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyOpener(
      child: Icon(Icons.app_registration),
      onComplete: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => RegisterPage(),
        ),
        (route) => false,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      context: context,
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  PetType? _petType;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final questionResponses = List.generate(3, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Colors.lightBlueAccent,
          ]),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PET HOTEL',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Icon(
                          Icons.pets,
                        )
                      ],
                    ),
                    Text(
                      'Welcome to Pet Hotel! Please give some details about your furry or spikey friend below, and we\'ll be able to check you in.',
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          onChanged: () {},
                          child: Column(
                            children: [
                              TextFormField(
                                decoration: InputDecoration(hintText: 'First Name'),
                                controller: firstName,
                              ),
                              TextFormField(
                                decoration: InputDecoration(hintText: 'Last Name'),
                                controller: lastName,
                              ),
                              TextFormField(
                                decoration: InputDecoration(hintText: 'Phone number'),
                                autovalidateMode: AutovalidateMode.always,
                                validator: (val) {
                                  if (val == null || val == "") {
                                    return 'Please enter a phone number';
                                  }
                                  if (int.tryParse(val) == null) {
                                    return 'Only enter numbers in the phone number field';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('What kind of pet do you have?'),
                              ),
                              RadioListTile<PetType>(
                                value: PetType.cat,
                                groupValue: _petType,
                                onChanged: (val) => setState(() {
                                  for (final controller in questionResponses) {
                                    controller.clear();
                                  }
                                  _petType = val;
                                }),
                                title: Text('Cat'),
                              ),
                              RadioListTile<PetType>(
                                value: PetType.dog,
                                groupValue: _petType,
                                onChanged: (val) => setState(() {
                                  for (final controller in questionResponses) {
                                    controller.clear();
                                  }
                                  _petType = val;
                                }),
                                title: Text('Dog'),
                              ),
                              RadioListTile<PetType>(
                                value: PetType.echidna,
                                groupValue: _petType,
                                onChanged: (val) => setState(() {
                                  for (final controller in questionResponses) {
                                    controller.clear();
                                  }
                                  _petType = val;
                                }),
                                title: Text('Echnidna'),
                              ),
                              Builder(
                                builder: (context) {
                                  switch (_petType) {
                                    case PetType.cat:
                                      return Column(
                                        children: [
                                          Text("Aw, it's a cat!"),
                                          PetQuestionField(question: 'Can we pat the cat?', controller: questionResponses[0]),
                                          PetQuestionField(question: 'Can we put a little outfit on it?', controller: questionResponses[1]),
                                          PetQuestionField(question: 'Does it like to jump in boxes?', controller: questionResponses[2]),
                                        ],
                                      );

                                    case PetType.dog:
                                      return Column(
                                        children: [
                                          Text("Yay, a puppy! What's its details?"),
                                          PetQuestionField(question: 'Can we wash your dog?', controller: questionResponses[0]),
                                          PetQuestionField(question: 'What is your dogs favourite treat?', controller: questionResponses[1]),
                                          PetQuestionField(question: 'Is your dog okay with other dogs?', controller: questionResponses[2]),
                                        ],
                                      );

                                    case PetType.echidna:
                                      return Column(
                                        children: [
                                          Text("It's a small spiky boi. Can you fill us in on some of the details?"),
                                          PetQuestionField(question: 'How spikey is the echidna?', controller: questionResponses[0]),
                                          PetQuestionField(question: 'Can we read the echidna a story?', controller: questionResponses[1]),
                                          PetQuestionField(question: 'Does it like leafy greens?', controller: questionResponses[2]),
                                        ],
                                      );
                                    case null:
                                      {
                                        return Text('Please choose your pet type from above');
                                      }
                                  }
                                },
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    final valid = (_formKey.currentState?.validate() ?? false) && _petType != null;
                                    if (!valid) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => SimpleDialog(
                                                contentPadding: EdgeInsets.all(20),
                                                title: Text('Please check the form'),
                                                children: [Text('Some details are missing or incorrect. Please check the details and try again.')],
                                              ));
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          contentPadding: EdgeInsets.all(20),
                                          title: Text("All done!"),
                                          children: [
                                            Text(
                                              "Thanks for all the details! We're going to check your pet in with the following details.",
                                              style: Theme.of(context).textTheme.caption,
                                            ),
                                            Card(
                                              child: Column(
                                                children: [
                                                  Text('First name: ${firstName.text}'),
                                                  Text('Last name: ${lastName.text}\r\n'),
                                                  Text('Pet type: ${_petType}'),
                                                  Text('Response 1: ${questionResponses[0].text}'),
                                                  Text('Response 2: ${questionResponses[1].text}'),
                                                  Text('Response 3: ${questionResponses[2].text}'),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: Text('REGISTER'))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PetQuestionField extends StatelessWidget {
  final String question;
  final TextEditingController controller;

  const PetQuestionField({
    Key? key,
    required final this.question,
    required final this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: question),
      controller: controller,
      validator: (val) => val?.isNotEmpty ?? false ? null : 'Required answer',
    );
  }
}

enum PetType {
  cat,
  dog,
  echidna,
}
