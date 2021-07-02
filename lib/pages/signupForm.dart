import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

enum Gender { Male, Female, Other }

enum Interest {
  Sports,
  Tech,
  Games,
  Mentoring,
  Travel,
  Art,
  Music,
  Cooking,
  Blogging
}

class SignUpUser {
  late String? name;
  late Gender? gender;
  late DateTime? birthdate;
  late List<Interest> interests;
  late bool? ethicsAgreement;

  SignUpUser(
      {this.name,
      this.gender,
      this.birthdate,
      List<Interest>? interests,
      this.ethicsAgreement = false}) {
    this.interests = interests ?? [];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'gender': gender.toString(),
        'birthdate': birthdate.toString(),
        'interests': interests.toString(),
        'ethicsAgreement': ethicsAgreement,
      };
}

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);
  final String title = 'Signup Form';

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _formResult = SignUpUser();

  final nameFocusNode = FocusNode();
  final genderFocusNodes = [FocusNode(), FocusNode(), FocusNode()];
  final birthdateFocusNodes = [FocusNode(), FocusNode(), FocusNode()];
  final interestsFocusNode = FocusNode();
  final ethicsAgreementFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: false,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: <Widget>[

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: 'Save',
        child: Icon(Icons.save, size: 36.0,),
      ),
    );
  }

  void _submitForm() {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      print("New user saved with sign up data");
      print(_formResult.toJson());
    }
  }
}

// class TextFormField extends FormField<String> {
// //   TextFormField({
// //     Key key,
// //     this.controller,
// //     FocusNode focusNode,
// //     Input
// //
// // })
//   TextFormField({this.controller,
//   Key? key,
//   InputDecoration decoration = const InputDecoration(),
//       ValueChanged<String> onChanged,) : super(key: key, builder: (FormFieldState<String> field) {
//   final _TextFormFieldState state = field;
//   final InputDecoration effectiveDecoration = (decoration ?? const InputDecoration())
//       .applyDefaults(Theme.of(field.context).inputDecorationTheme);
//   void onChangedHandler(String value) {
//     if (onChanged != null) {
//       onChanged(value);
//     }
//     if (field.hasError) {
//       field.validate();
//     }
//     field.didChange(value);
//   }
//   return TextField(
//
//   );
//   }});
//
//   final TextEditingController controller;
//
//   @override
//   _TextFormFieldState createState() => _TextFormFieldState();
// }
//
// class _TextFormFieldState extends FormFieldState<String> {
//
// }
