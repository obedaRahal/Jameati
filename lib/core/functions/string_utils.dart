Map<String, String> extractRemainingParts(String rawRemaining) {
  final regex = RegExp(r'^(\d+)(\D+)$');
  final match = regex.firstMatch(rawRemaining.trim());

  if (match != null) {
    final number = match.group(1) ?? "0";
    final unit = match.group(2)?.trim() ?? "";
    return {
      "number": number,
      "unit": unit,
    };
  } else {
    return {
      "number": "0",
      "unit": "",
    };
  }
}
