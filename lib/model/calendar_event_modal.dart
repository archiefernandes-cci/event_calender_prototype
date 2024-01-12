class CalendarEvent {
  final DateTime eventStartDate;
  final DateTime eventEndDate;
  final String eventDescription;
  final String eventTitle;


  const CalendarEvent({
    required this.eventTitle,
    required this.eventEndDate,
    required this.eventDescription,
    required this.eventStartDate,
  });
}
