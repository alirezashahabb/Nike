class BannerEntity{
  final int id ; 
  final String image ;

  BannerEntity(this.id, this.image); 

  factory BannerEntity.fromJson(Map<String , dynamic> jsonMap){
    return BannerEntity(
      jsonMap['id'],
      jsonMap['image'],
    );
  }

}