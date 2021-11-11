import 'package:flutter/material.dart';
import 'package:food_nutrition/components/input_widget.dart';
import 'package:food_nutrition/components/start_button.dart';
import 'package:food_nutrition/components/reusable_card.dart';
import 'package:food_nutrition/nutrition_fact_calls.dart' as nutrition_fact;
import 'package:flutter_html/flutter_html.dart';
import 'package:food_nutrition/screens/selection_page.dart';
import 'package:food_nutrition/screens/no_internet_page.dart';
import 'package:connectivity/connectivity.dart';


class FoodPage extends StatefulWidget {
  const FoodPage({ Key? key, required this.url, required this.title}) : super(key: key);

  final String url;
  final String title;

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final myController = TextEditingController();
  late Future<nutrition_fact.NutritionFact> futureNutritionFact;

  bool _validate = true;

  @override
  void initState(){
    
    super.initState();
    futureNutritionFact = nutrition_fact.getNutritionFact(widget.url);
  }

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
      
      body: SafeArea(
        child: Column(    
          children:[
            const SizedBox(height: 15,),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize:20,color: Colors.green)
            ),




            FutureBuilder<nutrition_fact.NutritionFact>(
              future: futureNutritionFact,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                        child: Column(
                          children: [
                            !(snapshot.data!.food_imgurl == "None")? 
                            Expanded(
                              child:Image(
                                image:NetworkImage(snapshot.data!.food_imgurl),
                              ) 
                            )
                            :
                            const Text(""),
                            Expanded(
                              flex: 7,
                              child: ReusableCard(
                                colour: Colors.white,
                                cardChild: ListView(
                                  children: [
                                    
                                    
                                    // palitan mo pa to boi
                                    ReusableCard(colour: const Color(0xFFD6D6D6),
                                    cardChild: Html(
                                      data: snapshot.data!.table,
                                      shrinkWrap: true,
                                      ), 
                                    ),
                            
                                    
                                    for ( var graph in snapshot.data!.graphs )
                                    ReusableCard(
                                      colour: const Color(0xFFD6D6D6),//i%2 == 0? Colors.white: Colors.green, 
                                      cardChild: Image(
                                        image: NetworkImage(graph),
                                      )
                                    ),
                              
                                  ],
                                ),
                              ),
                            )
                          ]
                        ),
                      );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Text("Loading..."),
                      SizedBox(height: 15,),
                      CircularProgressIndicator(),
                    ],
                    )
                  );
              },
            ),



            const SizedBox(height: 15,),
            MyInputWidget(label: "Search another food", controller: myController, valid: _validate,),
            
            
            StartButton(onTap: ()async{
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
                  }else{
                    setState(() {
                      _validate = false;
                    });
                  }

                }else{
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
              
            }, buttonTitle: "Search",)
          ] 
        ),
      ),
      
    );
  }
}