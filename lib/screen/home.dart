import 'package:bloc_restapi_app/bloc/get/getcontact/getcontact_cubit.dart';
import 'package:bloc_restapi_app/bloc/get/getcontact/getcontact_state.dart';
import 'package:bloc_restapi_app/data/model/contact.dart';
import 'package:bloc_restapi_app/screen/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetcontactCubit>(context).getContact();
    return Scaffold(
      appBar: AppBar(title: Text("Contact List")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddScreen()),
          );
          if (result != null && result == 'success') {
            BlocProvider.of<GetcontactCubit>(context).getContact();
          }
        },
      ),
      body: BlocBuilder<GetcontactCubit, GetcontactState>(
        builder: (context, state) {
          if (state is GetContactSuccess) {
            List<Contact> contacts = state.contacts;
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, position) {
                return item(contacts[position]);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget item(Contact contact) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          title: Text(contact.name.toString()),
          subtitle: Text(contact.job.toString()),
          trailing: Text("age : " + contact.age.toString()),
        ),
      ),
    );
  }
}
