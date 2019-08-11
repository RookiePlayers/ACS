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
   gender([Gender gender]){
    switch (gender) {
      case Gender.MALE:
        return "Male";
        break;
        case Gender.FEMALE:
        return "Female";
        break;
      default:
        return "Male";
        break;
    }
  }
   relationship([Relationship relationship]){
    switch (relationship) {
      case Relationship.SINGLE:
        return "Single";
        break;
        case Relationship.TAKEN:
        return "In a Relationship";
        break;
      default:
        return "Single";
        break;
    }
  }
    relationship_bool([Relationship relationship]){
    switch (relationship) {
      case Relationship.SINGLE:
        return true;
        break;
        case Relationship.TAKEN:
        return false;
        break;
      default:
        return false;
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