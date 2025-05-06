import 'package:bloc_restapi_app/bloc/post/post_contact/post_contact_cubit.dart';
import 'package:bloc_restapi_app/bloc/post/post_contact/post_contact_state.dart';
import 'package:bloc_restapi_app/data/model/contact.dart';
import 'package:bloc_restapi_app/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostContactCubit>(
      create: (context) => PostContactCubit(getIt.call()),
      child: Scaffold(
        appBar: AppBar(title: Text("Add Contact")),
        body: BlocBuilder<PostContactCubit, PostContactState>(
          builder: (context, state) {
            if (state is PostContactLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PostContactSuccess) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Success'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, 'success');
                      },
                      child: Text('Go Home'),
                    ),
                  ],
                ),
              );
            } else if (state is PostContactFail) {
              return Center(child: Text(state.error));
            }
            return ContactForm();
          },
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _age, _job;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(8),
        children: [
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Name';
              }
            },
            onSaved: (value) {
              this._name = value;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Age',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Age';
              }
            },
            onSaved: (value) {
              this._age = value;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Job',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please Enter Job';
              }
            },
            onSaved: (value) {
              this._job = value;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Contact contact = Contact(null, _name, _job, _age);
                //context.bloc<PostContactCubit>().addContact(contact);
                BlocProvider.of<PostContactCubit>(context).addContact(contact);
              }
            },
            child: Text('Add Contact'),
          ),
        ],
      ),
    );
  }
}
