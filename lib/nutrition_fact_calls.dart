
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<NutritionFact> getNutritionFact(String url) async {
  final response = await http
      .get(Uri.parse('https://myfood-nutrition-api.herokuapp.com/food-nutrient?url=$url'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return NutritionFact.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load NutritionFact');
  }
}

class NutritionFact {
  final String food_imgurl;
  final List graphs;
  final String table;

  NutritionFact({
    required this.food_imgurl,
    required this.graphs,
    required this.table,
  });

  factory NutritionFact.fromJson(Map<String, dynamic> json) {
    return NutritionFact(
      food_imgurl: json['food_imgurl'],
      graphs: json['graphs'],
      table: json['table'],
    );
  }
}



// USED FOR SELECTION PAGE
Future<List> getFoodList(String food) async {
  final response = await http
      .get(Uri.parse('https://myfood-nutrition-api.herokuapp.com/query/$food'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load NutritionFact');
  }
}