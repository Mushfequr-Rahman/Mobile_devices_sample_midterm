

import 'package:flutter/material.dart' show AppBar, BuildContext, Colors, Column, Container, EdgeInsets, FlatButton, Key, MainAxisAlignment, Navigator, Padding, Row, Scaffold, State, StatefulWidget, Text, Widget;
import 'package:flutter/src/widgets/framework.dart';

import 'main.dart';




class StorePage extends StatefulWidget
{
  StorePage(BuildContext context, {Key key,this.store}): super(key: key);
  final Store store;

  @override
  State<StatefulWidget> createState() {
    _StorePageState createState() => _StorePageState();
    return null;
  }
  
}

class _StorePageState extends State<StorePage> 
{
  Store store = new Store("dslkfd", "dnlf", "dklf", "kldmsjv", "jdsnd"); 
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Page')
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Name:"),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.name),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Address:"),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.address),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("City:"),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.city),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Postal code:"),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.postalCode),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Phone:"),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.phone),
                ),
                
              ],
            ),
            FlatButton(
              child: Text("Close"),
              color: Colors.grey,
              onPressed: ()
              {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );

  }
  
}