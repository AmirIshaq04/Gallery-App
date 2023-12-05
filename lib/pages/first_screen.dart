
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/Provider/ImageProvider.dart';
import 'package:gallery_app/gallery_image/galler_image.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageProviderclass>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left: 120.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
    provider.storeImage==null    ?Container(
            child: Text('No image selected')) :
          Container(
               height: 70.h,
               width: 50.w,
               child: Image.file(provider.storeImage)
             ),
              SizedBox(height: 50.h),
              ElevatedButton(onPressed: () async {
                var permission = await PhotoManager
                    .requestPermissionExtend();
                if (permission.isAuth == true) {


                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GalleryImage(
                        requestType: RequestType.image,
                        maxCount: 1,
                      ),
                    ),
                  );
                } else {
                  PhotoManager.openSetting();
                }
              }, child: Text('Press here')),
            ],
          ),
        ),
      ),
    );
  }
}
