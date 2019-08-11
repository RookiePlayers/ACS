class Giphy {
List<Gif>data=[];
Giphy({this.data});

factory Giphy.fromJson(Map<dynamic,dynamic> json){
  var snapshot=json['data'];
  List<Gif> temp=[];
  for (var s in snapshot) {
    temp.add(Gif.fromJson(s));
   // print(s);
  }
  return Giphy(data:temp);

}

}
class Gif{
  String type;
  String id;
  String slug;
  String url;
  Images images;
  Gif({
    this.id,
    this.images,
    this.slug,
    this.type,
    this.url
  });
  Gif.fromJson(Map<dynamic,dynamic> json){
    this.type=json['type'];
    this.id=json['id'];
    this.slug=json['slug'];
    this.url=json['url'];
    this.images=Images.fromJson(json['images']['original']);
  }
  }
  
  class Images {
    String url;
    String width;
    String height;
    String size;
    String mp4;

    Images({
      this.height,
      this.mp4,
      this.size,
      this.url,
      this.width
    });
    Images.fromJson(Map<dynamic,dynamic> json){
    this.url=json['url'];
    this.width=json['width'];
    this.height=json['height'];
    this.mp4=json['mp4'];
    this.size=json['size'];
  }
  
}