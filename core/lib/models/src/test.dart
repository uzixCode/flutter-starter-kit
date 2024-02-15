import 'dart:convert';

class Test {
  String? nama;

  Test({this.nama});

  factory Test.fromMap(Map<String, dynamic> data) => Test(
        nama: data['nama'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'nama': nama,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Test].
  factory Test.fromJson(String data) {
    return Test.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Test] to a JSON string.
  String toJson() => json.encode(toMap());

  Test copyWith({
    String? nama,
  }) {
    return Test(
      nama: nama ?? this.nama,
    );
  }
}
