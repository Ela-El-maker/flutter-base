import 'dart:async';

import 'package:initial/presentation/base/baseViewModel.dart';
import 'package:initial/presentation/onboarding/onboarding.dart';

import '../resources/assets_manager.dart';
import '../resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnboardingViewModelInputs, OnboardingViewModelOutputs {
  // stream controllers
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
  }

  @override
  void start() {
    // TODO: implement start
    _list = _getSliderData();
    // send this slider data to our view
    _postDataToView();
  }

  @override
  int goNext() {
    // TODO: implement goNext
    int nextIndex = _currentIndex++;
    if (nextIndex >= _list.length) {
      _currentIndex = 0; // first item in the slider list
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    // TODO: implement goPrevious
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex =
          _list.length - 1; // Infiniete loop to go to the length of slider list
    }
   

    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged
    _currentIndex = index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SliderViewObject) => SliderViewObject);

//private functions
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4),
      ];
  _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(_list[_currentIndex], _list.length, _currentIndex),
    );
  }
}

// inputs mean the orders that our view model will receive from our views
mixin OnboardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe right
  void goPrevious(); // when user clicks left arrow or swipe left
  void onPageChanged(int index);

  Sink
      get inputSliderViewObject; // This is the way to add data to the stream. . stream input
}

// outputs means data or results taht will be sent from our view model to view
mixin OnboardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;
  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
