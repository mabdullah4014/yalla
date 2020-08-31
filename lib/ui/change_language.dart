import 'package:arbi/generated/l10n.dart';
import 'package:arbi/model/language.dart';
import 'package:flutter/material.dart';
import 'package:arbi/repo/settings_repository.dart' as settingRepo;

class ChangeLanguageWidget extends StatefulWidget {
  @override
  _ChangeLanguageWidgetState createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  LanguagesList languagesList;

  @override
  void initState() {
    languagesList = new LanguagesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Text(
            S.of(context).confirm_order,
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(color: Colors.white)),
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: languagesList.languages.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                Language _language = languagesList.languages.elementAt(index);
                settingRepo
                    .getDefaultLanguage(settingRepo
                        .setting.value.mobileLanguage.value.languageCode)
                    .then((_langCode) {
                  if (_langCode == _language.code) {
                    _language.selected = true;
                  }
                });
                return InkWell(
                  onTap: () async {
                    settingRepo.setting.value.mobileLanguage.value =
                        new Locale(_language.code, _language.country);
                    settingRepo.setting.notifyListeners();
                    languagesList.languages.forEach((_l) {
                      setState(() {
                        _l.selected = false;
                      });
                    });
                    _language.selected = !_language.selected;
                    settingRepo.setDefaultLanguage(_language.code);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: <Widget>[
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                image: DecorationImage(
                                    image: AssetImage(_language.flag),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Container(
                              height: _language.selected ? 40 : 0,
                              width: _language.selected ? 40 : 0,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(_language.selected ? 0.85 : 0),
                              ),
                              child: Icon(
                                Icons.check,
                                size: _language.selected ? 24 : 0,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(_language.selected ? 0.85 : 0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _language.englishName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                              Text(
                                _language.localName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
