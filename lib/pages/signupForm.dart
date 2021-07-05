import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application/widgets/formFields/MultiSelectionFormField.dart';
import 'package:flutter_application/widgets/formFields/dateFormField.dart';
import 'package:flutter_application/widgets/formFields/switchFormField.dart';
import 'package:flutter_application/widgets/formFields/toggleButtonFormField.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter your name", labelText: "Name"),
                inputFormatters: [LengthLimitingTextInputFormatter(30)],
                initialValue: _formResult.name,
                validator: (userName) {
                  if (userName!.isEmpty) {
                    return "Name is required";
                  }
                  if (userName.length < 3) {
                    return "Name is too short";
                  }
                  return null;
                },
                onSaved: (userName) {
                  _formResult.name = userName;
                },
                focusNode: nameFocusNode,
                textInputAction: TextInputAction.next,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(nameFocusNode);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              ToggleButtonFormField(
                decoration: InputDecoration(labelText: "Gender"),
                initialValue: _formResult.gender,
                items: Gender.values,
                itemBuilder: (BuildContext context, Gender genderItem) =>
                    Text(describeEnum(genderItem)),
                selectedItemBuilder:
                    (BuildContext context, Gender genderItem) =>
                        Text(describeEnum(genderItem), style: TextStyle(fontWeight: FontWeight.bold),),
                validator: (gender) =>
                    gender == null ? "Gender is required" : null,
                onSaved: (Gender? gender) {
                  _formResult.gender = gender;
                },
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                focusNodes: genderFocusNodes,
                onChanged: (gender) {
                  final genderIndex = Gender.values.indexOf(gender as Gender);
                  if (genderIndex >= 0) {
                    FocusScope.of(context).unfocus();
                    FocusScope.of(context).requestFocus(genderFocusNodes[genderIndex]);
                  }
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              DateFormField(
                decoration: InputDecoration(
                  labelText: "Birthdate"
                ),
                validator: (birthdate) {
                  if (birthdate == null) {
                    return "A valid birthdate is required";
                  }
                  final now = DateTime.now();
                  if (birthdate.isAfter(now)) {
                    return "You are not born yet!";
                  }
                  const MAX_AGE = 99;
                  if (birthdate.isBefore(now.subtract(Duration(days: 365 * MAX_AGE)))) {
                    return "Select a more recent date";
                  }
                  const MIN_AGE = 18;
                  if (birthdate.isAfter(now.subtract(Duration(days: 365 * MIN_AGE)))) {
                    return "Only adults are allowed";
                  }
                  return null;
                },
                onSaved: (birthdate) {
                  _formResult.birthdate = birthdate;
                },
                dayFocusNode: birthdateFocusNodes[0],
                dayOnTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(birthdateFocusNodes[0]);
                },
                monthFocusNode: birthdateFocusNodes[1],
                monthOnTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(birthdateFocusNodes[1]);
                },
                yearFocusNode: birthdateFocusNodes[2],
                yearOnTap: () {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(birthdateFocusNodes[2]);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              MultiSelectionFormField(
                decoration: InputDecoration(
                  labelText: "Interests"
                ),
                hint: Text('Select more interests'),
                isDense: true,
                focusNode: interestsFocusNode,
                options: Interest.values,
                titleBuilder: (interest) => Text(describeEnum(interest!)),
                chipLabelBuilder: (interest) => Text(describeEnum(interest!)),
                initialValues: _formResult.interests,
                validator: (interests) => interests!.length < 3 ? "Please select at least 3 interests" : null,
                onSaved: (interests) {
                  _formResult.interests = interests as List<Interest>;
                },
                onChanged: (_) {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(interestsFocusNode);
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              SwitchFormField(
                decoration: InputDecoration(
                    labelText: "Ethics agreement", hintText: null),
                focusNode: ethicsAgreementFocusNode,
                initialValue: _formResult.ethicsAgreement,
                validator: (agree) =>
                    agree == false ? "Please agree with ethics" : null,
                onSaved: (agree) {
                  _formResult.ethicsAgreement = agree;
                },
                onChanged: (_) {
                  FocusScope.of(context).unfocus();
                  FocusScope.of(context).requestFocus(ethicsAgreementFocusNode);
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        tooltip: 'Save',
        child: Icon(
          Icons.save,
          size: 36.0,
        ),
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
