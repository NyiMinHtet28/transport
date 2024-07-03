import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:public_transport/addedlocation.dart';
import 'package:public_transport/singup.dart';
import 'package:public_transport/transport.dart';
class navbar extends StatelessWidget {
  const navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer( 
      child: ListView(         
        children: [           
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(), 
            icon: Icon(Icons.arrow_back,
            color: Colors.black,),
             label: Text( "   Profile",
            style: TextStyle( fontSize: 20,
            color: Colors.black) ,),
            style: ElevatedButton.styleFrom( 
              elevation: 30,
              alignment: Alignment.topLeft
            ),
           ),
            Container(
              width: 250, // Adjust as needed
              height: 250, // Adjust as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'), // Path to your image asset
                  fit: BoxFit.contain, // Adjust as needed
                ),
              ),
            ),
           Container( 
            
            height:150,
            child:        
          UserAccountsDrawerHeader(accountName: const Text( "Nyi Min Htet"), accountEmail: const Text("nyimnhtet282024@gmail.com"),
          currentAccountPicture: CircleAvatar(             
            child: ClipOval(child: Icon(Icons.person,
            size:20,            
            ))
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 168, 209, 209), 
          ),      
          ),
           ),
          ListTile( 
            leading: Icon(Icons.history,
            color: Color.fromARGB(255, 21, 88, 128),),
            title: Text('History'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>BusDirectoryApp()));
              Get.to(BusSearchPage());          // Handle onTap
            },
            
          ),
          
        
          ListTile(             
            leading: Icon(Icons.logout,
            color: Color.fromARGB(255, 56, 137, 161),),
            title: Text('Home Page'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => TransportHomePage()));
              Get.to(TransportHomePage());  
            },     
         ),
          ListTile(             
            leading: Icon(Icons.logout,
            color: Color.fromARGB(255, 56, 137, 161),),
            title: Text('Log Out'),
            onTap: () {
              //Navigator.push(context, MaterialPageRoute(builder: (context) => Sign()));
              Get.to(MyStatefulWidget());  
            },     
         ),
        ],
      )
    );
  }
}