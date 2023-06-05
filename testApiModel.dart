import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class testApiModel {
  Future<Map<dynamic, dynamic>> getRequest(String url) async {
    try {
      var response = await http
          .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        return {'error': response.statusCode};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<dynamic, dynamic>> postRequest(String url, Map map) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: json.encode(map), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        return {"error": response.statusCode};
      }
    } catch (e) {
      return {"error": e};
    }
  }

  List<String> final_images = [];
  final ImagePicker imagePicker = ImagePicker();
  List<XFile> imageFileList = [];
  void selectImages() async {
    imageFileList.clear();

    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();

    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      for (int i = 0; i < imageFileList.length; i++) {
        Uint8List imagebytes =
            await imageFileList[i].readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes);
        final_images.add(base64string);
      }
    }
  }
}
