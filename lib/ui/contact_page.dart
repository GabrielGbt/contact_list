import 'package:flutter/material.dart';
import 'package:contact_list/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  final Contact? contact;

  const ContactPage({super.key, this.contact});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  bool userEdited = false;

  late Contact _editedContact;

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());

      _nameController.text = _editedContact.name!;
      _emailController.text = _editedContact.email!;
      _phoneController.text = _editedContact.phone!;
    }
    print(_editedContact.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(_editedContact.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_nameController.text == null || _nameController.text.isEmpty) {
            Navigator.pop(context);
          } else {
            ContactHelper ch = ContactHelper();
            _editedContact.name = _nameController.text;
            _editedContact.phone = _phoneController.text;
            _editedContact.email = _emailController.text;
            if (widget.contact != null) {
              ch.updateContact(_editedContact);
              Navigator.pop(context);
            } else {
              ch.saveContact(_editedContact);
              Navigator.pop(context);
            }
          }
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage("images/person.png")),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _nameController,
              focusNode: _nameFocus,
              decoration:
                  InputDecoration(border: InputBorder.none, labelText: "Nome"),
              onChanged: (text) {
                userEdited = true;
                setState(() {
                  _editedContact.name = text;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(border: InputBorder.none, labelText: "Email"),
              onChanged: (text) {
                userEdited = true;
                _editedContact.email = text;
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration:
                  InputDecoration(border: InputBorder.none, labelText: "Phone"),
              onChanged: (text) {
                userEdited = true;
                _editedContact.phone = text;
              },
            ),
          ],
        ),
      ),
    );
  }
}
