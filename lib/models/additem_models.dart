class additem {
  int? pid;
  String? itemname;
  int? price;
  String? image;
  String? description;

  additem({this.pid, this.itemname, this.price, this.image,this.description});

  additem.fromJson(Map<String, dynamic> json) {

    pid = json['pid'];
    itemname = json['itemname'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    
  }

  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['itemname'] = this.itemname;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
