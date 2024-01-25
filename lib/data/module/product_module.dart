class ProductSort{
  static const leatst  = 0 ;
  static const popular  = 1 ;
  static const price_low_to_hight  = 1 ;
  static const price_hight_to_low  = 2 ;

}



class ProductEntity{
  final int id ; 
  final String title ; 
  final int price ; 
  final  int discount ; 
  final String image ; 
  final int previousPrice;

  ProductEntity(this.id, this.title, this.price, this.discount, this.image, this.previousPrice);

  factory ProductEntity.fromJson(Map<String , dynamic> jsonMap){
    return ProductEntity(
   jsonMap['id'],
   jsonMap['title'],
   jsonMap['price'],
   jsonMap['discount'],
   jsonMap['image'],
   jsonMap['previous_price'] ??  jsonMap['discount'],
    ) ; 

  }
  
}