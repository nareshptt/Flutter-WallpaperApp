class Photosmodel {
  String? url;
  SrcModel? src;

  Photosmodel({this.url, this.src});

  factory Photosmodel.fromMap(Map<String, dynamic> parsedJson) {
    return Photosmodel(
        url: parsedJson["url"], src: SrcModel.fromMap(parsedJson["src"]));
  }
}

class SrcModel {
  String? portrait;
  String? large;
  String? landscape;
  String? medium;

  SrcModel({this.landscape, this.large, this.medium, this.portrait});
  factory SrcModel.fromMap(Map<String, dynamic> srcJson) {
    return SrcModel(
        portrait: srcJson["portrait"],
        landscape: srcJson["landscape"],
        large: srcJson["large"],
        medium: srcJson["medium"]);
  }
}
