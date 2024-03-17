extension DateTimeFormatter on DateTime {
  String get formattedDate {
    return "$day/$month/$year";
  }

  String get formattedTime {
    return "$hour:$minute";
  }

  String get formattedDateTime {
    return "$formattedDate $formattedTime";
  }
}
