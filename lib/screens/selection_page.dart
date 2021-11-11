import 'package:flutter/material.dart';
import 'package:food_nutrition/nutrition_fact_calls.dart' ;
import 'package:food_nutrition/screens/food_page.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({ Key? key, required this.food}) : super(key: key);

  final String food;

  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  late Future<List> futureChoices;

  @override
  void initState() {
    super.initState();
    futureChoices = getFoodList(widget.food);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('FOOD NUTRITION'),
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: futureChoices,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(snapshot.data!.isEmpty){
                return Text('Sorry, it seems that "${widget.food}" is not included in our sources');
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: index == 0
                            ? const Border() // This will create no border for the first item
                            : Border(
                                top: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor)
                              ), // This will create top borders for the rest
                      ),
                    // color: Colors.green[colorCodes[index]],
                    child: GestureDetector(
                        child: Text(snapshot.data![index]["title"]),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodPage(url: snapshot.data![index]["link"], title: snapshot.data![index]["title"].toUpperCase(),),
                            ),
                          );
                        }
                      )
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            
            return Column(mainAxisAlignment: MainAxisAlignment.center,children: const [Text("Loading..."),SizedBox(height: 15,),CircularProgressIndicator()]);
          },
        )  
      ),

    );
  }
}
