import 'dart:io';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:midterm_practice/main.dart';
import 'StorePage.dart'; 
import 'package:xml/xml.dart' as xml;

import 'dart:convert' as convert;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Midterm Practice',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Midterm Practice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> XMLoutput ;
  //TODO: Parse the XML output into a list of Store;

  @override
  void initState() {
    super.initState();
    XMLoutput = downloadXML();
  }



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        title: Text(widget.title),
      ),
      body: Center(
      
       child: FutureBuilder(
         future: XMLoutput,
         builder: (context,snapshot)
         {
           if(snapshot.hasData)
           {
             var XML_data = xml.parse(snapshot.data);
             var stores =XML_data.findAllElements('store');
             var all_addresses = XML_data.findAllElements('address');
             
             assert(all_addresses.length==stores.length);
             List<Store> my_list = new List();
             for(int i = 0;i<stores.length;i++)
             {
               var store = stores.elementAt(i);
               var address = all_addresses.elementAt(i);
               //print(address);
               //print(store);
               String  name = (store.getAttribute('name'));
             
               
               String distance = (store.getAttribute('distance'));
             
               String postalCode = (address.getAttribute('postalCode'));
               
              String street = (address.getAttribute('street'));
              String city = (address.getAttribute('city'));
              
               Store sample = new Store(name.toString(), street, city.toString(), postalCode.toString(), distance.toString()); 
               my_list.insert(i,sample);
            
             }
             var widget_list = my_list.map((node) => new StoreWidget(node,context));


             return ListView(
               
               children :(widget_list.map((widget ) => widget.MakeWidget()).toList()
               ));
             
           }
           else if(snapshot.hasError)
           {
             return Text("${snapshot.error}");
           }
            return CircularProgressIndicator();
         },
         
         )

                      
      )
    );
  }
}

class Store
{
  String name; 
  String address;
  String city;
  String postalCode;
  String phone; 

  Store(name,address,city,postalCode,phone)
  {
    this.name = name;
    this.address = address; 
    this.city = city;
    this.postalCode = postalCode; 
    this.phone = phone; 
  }

}

class StoreWidget
{
  Store store; 
  BuildContext context;
  StoreWidget(this.store,this.context); 

  Widget MakeWidget()
  {
    return new 
    GestureDetector(
    onTap: () {
        Navigator.push(context, 
        MaterialPageRoute<StorePage> (
          builder: (context) {
            return StorePage2(this.store); 
          } 
          )
        );
    },
    child: Container(
    
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
        padding: const EdgeInsets.all(8),
        child: Text(this.store.name,style: TextStyle(fontWeight: FontWeight.bold),)
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
            Padding(
            padding: const EdgeInsets.all(10),
            child: Text(this.store.address,style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),),
            ),
            Padding(
            padding:  const EdgeInsets.all(10),
            child: Text(this.store.city,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.normal),)
            ),
          
          ],

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
            padding: const EdgeInsets.all(10),
            child: Text(this.store.postalCode,style: TextStyle(color: Colors.grey),),
            ),
            Padding(
            padding:  const EdgeInsets.all(10),
            child:Text(this.store.phone,style: TextStyle(color: Colors.grey),)
            )
          ],
        )

      ],

    )));
  }
}

Future<String> downloadXML() async {

  String output;
  final String PATH = "http://csundergrad.science.uoit.ca/courses/csci4100u/assessments/store_locations.xml"; 
  
  try{
    var response = await http.get(PATH);
    var statuscode = response.statusCode;
    var body = response.body; 
    output = body.toString(); 
    return output;

  }catch(e)
  {
   print(e);
  }
  
}
class StorePage2 extends StatelessWidget
{
  Store store; 
  
  StorePage2(Store store, )
  {
    this.store = store; 
  }
  @override
  Widget build(BuildContext context) {
     TextStyle mine = TextStyle(color: Colors.black54,fontSize: 15);
     return new
     Scaffold(
      appBar: AppBar(
        title: Text('Store Page'),
      ),
      
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Name:",style: mine,),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.name,style: mine,),
                ),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Address:",style: mine,),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.address,style: mine,),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("City:",style: mine,),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.city,style: mine,),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Postal code:",style:  mine,),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.postalCode,style: mine,),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Phone:",style: mine,),

                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(this.store.phone,style: mine,),
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
     ));
  }
  
}
