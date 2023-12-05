import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_app/Provider/ImageProvider.dart';
import 'package:gallery_app/Provider/albumProvider.dart';
import 'package:gallery_app/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';


class GalleryImage extends StatefulWidget {
  var maxCount, requestType;
  GalleryImage({super.key, this.maxCount, this.requestType});

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  AssetPathEntity? selectAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  File? image;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var pro = Provider.of<AlbumProvider>(context, listen: false);
    if (pro.assetList.isEmpty) {
      pro.loadAlbumAsset(widget.requestType);
    }
  }

  var photoName = 'All Photos';
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageProviderclass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          Consumer<ImageProviderclass>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: smallButton(
                     onTap:(){
                       if(value.checkIndex>-1){
                         provider.storeImage = image;
                         Navigator.pop(context);
                    }
                       else{
                         Fluttertoast.showToast(
             msg: "Select Image", backgroundColor: Colors.grey);
                       }
              },
                      icon: value.checkIndex > -1
                          ? text(
                              myText: 'Next',
                              letterSpacing: 1.4,
                              // fontFamily: pMediumFont,
                              fontSize: 10.sp,
                            )
                          : const Icon(
                              Icons.home,
                              size: 15.0,
                            ),
                      btntext: value.checkIndex > -1
                          ? const Icon(
                              Icons.arrow_forward,
                              size: 15,
                            )
                          : text(
                              myText: 'Try Pro',
                              fontSize: 10.sp,
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
          SizedBox(
            width: 40.w,
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Back to previous screen
          },
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ),
        ),
        title: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Dialog(
                    insetPadding: EdgeInsets.zero,
                    child: Container(
                      width: double.infinity,
                      height: 660.h,
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35.r),
                            bottomRight: Radius.circular(35.r),
                          ),
                        ),
                        shadows: [
                          BoxShadow(
                            color: const Color(0x29000000),
                            blurRadius: 5.r,
                            offset: const Offset(6, 6),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                finish(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: GestureDetector(
                                      onTap: () {
                                        finish(context);
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                        // size: 20,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                      'Albums'
                                      ),
                                      SizedBox(
                                        width: 15.w,
                                      ),
                                      const Icon(
                                          Icons.keyboard_arrow_up_rounded),
                                    ],
                                  ),
                                  //Container()
                                ],
                              ),
                            ),

                            Expanded(
                              child: Consumer<AlbumProvider>(
                                builder: (context, value, child) {
                                  return ListView.builder(
                                    itemCount: value.albumList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          print(value
                                              .albumList[index].assetCount);
                                          value.assetList =
                                              await value.loadAsset(
                                                  value.albumList[index]);
                                          value.changePhotoName(
                                              value.albumList[index].name);
                                          // photoName =
                                          //     albumList[index].name;
                                          finish(context);
                                        },
                                        child: Container(
                                          width: 500.w,
                                          height: 100.h,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFF161A21),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(bottom: 15.h),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10.w),
                                                    bottomLeft:
                                                        radiusCircular(10.w)),
                                                child: AssetEntityImage(
                                                  value
                                                      .firstPhotoOfAlbum[index],
                                                  fit: BoxFit.cover,
                                                  isOriginal: false,
                                                  height: 100.h,
                                                  width: 100.w,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Icon(
                                                      Icons.error,
                                                      color: redColor,
                                                    );
                                                  },
                                                ),
                                              ),

                                              // text(
                                              //   myText: value.albumList[index]
                                              //               .name ==
                                              //           ''
                                              //       ? "No Name"
                                              //       : value
                                              //           .albumList[index].name,
                                              //   fontWeight: FontWeight.w500,
                                              //   fontSize: 25.sp,
                                              // ),
                                              const Spacer(),
                                              Text(
                                                "${value.albumList[index].assetCount.toString()} images",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w300,
                                                  letterSpacing: 0.48,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 8.w,
                ),
                Consumer<AlbumProvider>(builder: (context, value, child) {
                  return text(
                    myText: value.photoName == 'Recent'
                        ? 'All Photos'
                        : value.photoName.toString(),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  );
                }),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Expanded(
                  child:
                      Consumer<AlbumProvider>(builder: (context, value, child) {
                    return Stack(
                      children: [
                        //  AllAlboms(assetList: value.assetList),
                        SingleChildScrollView(
                            child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          alignment: WrapAlignment.start,
                          children: [
                            SizedBox(
                              width: 5.w,
                            ),
                            if (value.idLoading == true) ...[
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey
                                ),
                              )
                            ],
                            for (int i = 0;
                                i < value.assetList.length;
                                i++) ...[
                              GestureDetector(
                                onTap: () async {
                                  if (provider.checkIndex == i) {
                                    provider.changecheckIndex(-1);
                                    provider.storeImage = '';
                                  } else {
                                    provider.changecheckIndex(i);
                                    var assetEntity = value.assetList[i];
                                    File? file = await assetEntity.file;
                                    image = file;
                                    provider.storeImage = file;
                                    print("my Image length should be define");
                                    print(provider.storeImage);
                                  }
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10.r),
                                      child: Container(
                                        width: 100.w,
                                        height: 100.h,
                                        decoration: ShapeDecoration(
                                          image: DecorationImage(
                                            image: AssetEntityImage(
                                              value.assetList[i],
                                              fit: BoxFit.cover,
                                              isOriginal: false,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons.error,
                                                  color: redColor,
                                                );
                                              },
                                            ).image,
                                            fit: BoxFit.cover,
                                          ),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                        ),
                                      ),
                                    ),
                                    Consumer<ImageProviderclass>(
                                      builder: (context, value, child) {
                                        return value.checkIndex == i
                                            ? Container(
                                                height: 45.h,
                                                width: 45.w,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.5)),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.red,
                                                  size: 30.sp,
                                                ),
                                              )
                                            : const SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                              ).paddingBottom(10),
                              const SizedBox(
                                width: 5,
                              ),
                            ]
                          ],
                        ).paddingBottom(224.h)),

                      ],
                    );
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class blurDialog extends StatelessWidget {
//   var imageFile;
//   blurDialog({super.key, this.imageFile});
//
//   @override
//   Widget build(BuildContext context) {
//     final model = Provider.of<ImageProviderclass>(context);
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           GestureDetector(
//             onTap: () {
//               finish(context);
//             },
//             child: const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: CircleAvatar(
//                       radius: 15,
//                       backgroundColor: gray,
//                       child: Icon(
//                         Icons.close,
//                         color: white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Dialog(
//           //   child: Container(
//           //     margin: const EdgeInsets.symmetric(horizontal: 25),
//           //     // decoration: BoxDecoration(
//           //     //     color: white, borderRadius: BorderRadius.circular(8)),
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       crossAxisAlignment: CrossAxisAlignment.start,
//           //       mainAxisAlignment: MainAxisAlignment.start,
//           //       children: [
//           //         Padding(
//           //           padding: EdgeInsets.only(
//           //               left: 23.w, right: 23.w, top: 24.h, bottom: 20.h),
//           //           child: Consumer<ImageProviderclass>(
//           //               builder: (context, value, child) {
//           //             return ClipRRect(
//           //                 borderRadius: BorderRadius.circular(8),
//           //                 child: Image.file(
//           //                   imageFile,
//           //                   fit: BoxFit.values.first,
//           //                   height: 250,
//           //                   width: MediaQuery.of(context).size.width,
//           //                 ));
//           //           }),
//           //         ),
//           //         button3(
//           //           onTap: () {},
//           //           isOutLine: false,
//           //           icon: const Icon(
//           //             Icons.api_outlined,
//           //             size: 12,
//           //           ),
//           //           text2: "Premium",
//           //           text3: 'No Ads,Speed up',
//           //         ),
//           //         button3(
//           //           onTap: () {
//           //             Fluttertoast.showToast(
//           //                 msg: 'Future Update ', backgroundColor: greenColor);
//           //             // CroppingScreen(
//           //             //   image: imageFile,
//           //             // ).launch(context);
//           //           },
//           //           isOutLine: true,
//           //           icon: const Icon(Icons.api_outlined),
//           //           text2: "Colorized Photo",
//           //           text3: 'After watch ad',
//           //         ),
//           //       ],
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
