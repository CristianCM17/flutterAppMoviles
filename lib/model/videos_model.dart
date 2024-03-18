
import 'package:flutter/foundation.dart';

class VideoModel {

  String? name;
  String? key;

  VideoModel({

    this.name,
    this.key,

  });

  factory VideoModel.fromMap(Map<String,dynamic> video){
    return VideoModel(
       name: video['name'],
      key: video['key']
      );
  }
}
