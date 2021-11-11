import 'package:flutter/material.dart';
import 'package:food_nutrition/components/input_widget.dart';
import 'package:food_nutrition/screens/selection_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:food_nutrition/screens/no_internet_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final myController = TextEditingController();
  bool _validate = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text(
              'FOOD NUTRITION',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize:20,color: Colors.green)
            ),
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("images/apple.jpg"),
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10.0),
              child: Text(
                'Start monitoring your food intake',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                // style: TextStyle( fontSize: 15),
              ),
            ),

            MyInputWidget(label: "Enter Food", controller: myController, valid: _validate ),
            
            const SizedBox(height:10),

            ElevatedButton(
              child: Padding(padding: const EdgeInsets.all(15),
              child: Text(
                  "Search".toUpperCase(),
                  style: const TextStyle(fontSize: 16.0)
                ),
              ),
              
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: const BorderSide(color: Colors.greenAccent)
                  )
                )
              ),
              onPressed: ()async {
                try{
                  var connectivityResult = await (Connectivity().checkConnectivity());
                  if (connectivityResult==ConnectivityResult.mobile ||  connectivityResult == ConnectivityResult.wifi){
                    if(myController.text.length > 2){
                      setState(() {
                        _validate = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectionPage(food: myController.text),
                        ),
                      );
                    }
                    else{
                      setState(() {
                        _validate = false;
                      });
                    }
                  }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NoInternetPage(),
                      ),
                    );
                  }
                }catch(e){
                  print(e);
                }
                
              }
            ),
          ],
        ),
      ),
      
    );
  }
}