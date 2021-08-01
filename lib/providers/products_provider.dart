//mixin -->class that contains
// methods for the use by other classes without having to be the parent class of those other classes
//used by the "with " keyword
import 'package:flutter/material.dart';
import 'product.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    //dummy data

    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  // var _showFavoritesOnly=false;

  List<Product> get items {
    //we are managing the favorites and
    //the all the item in the same function because we are not adding a different
    //screen to show the favorited items ,rather we are just changing what is displayed on
    //the screen on pressing the showFavorites pop up button
    // if(_showFavoritesOnly==true){
    //   return _items.where((prodItem) =>prodItem.isFavorite==true).toList();
    // }
    return [
      ..._items
    ]; //copy of the list //if we use (return _items;) ->pointer at this is returned
    //we could start editing the product list which we dont want
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite == true).toList();
  }

  // void showFavoritesOnly(){
  //   _showFavoritesOnly=true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly=false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
    //compare the id of each product and return the matching product
  }

  //response.body yields a (map within a another map)
  // {-MfhPsDpHK-79RbN9BvK:
  //{description: Fries away all your dreams ,
  //imageUrl: https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg,
  // isFavorite: false,
  //price: 12.99,
  //title: Frying pan},

  //-MfhQbjAe9zZWmRR_CpP: {description: Cool yellow Scarf!, imageUrl: https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg, isFavorite: false, price: 21.99, title: Yellow Scarf}, -MfhQk6a2vUPGJ26i-gr: {description: Smart and comfortable!, imageUrl: https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg, isFavorite: false, price: 15.77, title: Trousers }}

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(
        'shop-app-16d20-default-rtdb.firebaseio.com', '/products.json');
    try {
      final response = await http.get(
          url); //Future<Response> get(Uri url, {Map<String, String> headers})
      // print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if(extractedData==null) {
        return;
      }
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodKey, prodValue) {
        //Applies [action] to each key/value pair of the map
        loadedProducts.add(
          Product(
            id: prodKey,
            description: prodValue['description'],
            title: prodValue['title'],
            isFavorite: prodValue['isFavorite'],
            price: prodValue['price'],
            imageUrl: prodValue['imageUrl'],
          ),
        );
      });

      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    //async->always returns a future
    //If a future doesnt return a usbale value then the futures type is Future<void>
    //body->type of arguments
    // JSON ->JavaScript Object Notation =>format for storing and transmitting data
    final url = Uri.https(
        'shop-app-16d20-default-rtdb.firebaseio.com', '/products.json');
    //should end with json for firebase
    //after /=>we can specify any ending and a folder is created on the basis of that url
    try {
      final response = await http.post(
        url,
        body: json.encode({
          //return contains the response of the http.post method =>
          //http.post method returns a then property which adds the product to the list
          'title': product.title,
          'imageUrl': product.imageUrl,
          'description': product.description, //pass a map in json
          'price': product.price,
          'isFavorite': product.isFavorite,
          // 'id':
        }), //String encode(Object value, {Object Function(dynamic) toEncodable})
      );
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);

      _items.add(newProduct);

      notifyListeners(); //communication channel between provider and the widgets
    } catch (error) {
      print(error);
      throw error;
    }
  }
  // then((response){ //executes once function done ,,,response=>response we get from the server

  // print(json.decode(response.body)); //mostly converted to a map by decode

  //prints ->{name: -MfcZWD0iMtB8tQ_ma43} //use this as a id
  //just use one id for the entire project ->wont have issues with backend and frontend memory
  //i.e just use the backend id for each product

  // .catchError((error){
  //if the error caught in http post then dart skips the code
  //statement and directly comes to the catchError
  // print(error);
  //   throw error; //to add another catchError somewhere else
  // });

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    final url = Uri.https(
        'shop-app-16d20-default-rtdb.firebaseio.com', '/products/$id.json');
    //to update the products in firebase =>'/products/$id.json to get into one specefic product

    await http.patch(url,
        body: json.encode({
          'title': newProduct.title, //newProduct is the updated product
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price,
        }));

    _items[prodIndex] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    
    final url = Uri.https(
        'shop-app-16d20-default-rtdb.firebaseio.com', '/products/$id.json');

    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[
        existingProductIndex]; //Save the pointers of the product which is about to be deleted

    _items.removeAt(existingProductIndex);
    notifyListeners(); //just removed from the list but not from the complete memory

    //OPTIMISTIC UPDATING
    //delete doesnt execute properly=>web servers send back status codes whether action completed or not

    final response = await http.delete(url);

    // print(response.statusCode); //405 ->error occured but catchError doesnt catch it (now it has been fixed)
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex,
          existingProduct); //reinsert the element in the list if we falied somewhere
      notifyListeners(); //just removed from the list but not from the complete memory
      throw HttpExceptions(
          'Could not delete product'); //then we make it into catchError
    }

    existingProduct =
        null; //if we are able to delete without any errors delete the pointer as well ,otherwise don't

    notifyListeners();
    //delete that id from the complete screen
  }
}
