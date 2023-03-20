import 'package:test/test.dart';
import 'package:wasteagram/model/new_post.dart';

void main() {
  test('toMap() returns the correct types', () {
    final post = Post(
        date: DateTime(2022, 12, 30),
        imageURL:
            'https://www.pakainfo.com/wp-content/uploads/2021/09/image-url-for-testing.jpg',
        quantity: 7,
        latitude: -44.17133,
        longitude: -63.72166);

    final map = post.toMap();

    expect(map['date'], TypeMatcher<DateTime>());
    expect(map['imageURL'], TypeMatcher<String>());
    expect(map['quantity'], TypeMatcher<int>());
    expect(map['latitude'], TypeMatcher<double>());
    expect(map['longitude'], TypeMatcher<double>());
  });

  test('toMap() creates the correct object', () {
    final date = DateTime(2022, 12, 30);
    const imageURL =
        'https://www.pakainfo.com/wp-content/uploads/2021/09/image-url-for-testing.jpg';
    const quantity = 7;
    const latitude = -44.17133;
    const longitude = -63.72166;

    final post = Post(
        date: date,
        imageURL: imageURL,
        quantity: quantity,
        latitude: latitude,
        longitude: longitude);

    expect(post.date, equals(date));
    expect(post.imageURL, equals(imageURL));
    expect(post.quantity, equals(quantity));
    expect(post.latitude, equals(latitude));
    expect(post.longitude, equals(longitude));
  });

  test('toMap() returns a valid map', () {
    final post = Post(
        date: DateTime(2022, 12, 30),
        imageURL:
            'https://www.pakainfo.com/wp-content/uploads/2021/09/image-url-for-testing.jpg',
        quantity: 7,
        latitude: -44.17133,
        longitude: -63.72166);

    final map = post.toMap();

    expect(map['date'], equals(post.date));
    expect(map['imageURL'], equals(post.imageURL));
    expect(map['quantity'], equals(post.quantity));
    expect(map['latitude'], equals(post.latitude));
    expect(map['longitude'], equals(post.longitude));
  });
}
