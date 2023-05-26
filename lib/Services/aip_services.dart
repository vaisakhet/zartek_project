import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/restaurent_model.dart';

class ApiService {
  Future<Restaurant?> fetchData() async {
    final url = Uri.parse('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');

    final response = await http.get(url);
    Restaurant? foodItems;

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var data = json.decode(jsonString);
      // var dat = foodFromJson(response.body);

      foodItems = Restaurant.fromJson(data[0]);
      return foodItems;
    } else {
      print(response.reasonPhrase);
      return foodItems;
    }
  }
}
