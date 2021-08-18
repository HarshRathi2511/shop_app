import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite; //should be changaeble,  if we change the favorite status ,
  //we notify all the listeners who are interested so that the widgets that are dependant on a single product
  //are rebuild whenever a single product changes (i.e isFavorite changes )

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus(String productId , String token) async {
    //update it in firebase
    final url = Uri.parse(
        'shop-app-16d20-default-rtdb.firebaseio.com/products/$id.json?auth=$token');

   final oldFavoriteStatus = isFavorite;

    if (isFavorite == true) {
      isFavorite = false;
    } else {
      isFavorite = true;
    }
  
    try{
       //utilise optimistic update
     final response =await http.patch(url, body: json.encode({
      'isFavorite' : isFavorite,  
    }));
    print(response.statusCode);//404 ->so the patch request doesnt update it 

    if(response.statusCode>=400) {
        isFavorite=oldFavoriteStatus;
        notifyListeners();
    }
    }
    catch (error) {
       isFavorite=oldFavoriteStatus;
        notifyListeners();
    }
   
    // print(response.body);

    notifyListeners();
  }
}
