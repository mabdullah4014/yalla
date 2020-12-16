import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/repo/settings_repository.dart' as settingRepo;

class Language {
  String code;
  String englishName;
  String localName;
  String flag;
  bool selected;

  Language(this.code, this.englishName, this.localName, this.flag,
      {this.selected = false});
}

class LanguagesList {
  List<Language> _languages;

  LanguagesList() {
    _languages = [
      new Language("en", "English", "English", "assets/images/logo_circle.png",
          selected: currentUser.value.locale == 'en'),
      new Language("ar", "Arabic", "العربية", "assets/images/logo_circle.png",
          selected: currentUser.value.locale == 'ar'),
      new Language("ur", "Kurdish", "کوردی", "assets/images/logo_circle.png",
          selected: currentUser.value.locale == 'ur')
    ];
  }

  List<Language> get languages => _languages;
}
