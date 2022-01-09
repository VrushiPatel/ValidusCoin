part of 'main_bloc.dart';

// events
@immutable
abstract class MainEvent {}

// this displays error message
class ShowError extends MainEvent {}

// This will be used for showing welcome screen
class WelcomeIn extends MainEvent {
  WelcomeIn();
}

class ShowProfile extends MainEvent {
  ShowProfile();
}

class AddEditProfile extends MainEvent {
  final String key;
  final BuildContext context;
  final Function onReturn;

  AddEditProfile(this.key, this.context, this.onReturn);
}
