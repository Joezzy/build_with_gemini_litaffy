String convertToJsonStringQuotes({required String raw}) {
  /// remove space
  String jsonString = raw.replaceAll(" ", "");

  /// add quotes to json string
  jsonString = jsonString.replaceAll('{', '{"');
  jsonString = jsonString.replaceAll(':', '": "');
  jsonString = jsonString.replaceAll(',', '", "');
  jsonString = jsonString.replaceAll('}', '"}');

  /// remove quotes on object json string
  jsonString = jsonString.replaceAll('"{"', '{"');
  jsonString = jsonString.replaceAll('"}"', '"}');

  /// remove quotes on array json string
  jsonString = jsonString.replaceAll('"[{', '[{');
  jsonString = jsonString.replaceAll('}]"', '}]');

  return jsonString;
}
