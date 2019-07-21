import 'package:acs_app/AUTHENTICATION/REGISTER/LOGIC/enums.dart';

class EnumTranslator{
  degree([DegreeType degreetype]){
    switch (degreetype) {
      case DegreeType.DOCTORAL:
        return "Doctoral";
        break;
        case DegreeType.MASTERS:
        return "Masters";
        break;
      default:
        return "Under graduate";
        break;
    }
  }
  collegeYear([CollegeYear year])
  {
     switch (year) {
      case CollegeYear.FIFTH:
        return "5th Year";
        break;
        case CollegeYear.FORTH:
        return "4th Year";
        break;
         case CollegeYear.THIRD:
        return "3rd Year";
        break;
         case CollegeYear.SECOND:
        return "2nd Year";
        break;

      default:
        return "1st";
        break;
    }
  }
}