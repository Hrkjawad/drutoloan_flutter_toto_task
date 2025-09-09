class Todo {
  final int id;
  final String title;
  final String description;
  final int createdAt;
  String status;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  String toCsv() {
    return '$id,$title,$description,$createdAt,$status';
  }

  static Todo fromCsv(String line) {
    final parts = line.split(',');
    return Todo(
      id: int.parse(parts[0]),
      title: parts[1],
      description: parts[2],
      createdAt: int.parse(parts[3]),
      //createdAt: parts[3],
      status: parts[4],
    );
  }

  String get createdAtString {
    final date = DateTime.fromMillisecondsSinceEpoch(createdAt);
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    final hour = date.hour > 12
        ? date.hour - 12
        : date.hour == 0
        ? 12
        : date.hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final amPm = date.hour >= 12 ? "PM" : "AM";
    return "${date.day} ${months[date.month - 1]}, $hour:$minute $amPm";
  }

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'status': status,
    };
  }
}
