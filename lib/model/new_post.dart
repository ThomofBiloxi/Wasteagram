class Post {
  final DateTime date;
  final String imageURL;
  final int quantity;
  final double latitude;
  final double longitude;

  Post(
      {required this.date,
      required this.imageURL,
      required this.quantity,
      required this.latitude,
      required this.longitude});

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}