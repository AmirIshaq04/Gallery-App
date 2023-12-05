import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_app/Provider/ImageProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:nb_utils/nb_utils.dart';


// ignore: must_be_immutable
class AllAlboms extends StatefulWidget {
  List<AssetEntity> assetList = [];

  AllAlboms({super.key, required this.assetList});

  @override
  State<AllAlboms> createState() => _AllAlbomsState();
}

class _AllAlbomsState extends State<AllAlboms> {
  int indx = 0;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ImageProviderclass>(context, listen: false);
    return GridView.builder(
      itemCount: widget.assetList.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1),
      itemBuilder: (context, index) {
        AssetEntity assetEntity = widget.assetList[index];

        return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: index == 0
                ? GestureDetector(
                    onTap: () {
                      provider.pickImage(context, ImageSource.camera);
                    },
                    child: Container(
                      color: Colors.grey,
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(
                              Icons.video_collection_outlined,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Camera'),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () async {
                      if (provider.checkIndex == index) {
                        provider.changecheckIndex(0);
                        provider.storeImage = '';
                      } else {
                        provider.changecheckIndex(index);
                        File? file = await assetEntity.file;
                        provider.storeImage = file;
                        print("my Image length should be define");
                        print(provider.storeImage);
                      }
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AssetEntityImage(
                          assetEntity,
                          fit: BoxFit.cover,
                          isOriginal: false,
                          thumbnailSize: const ThumbnailSize.square(250),
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              color: redColor,
                            );
                          },
                        ),
                        Consumer<ImageProviderclass>(
                          builder: (context, value, child) {
                            return value.checkIndex == index
                                ? Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 1.5)),
                                    child: const Icon(
                                      Icons.check,
                                      color: white,
                                      size: 18,
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ));
      },
    );
  }
}
