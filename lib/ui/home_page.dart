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
  //this is to test the database
  void initState() {
    super.initState();
    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showContactPage(contact: Contact());
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: helper.getAllContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                return ContactCard(
                  contact: contactList[index],
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void showContactPage({required Contact contact}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(),
      ),
    );

    await _getAllContacts();
  }

  Future _getAllContacts() async {
    final list = await helper.getAllContacts();
    setState(() {
      contactList = list;
    });
  }
}
