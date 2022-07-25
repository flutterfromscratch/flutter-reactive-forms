import 'dart:async';
import 'dart:ui';

import 'package:easy_opener/easy_opener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
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
  final _fbKey = GlobalKey<FormBuilderState>();
  PetType? _petType;

  final String FIRST_NAME = 'FirstName';
  final String LAST_NAME = 'LastName';
  final String PHONE_NUMBER = 'PhoneNumber';
  final String PET_CHOICE = 'PetChoice';
  final String QUESTION_ANSWER_1 = 'QuestionAnswer1';
  final String QUESTION_ANSWER_2 = 'QuestionAnswer2';
  final String QUESTION_ANSWER_3 = 'QuestionAnswer3';

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
                child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: FIRST_NAME,
                            decoration: InputDecoration(labelText: 'First Name'),
                            validator: FormBuilderValidators.required(),
                          ),
                          FormBuilderTextField(
                            name: LAST_NAME,
                            decoration: InputDecoration(labelText: 'Last Name'),
                            validator: FormBuilderValidators.required(),
                          ),
                          FormBuilderTextField(
                            name: PHONE_NUMBER,
                            validator: FormBuilderValidators.numeric(),
                            decoration: InputDecoration(labelText: 'Phone number'),
                            autovalidateMode: AutovalidateMode.always,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('What kind of pet do you have?'),
                          ),
                          FormBuilderRadioGroup<PetType>(
                            onChanged: (val) {
                              print(val);
                              setState(() {
                                _petType = val;
                              });
                            },
                            name: PET_CHOICE,
                            validator: FormBuilderValidators.required(),
                            orientation: OptionsOrientation.vertical,
                            options: [
                              ...PetType.values.map(
                                (e) => FormBuilderFieldOption(
                                  value: e,
                                  child: Text(
                                    describeEnum(e).replaceFirst(
                                      describeEnum(e)[0],
                                      describeEnum(e)[0].toUpperCase(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            wrapDirection: Axis.vertical,
                          ),
                          Builder(
                            builder: (context) {
                              switch (_petType) {
                                case PetType.cat:
                                  return Column(
                                    children: [
                                      Text("Aw, it's a cat!"),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_1,
                                        decoration: InputDecoration(labelText: 'Can we pat the cat?'),
                                      ),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_2,
                                        decoration: InputDecoration(labelText: 'Can we put a little outfit on it?'),
                                      ),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_3,
                                        decoration: InputDecoration(labelText: 'Does it like to jump in boxes?'),
                                      ),
                                    ],
                                  );

                                case PetType.dog:
                                  return Column(
                                    children: [
                                      Text("Yay, a puppy! What's its details?"),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_1,
                                        decoration: InputDecoration(labelText: 'Can we wash your dog?'),
                                      ),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_2,
                                        decoration: InputDecoration(labelText: 'What is your dogs favourite treat?'),
                                      ),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_3,
                                        decoration: InputDecoration(labelText: 'Is your dog okay with other dogs?'),
                                      ),
                                    ],
                                  );

                                case PetType.echidna:
                                  return Column(
                                    children: [
                                      Text("It's a small spiky boi. Can you fill us in on some of the details?"),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_1,
                                        decoration: InputDecoration(labelText: 'How spikey is the echidna?'),
                                      ),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_2,
                                        decoration: InputDecoration(labelText: 'Can we read the echidna a story?'),
                                      ),
                                      FormBuilderTextField(
                                        name: QUESTION_ANSWER_3,
                                        decoration: InputDecoration(labelText: 'Does it like leafy greens?'),
                                      ),
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
                                final valid = _fbKey.currentState?.saveAndValidate() ?? false;
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
                                              Text('First name: ${_fbKey.currentState!.value[FIRST_NAME]}'),
                                              Text('Last name: ${_fbKey.currentState!.value[LAST_NAME]}'),
                                              Text('Number: ${_fbKey.currentState!.value[PHONE_NUMBER]}'),
                                              Text('Pet type: ${_fbKey.currentState!.value[PET_CHOICE]}'),
                                              Text('Response 1: ${_fbKey.currentState!.value[QUESTION_ANSWER_1]}'),
                                              Text('Response 2: ${_fbKey.currentState!.value[QUESTION_ANSWER_2]}'),
                                              Text('Response 3: ${_fbKey.currentState!.value[QUESTION_ANSWER_3]}'),
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
                ]),
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
