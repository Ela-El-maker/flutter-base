enum LanguageType{
  ENGLISH,FRENCH
}

const String FRENCH = "fr";
const String ENGLISH = "en";
extension LanguageTypeExtension on LanguageType{
  String getValue(){
    switch(this){
      
      case LanguageType.ENGLISH:
        // TODO: Handle this case.
        return ENGLISH;
      case LanguageType.FRENCH:
        // TODO: Handle this case.
        return FRENCH;
    }
  }
}