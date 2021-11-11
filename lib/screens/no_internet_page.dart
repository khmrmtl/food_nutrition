import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('images/no-internet-icon.jpg'),  
              const Center(
                child: Text(  
                  'No internet Connection',  
                  style: TextStyle(fontSize: 20.0),  
                ) 
              )
          ],
        ),
      )
    );
  }
}