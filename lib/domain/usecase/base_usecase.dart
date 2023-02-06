import 'package:dartz/dartz.dart';
import 'package:shop_app/data/network/failure.dart';
 // input come from view model to go to data layer
// output come from data layer to go view model   نتيجة API يعمنا
abstract class BaseUseCase<In,Out>{
  Future<Either<Failure,Out>> execute(In input);
}