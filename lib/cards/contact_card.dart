import 'package:flutter/material.dart';

import '../helpers/contact_helper.dart';
import '../ui/contact_page.dart';


class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.contact});

  final Contact contact;
 
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactPage(
                contact: contact,
              ),
            ),
          );
        },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:
                      DecorationImage(image: AssetImage("images/person.png")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        contact.name ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        contact.email ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                        contact.phone ?? "",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }  
}
