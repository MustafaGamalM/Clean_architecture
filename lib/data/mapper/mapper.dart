import '../../app/constatnts.dart';
import '../../domain/model/models.dart';
import '../responses/responses.dart';
import 'package:shop_app/app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse?{
  Customer toDomain(){
    return Customer(this?.id.orEmpty() ??Constants.empty ,this?.name.orEmpty() ??Constants.empty ,this?.numOfNotifications.orZero() ??Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse?{
  Contacts toDomain(){
    return Contacts(this?.phone.orEmpty() ??Constants.empty ,this?.email.orEmpty() ??Constants.empty ,this?.link.orEmpty() ??Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse?
{
  Authentication toDomain()
  {
    return Authentication(this?.customer.toDomain() , this?.contacts.toDomain());
  }
}

extension ForegetPasswordMapper on ForgetPasswordResponse?
{
  ForgetPassword toDomain(){
    return ForgetPassword(this?.support.orEmpty() ??Constants.empty);
  }
}

extension ServiceResponeMapper on ServiceResponse {
  Service toDomain(){
    return Service(this?.id.orZero()?? Constants.zero, this?.title.orEmpty()?? Constants.empty, this?.image.orEmpty()?? Constants.empty);
  }
}

extension BannerResponeMapper on BannerResponse {
  BannerAd toDomain(){
    return BannerAd(this?.id.orZero() ?? Constants.zero, this?.title.orEmpty()?? Constants.empty, this?.image.orEmpty()?? Constants.empty, this?.link.orEmpty()?? Constants.empty);
  }
}

extension StoreResponeMapper on StoreResponse {
  Store toDomain(){
    return Store(this?.id.orZero() ?? Constants.zero, this?.title.orEmpty()?? Constants.empty, this?.image.orEmpty()?? Constants.empty);
  }
}

extension HomeResponeMapper on HomeResponse {
  HomeObject toDomain(){
    List<Service> services = (this?.data?.services?.map((serviceResponse) =>serviceResponse.toDomain())?? const Iterable.empty()).cast<Service>().toList();
    List<BannerAd> banners = (this?.data?.banners?.map((bannerResponse) =>bannerResponse.toDomain())?? const Iterable.empty()).cast<BannerAd>().toList();
    List<Store> stores = (this?.data?.stores?.map((storeResponse) =>storeResponse.toDomain())?? const Iterable.empty()).cast<Store>().toList();

    var data=HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension StoreDetailsMapper on StoreDetailsResponse{
  StoreDetails toDomain(){
    return  StoreDetails(this?.image.orEmpty() ??Constants.empty, this?.id.orZero() ??Constants.zero, this?.title.orEmpty() ??Constants.empty, this?.details.orEmpty() ??Constants.empty,
        this?.services.orEmpty() ??Constants.empty, this?.about.orEmpty() ??Constants.empty);
  }
}