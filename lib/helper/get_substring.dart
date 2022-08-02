String getSubString(String text) {
  String displayedString = '';
  if (text.length > 16) {
    for (int i = 0; i < 16; i++) {
      displayedString += text[i];
    }
  } else {
    displayedString = text;
  }
  return displayedString;
}
