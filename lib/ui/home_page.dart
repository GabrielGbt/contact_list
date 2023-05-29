import 'package:contact_list/helpers/contact_helper.dart';
import 'package:contact_list/ui/contact_page.dart';
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

    /* Contact c = Contact();
    c.name = "nerd";
    c.email = "nerd@gmail.com";
    c.phone = "555-444-222";
    c.img = "";

    helper.saveContact(c); */

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showContactPage(contact: Contact());
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.add),
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

  void showContactPage({required Contact contact}) async {
    final recContact = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactPage()));
    if (recContact != null) {
      // ignore: unnecessary_null_comparison
      if (contact != null) {
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
        _getAllContacts();
      }
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        contactList = list as List<Contact>;
      });
    });
  }
}
