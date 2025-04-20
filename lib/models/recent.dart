class Recent {
// {
//         "grade": "JK (Hand Strip)",
//         "local_name": "Bakak",
//         "price": "48 Pesos",
//         "created_at": "2025-04-20T17:28:16.000000Z",
//         "formatted_date": "04-20-2025"
//     },

  final String grade;
  final String localName;
  final String price;
  final String createdAt;
  final DateTime formattedDate;

  Recent({
    required this.grade,
    required this.localName,
    required this.price,
    required this.createdAt,
    required this.formattedDate,
  });

  static Recent fromJson(Map<String, dynamic> json) => Recent(
      createdAt: json['created_at'],
      grade: json['grade'],
      formattedDate: DateTime.parse(json['created_at']),
      localName: json['local_name'],
      price: json['price']);
}
