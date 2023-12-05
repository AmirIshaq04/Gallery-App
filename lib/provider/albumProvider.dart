import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbumProvider with ChangeNotifier {
  // about albums
  AssetPathEntity? selectAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  String photoName = "All Photos";
  changePhotoName(n) {
    photoName = n;
    notifyListeners();
  }

  bool idLoading = false;
  changeLoading(t) {
    idLoading = t;
  }

  Future loadAlbumAsset(RequestType type) async {
    changeLoading(true);
    // var permission = await PhotoManager.requestPermissionExtend();
    // if (permission.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(type: type);
    // } else {
    //   PhotoManager.openSetting();
    // }
    if (albumList.isNotEmpty) {
      selectAlbum = albumList[0];
      for (int i = 0; i < albumList.length; i++) {
        var selec = albumList[i];
        var f = await selec.getAssetListPaged(page: 0, size: selec.assetCount);
        firstPhotoOfAlbum.add(f[0]);
      }
      assetList = await selectAlbum!
          .getAssetListRange(start: 0, end: selectAlbum!.assetCount);
      changeLoading(false);
      notifyListeners();
      return assetList;
    }
  }

  Future loadAlbum(RequestType type) async {
    var permission = await PhotoManager.requestPermissionExtend();
    if (permission.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(type: type);
    } else {
      PhotoManager.openSetting();
    }
    notifyListeners();
    return albumList;
  }

  Future loadAsset(AssetPathEntity selectedAlbum) async {
    assetList = await selectedAlbum.getAssetListRange(
        start: 0, end: selectedAlbum.assetCount);
    print("my assets count");
    print(selectedAlbum.assetCount);
    notifyListeners();
    return assetList;
  }

  List<AssetEntity> firstPhotoOfAlbum = [];

  bool saveImage=false;
}
