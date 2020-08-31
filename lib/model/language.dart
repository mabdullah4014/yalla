class Language {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;
  String country;

  Language(this.country, this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class LanguagesList {
  List<Language> _languages;

  LanguagesList() {
    this._languages = [
      new Language(
          '', "en", "English", "English", "assets/images/logo_circle.png"),
      new Language(
          '', "ar", "Arabic", "العربية", "assets/images/logo_circle.png"),
      new Language(
          '', "ur", "Kurdish", "کورد", "assets/images/logo_circle.png")
    ];
  }

  List<Language> get languages => _languages;
}
