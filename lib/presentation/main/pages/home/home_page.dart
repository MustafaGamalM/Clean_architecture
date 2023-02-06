import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/di.dart';
import 'package:shop_app/domain/model/models.dart';
import 'package:shop_app/presentation/main/pages/home/home_viewmodel.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/routes_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

import '../../../common/state_renderer/state_renderer_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }
  _bind() {
    _viewModel.start();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SingleChildScrollView(
      child: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot?.data?.getScreenWidget(context, () {
               return _viewModel.start();
              }, _getContentWidget()) ??
              _getContentWidget();
        },
      ),
    ));
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
      stream: _viewModel.outputHomeObject,
      builder: (context, snapshot) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getBannerWidget(snapshot.data?.banners),
          //_getBannersCarousel(),
          _getSection(AppStrings.services.tr()),
        //  _getServices(),
          _getServiceWidget(snapshot.data?.services),
          _getSection(AppStrings.stores.tr()),
         // _getStores(),
          _getStoreWidget(snapshot.data?.stores)
        ],
      );
    },);
  }

  // Widget _getBannersCarousel() {
  //   return StreamBuilder<List<BannerAd>>(
  //     stream: _viewModel.outputBanners,
  //     builder: (context, snapshot) {
  //       return _getBannerWidget(snapshot.data);
  //     },
  //   );
  // }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return SizedBox(
          width: double.infinity,
          child: CarouselSlider(
            items: banners
                .map((banner) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s20),
                          side: BorderSide(
                              color: ColorManager.primary, width: AppSize.s1)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s20),
                          child: CachedNetworkImage(
                        imageUrl: banner.image,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      ),
                    ))
                .toList(),
            options: CarouselOptions(
                height: AppSize.s180,
                autoPlay: true,
                enableInfiniteScroll: true,
                enlargeCenterPage: true),
          ));
    } else {
      return Container();
    }
  }

  // Widget _getServices() {
  //   return StreamBuilder<List<Service>>(
  //     stream: _viewModel.outputServices,
  //     builder: (context, snapshot) => _getServiceWidget(snapshot.data),
  //   );
  // }

  Widget _getServiceWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding:
            const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
            height: AppSize.s160,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: services
                  .map(
                    (service) => Card(
                      elevation: AppSize.s1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s20),
                      ),
                      // margin:
                      //     const EdgeInsets.symmetric(vertical: AppMargin.m12),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            child:CachedNetworkImage(
                              imageUrl: service.image,
                              fit: BoxFit.cover,
                              height: AppSize.s120,
                              width: AppSize.s120,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),

                          //  Image.network(service.image,fit: BoxFit.cover,width: AppSize.s120,height: AppSize.s120,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  service.title,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.center,
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            )),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12,
          right: AppPadding.p12,
          top: AppPadding.p12,
          bottom: AppPadding.p12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  // Widget _getStores() {
  //   return StreamBuilder<List<Store>>(
  //     stream: _viewModel.outputStores,
  //     builder: (context, snapshot) {
  //       return _getStoreWidget(snapshot.data);
  //     },
  //   );
  // }
  Widget _getStoreWidget(List<Store>? stores){
    if (stores != null) {
      return Padding(
          padding:
          const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
      child: Flex(direction: Axis.vertical,
      children: [
        GridView.count(
          crossAxisCount: AppSize.s2,
          crossAxisSpacing:AppSize.s8 ,
          mainAxisSpacing: AppSize.s8,
          physics:const ScrollPhysics(),
          shrinkWrap: true,
          children: List.generate(stores.length, (index) {
              return InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                },
                child: Card(elevation: AppSize.s8,child:
                CachedNetworkImage(
                  imageUrl: stores[index].image,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                //Image.network(stores[index].image,fit: BoxFit.cover,)
                ),
              );
          } ),
        )
      ],
      ),
      );}
    else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
