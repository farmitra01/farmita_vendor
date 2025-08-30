import 'dart:convert';

class ChatApiResponse {
  final String response;
  final List<Product> products;
  final String model;

  ChatApiResponse({
    required this.response,
    required this.products,
    required this.model,
  });

  factory ChatApiResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return ChatApiResponse(
      response: data['response']?.toString() ?? '',
      products: (data['products'] as List<dynamic>?)
              ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      model: data['model']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'products': products.map((e) => e.toJson()).toList(),
      'model': model,
    };
  }

  static ChatApiResponse fromRawJson(String str) =>
      ChatApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Product {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String productUrl;
  final double rating;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.productUrl,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url']?.toString() ?? '',
      productUrl: json['product_url']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'product_url': productUrl,
      'rating': rating,
    };
  }
}