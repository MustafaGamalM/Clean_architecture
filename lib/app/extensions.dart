
import 'package:shop_app/app/constatnts.dart';

extension NonNullString on String? {
  String orEmpty(){
    if(this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int orZero(){
    if(this == null) {
      return Constants.zero;
    } else {
      return this!;
    }
  }
}
