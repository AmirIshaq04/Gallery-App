// // import 'dart:typed_data';
// //
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:photo_manager/photo_manager.dart';
// //
// // import 'gallery.dart';
// //
// // class FirstScreen extends StatefulWidget {
// //   FirstScreen ({super.key});
// //
// //   @override
// //   State<FirstScreen> createState() => _FirstScreenState();
// // }
// //
// // class _FirstScreenState extends State<FirstScreen> {
// //
// //   bool permitted=false;
// //   Future<List<AssetEntity>> loadImagesFromGallery() async {
// //     List<AssetEntity> images = [];
// //     var result = await PhotoManager.requestPermissionExtend();
// //     if (permitted) {
// //       List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(onlyAll: true);
// //       images = await albums[0].getAssetListRange(start: 0, end: 10000);
// //     }
// //     return images;
// //   }
// //   List<AssetEntity>? _images;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     loadImagesFromGallery().then((value) {
// //       setState(() {
// //         _images = value;
// //       });
// //     });
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Gallery'),
// //       ),
// //       body: _images != null
// //           ? GridView.builder(
// //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //           crossAxisCount: 3,
// //           crossAxisSpacing: 4.0,
// //           mainAxisSpacing: 4.0,
// //         ),
// //         itemCount: _images!.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return FutureBuilder<Uint8List?>(
// //             future: _images![index].thumbnailData,
// //             builder: (BuildContext context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.done &&
// //                   snapshot.hasData) {
// //                 return Image.memory(snapshot.data!);
// //               } else {
// //                 return Container(); // Placeholder or loading indicator
// //               }
// //             },
// //           );
// //         },
// //       )
// //           : Center(
// // //         child: CircularProgressIndicator(), // Loading indicator
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // /////////////////////////
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';
//
// class FirstScreen  extends StatefulWidget {
//   final ScrollController? scrollCtr;
//   const FirstScreen({
//     Key? key,
//     this.scrollCtr,
//   }) : super(key: key);
//
//
//   @override
//   State<FirstScreen> createState() => _FirstScreenState(scrollCtr: scrollCtr);
// }
//
// class _FirstScreenState extends State<FirstScreen> {
//   final ScrollController? scrollCtr;
//   _FirstScreenState({this.scrollCtr});
//
//   List _mediaList = [];
//   int currentPage = 0;
//   int? lastPage;
//   @override
//   void initState() {
//     super.initState();
//     _fetchNewMedia();
//   }
//   _handleScrollEvent(ScrollNotification scroll) {
//     if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
//       if (currentPage != lastPage) {
//         _fetchNewMedia();
//       }
//     }
//   }
//   _fetchNewMedia() async {
//     lastPage = currentPage;
//     final PermissionState _ps = await PhotoManager.requestPermissionExtend();
//     if (_ps.isAuth) {
//       // success
// //load the album list
//       List albums =
//       await PhotoManager.getAssetPathList(
//           onlyAll: true);
//       print(albums);
//       List media =
//       await albums[0].getAssetListPaged(size: 60, page: currentPage); //preloading files
//       print(media);
//       List temp = [];
//       for (var asset in media) {
//         temp.add(
//           FutureBuilder(
//             future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)), //resolution of thumbnail
//             builder:
//                 (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return Container(
//                   child: Stack(
//                     children: [
//                       Positioned.fill(
//                         child: Image.memory(
//                           snapshot.data!,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       if (asset.type == AssetType.video)
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: Padding(
//                             padding: EdgeInsets.only(right: 5, bottom: 5),
//                             child: Icon(
//                               Icons.videocam,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 );
//               }
//               return Container();
//             },
//           ),
//         );
//       }
//       setState(() {
//         _mediaList.addAll(temp);
//         currentPage++;
//       });
//     } else {
//       // fail
//       /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return NotificationListener(
//       onNotification: (ScrollNotification scroll) {
//         _handleScrollEvent(scroll);
//         return false;
//       },
//       child: GridView.builder(
//           controller: widget.scrollCtr ?? ScrollController(),
//           itemCount: _mediaList.length,
//           gridDelegate:
//           SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               child: _mediaList[index],
//             );
//           }),
//     );
//   }
// }
