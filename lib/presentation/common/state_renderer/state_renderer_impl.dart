import 'package:flutter/material.dart';
import 'package:initial/data/mapper/mapper.dart';
import 'package:initial/presentation/common/state_renderer/state_renderer.dart';
import 'package:initial/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading state(PopUp, full screen)

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loadingText;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error state (POPUP,full,loading)

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content State
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

// Empty State
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (this.runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            // showing popup dialog
            showPopUp(
              context,
              getStateRendererType(),
              getMessage(),
            );
            // return the content ui of the screen
            return contentScreenWidget;
          } else //StateRendererType.FULL_SCREEN_LOADING_STATE
          {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(), 
              retryActionFunction: retryActionFunction,
              
            );
          }
         
        }

      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPOUP_ERROR_STATE) {
            // showing popup dialog
            showPopUp(
              context,
              getStateRendererType(),
              getMessage(),
            );
            // return the content ui of the screen
            return contentScreenWidget;
          } else //StateRendererType.FULL_SCREEN_ERROR_STATE
          {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(), 
              retryActionFunction: retryActionFunction,
              
            );
          }
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      case EmptyState:
        {
                    return StateRenderer(
                    stateRendererType: getStateRendererType(),
                    message: getMessage(), 
                    retryActionFunction: retryActionFunction,
                  );

        }
      default:
        {
                    return contentScreenWidget;

        }
    }
  }

  dismissDialog(BuildContext context)
  {
    if(_isThereCurrentDialogShowing(context)){
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context)=>ModalRoute.of(context)?.isCurrent != true;


  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
          stateRendererType: stateRendererType,
          message: message,
          retryActionFunction: () {},
        ),
      ),
    );
  }
}
