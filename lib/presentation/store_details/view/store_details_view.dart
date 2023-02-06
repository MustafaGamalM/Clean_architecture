import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app/di.dart';
import 'package:shop_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:shop_app/presentation/common/widgets/shared_widget.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';
import 'package:shop_app/presentation/store_details/viewmodel/store_details_viewmodel.dart';

import '../../../domain/model/models.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({super.key});

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

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
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        title: Text(AppStrings.storeDetails.tr(),
            style: Theme.of(context).textTheme.titleSmall),
        centerTitle: true,
        elevation: AppSize.s1,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, () {
                _viewModel.start();
              }, _getContentWidget()) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<StoreDetails>(
        stream: _viewModel.outputStoreDetailsObject,
        builder: (context, snapshot) {
          return _getItems(snapshot.data);
        },
    );
  }

  Widget _getItems(StoreDetails? storeDetails) {
    if (storeDetails != null) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: AppPadding.p8, right: AppPadding.p8, top: AppPadding.p18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getImageWidget(storeDetails.image),
              const SizedBox(
                height: AppSize.s20,
              ),
              getSection(AppStrings.details.tr(), context),
              const SizedBox(
                height: AppSize.s8,
              ),
              _getsText(storeDetails.details),
              const SizedBox(
                height: AppSize.s8,
              ),
              getSection(AppStrings.services.tr(), context),
              const SizedBox(
                height: AppSize.s8,
              ),
              _getsText(storeDetails.services),
              const SizedBox(
                height: AppSize.s8,
              ),
              getSection(AppStrings.aboutStore.tr(), context),
              const SizedBox(
                height: AppSize.s8,
              ),
              _getsText(storeDetails.about),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getImageWidget(String image) {
    return SizedBox(
      width: double.infinity,
      height: AppSize.s140,
      child: Image.network(image, fit: BoxFit.cover),
    );
  }

  _getsText(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
