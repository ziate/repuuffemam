class Event {
  final int id;
  final String title;
  final String description;
  final String date;
  final String address;
  final String startDate;
  final String endDate;

  Event({
    this.title,
    this.description,
    this.date,
    this.address,
    this.startDate,
    this.endDate,
    this.id,
  });

  factory Event.fromJson(Map<dynamic, dynamic> jsonData) {
    return Event(
        title: jsonData['title'],
        id: jsonData['id'],
        description: jsonData['description'],
        date: jsonData['date'],
        address: jsonData['address'],
        startDate: jsonData['start_date'],
        endDate: jsonData['end_date']);
  }
}
