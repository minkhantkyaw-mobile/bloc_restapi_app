import 'package:bloc_restapi_app/bloc/get/getcontact/getcontact_cubit.dart';
import 'package:bloc_restapi_app/bloc/get/getcontact/getcontact_state.dart';
import 'package:bloc_restapi_app/data/model/contact.dart';
import 'package:bloc_restapi_app/screen/add_screen.dart';
import 'package:bloc_restapi_app/screen/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetcontactCubit>(
      context,
    ).getContact(); //screenလာလာချင်း dataလမ်းယူမယ်
    return Scaffold(
      appBar: AppBar(title: Text('Contact List')),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var result = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => AddScreen()));
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
                return item(contacts[position], context);
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget item(Contact contact, BuildContext context) {
    return InkWell(
      onTap: () async {
        var result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EditScreen(contact)),
        );
        if (result != null && result == 'success') {
          BlocProvider.of<GetcontactCubit>(context).getContact();
        }
      },
      child: Card(
        child: Slidable(
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              // SlidableAction(
              //   flex: 1,
              //   onPressed: (context) async {
              //     var result = await Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (_) => EditScreen(contact)),
              //     );
              //     if (result != null && result == 'success') {
              //       BlocProvider.of<GetcontactCubit>(context).getContact();
              //     }
              //   },
              //   backgroundColor: Colors.blueAccent,
              //   foregroundColor: Colors.white,
              //   icon: Icons.edit,
              //   label: 'Edit',
              // ),
              SlidableAction(
                flex: 1,
                onPressed: (BuildContext context) {
                  BlocProvider.of<GetcontactCubit>(
                    context,
                  ).delete(contact.id.toString());
                },
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.job),
            trailing: Text('age : ${contact.age}'),
          ),
        ),
      ),
    );
  }
}
