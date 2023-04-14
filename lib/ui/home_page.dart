import 'package:contact_list/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

import '../cards/contact_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contactList = [];

  @override
  void initState() {
    super.initState();

    helper.getAllContacts().then((list) {
      print(list);
      setState(() {
        contactList = list as List<Contact>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return ContactCard(
            contact: contactList[index],
          );
        },
      ),
    );
  }
}
