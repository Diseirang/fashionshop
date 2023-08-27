import 'dart:convert';
import 'dart:io';
import 'package:fashionshop/admin/admin_screen.dart';
import 'package:fashionshop/api_connection/api_connection.dart';
import 'package:fashionshop/presentation/resource/style_manager.dart';
import 'package:fashionshop/presentation/resource/textbox_manager.dart';
import 'package:fashionshop/presentation/resource/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'admin_get_order.dart';

class AdminUploadScreen extends StatefulWidget {
  const AdminUploadScreen({super.key});

  @override
  State<AdminUploadScreen> createState() => _AdminUploadScreenState();
}

class _AdminUploadScreenState extends State<AdminUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImageXFile;

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var ratingController = TextEditingController();
  var tagsController = TextEditingController();
  var priceController = TextEditingController();
  var sizesController = TextEditingController();
  var colorsController = TextEditingController();
  var descriptionController = TextEditingController();
  var imageLink = "";

  //defaultScreen methods
  captureImageWithPhoneCamera() async {
    _pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);

    Get.back();

    setState(() => _pickedImageXFile);
  }

  pickImageFromPhoneGallery() async {
    _pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);

    Get.back();

    setState(() => _pickedImageXFile);
  }

  showDialogBoxForImagePickingAndCapturing() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.black,
            title: const Text(
              "Item Image",
              style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  captureImageWithPhoneCamera();
                },
                child: const Text(
                  "Capture with Phone Camera",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s12,
              ),
              SimpleDialogOption(
                onPressed: () {
                  pickImageFromPhoneGallery();
                },
                child: const Text(
                  "Pick Image From Phone Gallery",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }
  //defaultScreen methods ends here

  Widget defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black54,
                Colors.deepPurple,
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Get.to(const AdminGetAllOrdersScreen());
          },
          child: const Text(
            "New Orders",
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const AdminLoginScreen());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black54,
              Colors.deepPurple,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => showDialogBoxForImagePickingAndCapturing(),
                child: const Icon(
                  Icons.add_photo_alternate,
                  color: Colors.white54,
                  size: 200,
                ),
              ),

              //button
              Material(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: () => showDialogBoxForImagePickingAndCapturing(),
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 28,
                    ),
                    child: Text(
                      "Add New Item",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //uploadItemFormScreen methods
  uploadItemImage() async {
    var requestImgurApi = http.MultipartRequest(
      "POST",
      Uri.parse("https://api.imgur.com/3/image"),
    );

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    requestImgurApi.fields['title'] = imageName;
    requestImgurApi.headers['Authorization'] = "Client-ID c25a666b1ceca80";

    var imageFile = await http.MultipartFile.fromPath(
      'image',
      _pickedImageXFile!.path,
      filename: imageName,
    );

    requestImgurApi.files.add(imageFile);
    var responseFromImgurApi = await requestImgurApi.send();

    var responseDataFromImgurApi = await responseFromImgurApi.stream.toBytes();
    var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

    Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
    imageLink = (jsonRes["data"]["link"]).toString();

    // String deleteHash = (jsonRes["data"]["deletehash"]).toString();
    // print(imageLink);
    // print(deleteHash);

    saveItemInfoToDatabase();
  }

  saveItemInfoToDatabase() async {
    List<String> tagsList = tagsController.text.split(',');
    List<String> sizesList = sizesController.text.split(',');
    List<String> colorsList = colorsController.text.split(',');

    try {
      var response = await http.post(
        Uri.parse(API.uploadItem),
        body: {
          'item_id': '1',
          'name': nameController.text.trim().toString(),
          'rating': ratingController.text.trim().toString(),
          'tags': tagsList.toString(),
          'price': priceController.text.trim().toString(),
          'sizes': sizesList.toString(),
          'colors': colorsList.toString(),
          'description': descriptionController.text.trim().toString(),
          'image': imageLink.toString(),
        },
      );

      if (response.statusCode == 200) {
        var resBodyOfUploadItem = jsonDecode(response.body);

        if (resBodyOfUploadItem['success'] == true) {
          Fluttertoast.showToast(msg: "New item uploaded successfully!");

          setState(() {
            _pickedImageXFile = null;
            nameController.clear();
            ratingController.clear();
            tagsController.clear();
            priceController.clear();
            sizesController.clear();
            colorsController.clear();
            descriptionController.clear();
          });

          Get.to(const AdminUploadScreen());
        } else {
          Fluttertoast.showToast(msg: "Item not uploaded. Error, Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      Fluttertoast.showToast(msg: errorMsg.toString());
    }
  }
  //uploadItemFormScreen methods ends here

  Widget uploadItemFormScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black54,
                Colors.deepPurple,
              ],
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text("Upload Form"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _pickedImageXFile = null;
              nameController.clear();
              ratingController.clear();
              tagsController.clear();
              priceController.clear();
              sizesController.clear();
              colorsController.clear();
              descriptionController.clear();
            });

            Get.to(const AdminUploadScreen());
          },
          icon: const Icon(
            Icons.clear,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Fluttertoast.showToast(msg: "Now uploading...");
              uploadItemImage();
            },
            child: const Text(
              "Done",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          //image
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(
                  File(_pickedImageXFile!.path),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          //upload item form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.all(
                  Radius.circular(60),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, -3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                child: Column(
                  children: [
                    //email-password-login button
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //item name
                          TextFormField(
                            keyboardType: TextInputType.name,
                            controller: nameController,
                            validator: (val) =>
                                val == "" ? "Please write item name" : null,
                            decoration: inputDecoration(Icons.title, 'item name'),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //item ratings
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: ratingController,
                            validator: (val) =>
                                val == "" ? "Please give item rating" : null,
                            decoration: inputDecoration(Icons.rate_review, 'item rate...'),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //item tags
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: tagsController,
                            validator: (val) =>
                                val == "" ? "Please write item tags" : null,
                            decoration: inputDecoration(Icons.tag, 'item tags...'),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //item price
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: priceController,
                            validator: (val) =>
                                val == "" ? "Please write item price" : null,
                            decoration: inputDecoration(Icons.price_change_outlined, 'item price...'),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //item sizes
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: sizesController,
                            validator: (val) =>
                                val == "" ? "Please write item sizes" : null,
                            decoration: inputDecoration(Icons.picture_in_picture, 'item sizes...'),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //item colors
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: colorsController,
                            validator: (val) =>
                                val == "" ? "Please write item colors" : null,
                            decoration: inputDecoration(
                                Icons.color_lens, 'item colors...'),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //item description
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: descriptionController,
                            validator: (val) => val == ""
                                ? "Please write item description"
                                : null,
                            decoration: inputDecoration(
                                Icons.description, 'item description...'),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          //button
                          Material(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30),
                            child: InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Fluttertoast.showToast(
                                      msg: "Uploading now...");

                                  uploadItemImage();
                                }
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 28,
                                ),
                                child: Text(
                                  "Upload Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _pickedImageXFile == null ? defaultScreen() : uploadItemFormScreen();
  }

  InputDecoration inputDecoration(IconData iconData, String hintText) {
    return InputDecoration(
      prefixIcon: Icon(
        iconData,
        color: Colors.black,
      ),
      hintText: hintText,
      hintStyle: hintStyle(),
      border: outlinedBorder,
      enabledBorder: enabledBorder,
      focusedBorder: focuseBorder,
      disabledBorder: disabledBorder,
      contentPadding: contentPadding,
      fillColor: Colors.white,
      filled: true,
    );
  }
}
