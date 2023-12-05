import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderclass with ChangeNotifier {
  var storeImage;
  File? image;
  double pecent = 0;
  // ApiService apiService = ApiService();

  String uploadingString = "Preparing Image";

  String? _colorizedType;

  String get getColorizedType => _colorizedType!;

  pickImage(context, ImageSource source) async {
    final picker = ImagePicker();
    final logoImageFile = await picker.pickImage(source: source);

    if (logoImageFile != null) {
      image = File(logoImageFile.path);
      print("My Image");
      print(image);

      print('-----------');
      notifyListeners();
    }
  }

  int checkIndex = -1;

  changecheckIndex(ind) async {
    checkIndex = ind;
    notifyListeners();
  }



  // void uploadFile(File file, BuildContext context) async {
  //   apiService.uploadFile(file, (progress) {
  //     print('Upload Progress: ${(progress * 100).toStringAsFixed(0)}%');
  //     pecent = double.parse((progress * 100).toStringAsFixed(0));
  //     uploadingString = pecent == 100 ? "Completed" : "Preparing Image";
  //     notifyListeners();
  //   }, context);

  //   updateThePecentage();

  //   notifyListeners();
  // }

  /* update the percentage */
  void updateThePecentage() {
    pecent = 0;
    notifyListeners();
  }

//
  void changeTheColorizedType(String colorizedTxt) {
    _colorizedType = colorizedTxt;
    notifyListeners();
  }

  // change the uploading txt

  void changeTheUploadingTxt() {
    uploadingString = "Preparing Image";
    notifyListeners();
  }
}
