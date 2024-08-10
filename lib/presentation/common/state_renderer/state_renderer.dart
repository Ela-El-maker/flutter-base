import 'package:flutter/material.dart';
import 'package:initial/data/mapper/mapper.dart';
import 'package:initial/data/network/failure.dart';
import 'package:initial/presentation/resources/assets_manager.dart';
import 'package:initial/presentation/resources/color_manager.dart';
import 'package:initial/presentation/resources/font_manager.dart';
import 'package:initial/presentation/resources/strings_manager.dart';
import 'package:initial/presentation/resources/styles_manager.dart';
import 'package:initial/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  //pop up states
  POPUP_LOADING_STATE,
  POPOUP_ERROR_STATE,
  // full screeen states
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,

  CONTENT_SCREEN_STATE, // UI OF SCREEN
  EMPTY_SCREEN_STATE, // EMPTY VIEW RECEIVED
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;

  String message;
  String title;
  Function? retryActionFunction;

  StateRenderer(
      {
       Key? key,
      required this.stateRendererType,
      String? message,
      String? title,
      required this.retryActionFunction
    }) :

    message= message ?? AppStrings.loadingText,
    title = title ?? EMPTY,
    
    
    super(key:key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context)
  {
    switch(stateRendererType)
    {
      
      case StateRendererType.POPUP_LOADING_STATE:
        // TODO: Handle this case.
        return _getPopUpDialog(
          context,
          [
            _getAnimatedImage(JsonAssets.loading),
          ]
        );
      case StateRendererType.POPOUP_ERROR_STATE:
        // TODO: Handle this case.
        return _getPopUpDialog(context,[
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message), 
          _getRetryButton(AppStrings.oK, context),
        ]);

      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        // TODO: Handle this case.
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.error), _getMessage(message)]);
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        // TODO: Handle this case.
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.error), 
          _getMessage(message), 
          _getRetryButton(AppStrings.retryAgain, context),
        ]);

      case StateRendererType.CONTENT_SCREEN_STATE:
        // TODO: Handle this case.
        return Container();

      case StateRendererType.EMPTY_SCREEN_STATE:
        // TODO: Handle this case.
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.empty), 
          _getMessage(message), 
        ]);

        default:
        return Container();
    }
  }


  Widget _getPopUpDialog(BuildContext context, List<Widget> children)
  {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s14),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: AppSize.s12,
              offset: Offset(
                AppSize.s0, 
                AppSize.s12,
              ),
            ),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }


  Widget _getDialogContent(BuildContext context, List<Widget> children)
  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName){
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,

      child: Lottie.asset(animationName),//json image
    );
  }


Widget _getMessage(String message){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: Text(
          message,
          style: getMediumStyle(
            color: ColorManager.black, 
            fontSize: FontSize.s16,
          ),
        ),
      ),
    );
  }


  
Widget _getRetryButton(String buttonTitle, BuildContext context){
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: AppSize.s180,
          child: ElevatedButton(
            
            onPressed: (){
              if(stateRendererType == StateRendererType.FULL_SCREEN_ERROR_STATE){
                retryActionFunction?.call(); // to call the API function gaian to retry
              }else{
                Navigator.of(context).pop(); // popup state error dismiss dialog
              }
            }, 
            child: Text(
              buttonTitle,
            ),
          ),
        ),
      ),
    );
  }

  
  Widget _getItemsInColumn(List<Widget>  children)
  {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
