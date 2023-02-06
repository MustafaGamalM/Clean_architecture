import 'package:shop_app/data/network/error_handler.dart';
import 'package:shop_app/data/responses/responses.dart';

const String cachedHomeData = "CACHED_HOME_DATA";
const int expirationTime = 60000;
abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCache();
  void removeFromCache();
}

class LocalDataSourceImpl implements LocalDataSource {

  // run time cache

  Map<String, CachedItem> cashedMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem =  cashedMap[cachedHomeData];
   if(cachedItem != null && cachedItem.isValid(expirationTime))
     {
       return cachedItem.data;
     }else{
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
   }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cashedMap[cachedHomeData] = CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cashedMap.clear();
  }

  @override
  void removeFromCache() {
    cashedMap.remove(cachedHomeData);
  }
}

class CachedItem {
  dynamic data;

  int cashedTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem{
  bool isValid(int expirationTime){
    return expirationTime + cashedTime > DateTime.now().millisecondsSinceEpoch;
  }
}
