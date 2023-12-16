class RestaurantModel{
  String restaurantId='', address='',name='',imageUrl='',paymentUrl='',phone='';

  RestaurantModel(
  {required this.address,
    required this.name,
    required this.imageUrl,
    required this.paymentUrl,
    required this.phone});

  RestaurantModel.fromJson(Map<String,dynamic>json){
    address = json['address'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    paymentUrl = json['paymentUrl'];
    phone = json['phone'];
  }
  Map<String,dynamic> toJson(){
    var data = <String,dynamic>{};
    data['address'] =address;
    data['name'] =name;
    data['imageUrl'] =imageUrl;
    data['paymentUrl'] =paymentUrl;
    data['phone'] =phone;

    return data;
  }
}