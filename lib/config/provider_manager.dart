import 'package:beyond_user/view_modle/locale_model.dart';
import 'package:beyond_user/view_modle/theme_model.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:provider/provider.dart';


List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildCloneableWidget> independentServices = [
//  Provider.value(value: Api())
  ChangeNotifierProvider<ThemeModel>.value(value: ThemeModel()),
  ChangeNotifierProvider<LocaleModel>.value(value: LocaleModel()),
  ChangeNotifierProvider<UserModel>.value(value: UserModel())
];

/// 需要依赖的model
List<SingleChildCloneableWidget> dependentServices = [
//  ProxyProvider<Api, AuthenticationService>(
//    builder: (context, api, authenticationService) =>
//        AuthenticationService(api: api),
//  )
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
