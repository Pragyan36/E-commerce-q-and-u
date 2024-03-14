class Products {
  Products({
    this.id,
    this.productname,
    this.productPrice,
    this.productImage,
  });

  int? id;
  String? productname;
  double? productPrice;
  String? productImage;

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productname,
        "product_price": productPrice,
        "product_img": productImage,
      };
}

var products = [
  {
    "id": 0,
    "product_name": "Nike Checkered",
    "product_price": 40.99,
    "rating": 4,
    "product_img":
        "https://e7.pngegg.com/pngimages/323/773/png-clipart-sneakers-basketball-shoe-sportswear-nike-shoe-outdoor-shoe-running-thumbnail.png",
  },
  {
    "id": 1,
    "product_name": "Checkered Shirt",
    "product_price": 19.99,
    "rating": 4.2,
    "product_img":
        "https://www.garphyttan.us/8611-medium_default/garphyttan-crafter-carpenter-shirt-red-m.jpg",
  },
  {
    "id": 2,
    "product_name": "Fashionable shoes",
    "product_price": 40.99,
    "rating": 4.1,
    "product_img":
        "https://rukminim1.flixcart.com/image/495/594/kyxb9u80/shoe/5/v/8/8-innova-01cwht-8-asian-white-original-imagbfzmrmmvkqhv.jpeg?q=50",
  },
  {
    "id": 3,
    "product_name": "Levis Jeans",
    "product_price": 20.99,
    "rating": 4.5,
    "product_img":
        "https://lsco.scene7.com/is/image/lsco/005013220-alt2-pdp-lse?fmt=jpeg&qlt=70,1&op_sharpen=0&resMode=sharp2&op_usm=0.8,1,10,0&fit=crop,0&wid=525&hei=700",
  },
];
