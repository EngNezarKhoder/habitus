class Note {
  String id;
  String title;
  bool status;
  String date;
  String time;

  Note(
      {required this.id,
      required this.title,
      required this.status,
      required this.date,
      required this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'status': status,
      'date': date,
      'time': time
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        status: map['status'] ?? false,
        date: map['date'] ?? '',
        time: map['time'] ?? '');
  }
}
