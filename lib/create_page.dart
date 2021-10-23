import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'data/post_api_service.dart';

class CreatePage extends StatefulWidget {
  final String bearerToken;

  const CreatePage({
    Key key,
    this.bearerToken,
  }) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  String _place;
  String _comments;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = pickedFile;
      });
      //_imageFile = pickedFile;
    } catch (e) {
      print("Image picker error " + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel Blog"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Text(
                    'Create',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _place = value,
                      decoration: InputDecoration(labelText: "Place")),
                  TextFormField(
                      onSaved: (value) => _comments = value,
                      decoration: InputDecoration(labelText: "Comments")),
                  OutlinedButton(
                    onPressed: _pickImage,
                    child: (_imageFile == null) ? Icon(Icons.photo_library) : Image.file(File(_imageFile.path)),
                  ),
                  ElevatedButton(
                      child: Text("CREATE"),
                      onPressed: () async {
                        final form = _formKey.currentState;
                        form.save();

                        if (form.validate()) {
                          Response response;
                          try {
                            response = await Provider.of<PostApiService>(context, listen: false)
                                .postPost(
                                'Bearer ' + widget.bearerToken,
                                _place,
                                _comments,
                                (await File(_imageFile.path).readAsBytes()).toList()
                              );
                            //return response;
                            print(response.bodyString);
                          } catch (e) {
                            rethrow;
                          }
                          // var result = await Provider.of<PostApiService>(context, listen: false)
                          //     .postPost(
                          //     'Bearer ' + widget.bearerToken,
                          //     _place,
                          //     _comments,
                          //     (await File(_imageFile.path).readAsBytes()).toList()
                          // );

                        }
                      }),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
