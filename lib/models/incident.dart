class Incident {
  int? id;
  String title;
  String description;
  String category;
  String location;
  DateTime dateTime;
  String status;
  String? photoPath;

  Incident({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    required this.dateTime,
    required this.status,
    this.photoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'location': location,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'photoPath': photoPath,
    };
  }

  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      location: map['location'],
      dateTime: DateTime.parse(map['dateTime']),
      status: map['status'],
      photoPath: map['photoPath'],
    );
  }
} 