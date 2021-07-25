import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import '../widgets/cart_item.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

class EditProductScreen extends StatefulWidget {
  // const EditProductScreen({ Key? key }) : super(key: key);

  static const routeName = '/edit-products';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode=FocusNode();

  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    //to set a listener whether image url text field is focused or not 
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  void _updateImageUrl(){
    if(! _imageUrlFocusNode.hasFocus){
       setState(() { });
    }
  }

  //we have to dispose when we leave the screen

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit and Add Products'),
      ),
      //Creates a container for form fields.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        //IMP...
//User input might get lost if an input fields scrolls out of view.
// That happens because the ListView widget dynamically removes and
//re-adds widgets as they scroll out of and back into view.
// For short lists/ portrait-only apps, where only minimal scrolling might be
// needed, a ListView should be fine, since items won't scroll that far out
//of view (ListView has a certain threshold until which it will keep items in memory).
// But for longer lists or apps that should work in landscape mode as well - or maybe
// just to be safe - you might want to use a Column (combined with SingleChildScrollView)
// instead. Since SingleChildScrollView doesn't clear widgets that scroll out of view,
//you are not in danger of losing user input in that case.

        child: Form(
          child: SingleChildScrollView(
            child: Column(children: [
              TextFormField(
                //connected to the form widget
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction
                    .next, //adds a button the cursor to the next input
                //controls what the bottom right keyboard button will do
                onFieldSubmitted: (v) {
                  //use the focus node to move the cursor from the title input to the price input
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                  //now the focus node points to the field which has _priceFocusNode
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (v) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(child: Text('Please enter a URL'))
                        : FittedBox(
                           child: Image.network(_imageUrlController.text),
                           fit: BoxFit.cover,
                        ),
                  ), //shows preview of image
                  Expanded(
                    child: TextFormField(  //by default gets the maximum size it can bget in a row 
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      //what the bottom right button on keyboard looks like
                      controller: _imageUrlController,
                      onEditingComplete: () {
                        setState(() {});
                        //we force flutter to update screen hence picking latest value added
                        //by the user
                      },
                      focusNode: _imageUrlFocusNode,
                    ),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
