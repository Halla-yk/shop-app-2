import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isInit = true;
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };

  //ال form بخليني احصل على البيانات بعد مأعمل  submit بكن ازا بدي احصل على البيانات الي دخلها المستخدم قبل ال submit بروح بعمل لهادا ال field...controller
  var _editedProduct =
      Product(description: '', imageUrl: '', id: null, price: 0, title: '');

  @override
  void initState() {
    //ما بنفع اخد بيانات من صفحة تانية عن طريق ال modalRoute داخل ال initState اما اي بيانات من اي مصدر تاني بجليها داخل ال initState
    // TODO: implement initState
    super.initState();
  }

  @override
  void didchangedependencies() {
    //بتتنفذ بعد ال initState و قبل الbuild
    if (_isInit) {
      //علشان تتنفذ مرة وحدة بس
      final id = ModalRoute.of(context).settings.arguments as String;
      if (id != null) {//يعني جاي عن طريق زر ال edit من الصفحة اللي قبل
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(id);
        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          //"imageUrl": _editedProduct.imageUrl
          "imageUrl":""
        };
        _imageUrlController.text = _editedProduct.imageUrl;// ما بنفع بنفس ال textField  يكون في initialValues و controller مع بعض
      }
      _editedProduct =
          Provider.of<Products>(context, listen: false).findById(id);
      _initValues = {
        "title": _editedProduct.title,
        "description": _editedProduct.description,
        "price": _editedProduct.price.toString(),
        "imageUrl": _editedProduct.imageUrl
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //بتتنفذ لما اطلع من ال page
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState.validate()) {
      //يعني لو ولا validator رجعلي رسالة خطأ
      _formKey.currentState.save();
      if(_editedProduct.id !=null){
        Provider.of<Products>(context).editProduct(_editedProduct.id,_editedProduct);
      }
      Provider.of<Products>(context).addProduct(_editedProduct);
      Navigator.pop(context);
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Screen"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveForm();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _initValues["title"],
                  decoration: InputDecoration(labelText: "Title"),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editedProduct.title = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'please Enter value';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValues['price'],
                  decoration: InputDecoration(labelText: "Price"),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onSaved: (value) {
                    _editedProduct.price = double.parse(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please Enter a Valid Number';
                    }
                    if (double.parse(value) < 0) {
                      return 'Please enter a number greater than zero';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    initialValue: _initValues['description'],
                    decoration: InputDecoration(labelText: "Description"),
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    focusNode: _descriptionFocusNode,
                    onSaved: (value) {
                      _editedProduct.description = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter value';
                      }
                      return null;
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: Container(
                        child: _imageUrlController.text.isEmpty
                            ? Text("Enter URL")
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(_imageUrlController.text),
                              ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // ما بنفع بنفس ال textField  يكون في initialValues و controller مع بعض
                         // initialValue: _initValues['imageUrl'],
                          decoration: InputDecoration(labelText: "Image URL"),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onSaved: (value) {
                            _editedProduct.imageUrl = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter value';
                            }
                            if (!value.startsWith('http') ||
                                value.startsWith('https')) {
                              return 'Please Enter a valid Url';
                            }
                            if (!value.endsWith('.jpg') ||
                                value.endsWith('.png') ||
                                value.endsWith('.jpeg')) {
                              return 'Please Enter a valid input';
                            }
                            return null;
                          }),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
