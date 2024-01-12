enum TimeOfTheDay {
  earlyMorning ('Early Morning'),
  morning ('Morning'),
  afternoon ('Afternoon'),
  evening ('Evening'),
  night ('Night'),
  none ('');
  final String value;
  const TimeOfTheDay(this.value);
}

enum RoutineLabel {
  home ('Home'),
  noHat ('No Hat'),
  me ('Me');

  final String value;
  const RoutineLabel(this.value);
}