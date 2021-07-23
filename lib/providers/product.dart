import 'package:flutter/foundation.dart';

class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite; //should be changaeble,  if we change the favorite status ,
  //we notify all the listeners who are interested so that the widgets that are dependant on a single product 
  //are rebuild whenever a single product changes (i.e isFavorite changes )

  Product({
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isFavorite=false
      });

  void toggleFavoriteStatus() {
    if(isFavorite==true)
    {
      isFavorite=false;
    }
    else{
      isFavorite=true;
    }
    notifyListeners();
  }    
}
