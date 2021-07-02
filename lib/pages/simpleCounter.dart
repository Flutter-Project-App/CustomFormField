import 'dart:developer';

import 'package:flutter/material.dart';

class SimpleCounter extends StatefulWidget {
  @override
  _SimpleCounterState createState() => _SimpleCounterState();
}

class _SimpleCounterState extends State<SimpleCounter> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Simple Counter')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: <Widget>[
                Text("Please fill in your name and age"),
                TextFormField(
                  autovalidate: false,
                  onSaved: (value) => this._name = value,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "a minimum of 3 characters is required";
                    }
                  },
                ),
                CounterFormField(
                    onSaved: (value) => this._age = value,
                    autovalidate: false,
                    validator: (value) {
                      if (value! < 0) {
                        return 'Negative values not supported';
                      }
                    }),
                RaisedButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if (this._formKey.currentState!.validate()) {
                        setState(() {
                          this._formKey.currentState?.save();
                        });
                      }
                    }),
                SizedBox(
                  height: 50.0,
                ),
                Text("$_name is $_age years old")
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
            onPressed: () {
              setState(() {
                value--;
              });
            },
            icon: Icon(Icons.remove)),
        Text(value.toString()),
        IconButton(
            onPressed: () {
              setState(() {
                value++;
              });
            },
            icon: Icon(Icons.add))
      ],
    );
  }
}

class CounterFormField extends FormField<int> {
  CounterFormField(
      {required FormFieldSetter<int> onSaved,
      required FormFieldValidator<int> validator,
      int initialValue = 0,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<int> state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        if (state.value! <= 0) {
                          state.setValue(1);
                        }
                        state.didChange(state.value! - 1);
                      },
                      icon: Icon(Icons.remove)),
                  Text(state.value.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      state.didChange(state.value! + 1);
                    },
                  )
                ],
              );
            });
}
