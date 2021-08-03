import 'dart:io';

import 'package:flutter/material.dart';
import 'package:images_picker/images_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? path;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              child: Text('pick'),
              onPressed: () async {
                List<Media>? res = await ImagesPicker.pick(
                  count: 1,
                  pickType: PickType.image,
                  language: Language.System,
                  cropOpt: CropOption(
                    cropType: CropType.circle,
                    aspectRatio: CropAspectRatio.wh1x2,
                  ),
                );
                if (res != null) {
                  print(res.map((e) => e.path).toList());
                  setState(() {
                    path = res[0].thumbPath;
                  });
                  // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
                  // print(status);
                }
              },
            ),
            ElevatedButton(
              child: Text('openCamera'),
              onPressed: () async {
                List<Media>? res = await ImagesPicker.openCamera(
                  pickType: PickType.image,
                  quality: 0.5,
                  cropOpt: CropOption(
                    cropType: CropType.circle,
                    aspectRatio: CropAspectRatio.wh1x2,
                  ),
                  // maxTime: 60,
                );
                if (res != null) {
                  print(res[0].path);
                  setState(() {
                    path = res[0].thumbPath;
                  });
                }
              },
            ),

            path != null
                ? Container(
              height: 200,
              child: Image.file(
                File(path!),
                fit: BoxFit.contain,
              ),
            )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

// Future<File> downloadFile(String url) async {
//   Dio simple = Dio();
//   String savePath = Directory.systemTemp.path + '/' + url.split('/').last;
//   await simple.download(url, savePath,
//       options: Options(responseType: ResponseType.bytes));
//   print(savePath);
//   File file = new File(savePath);
//   return file;
// }
}
