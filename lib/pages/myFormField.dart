import 'package:flutter/material.dart';
import 'package:flutter_application/pages/signupForm.dart';
import 'package:flutter_application/pages/simpleCounter.dart';

class MyFormField extends StatefulWidget {
  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter some text";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Processing data")));
                }
              },
              child: Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: ElevatedButton(
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute(builder: (context) => SimpleCounter()));
              },
              child: Text('Simple counter'),
            )
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignupForm()));
                },
                child: Text('Signup Form'),

              )
          ),
        ],
      ),
    );
  }
}
