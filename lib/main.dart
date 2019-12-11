import 'dart:ui';
import 'package:beyond_user/config/storage_manager.dart';
import 'package:flutter/services.dart';
import 'package:beyond_user/view_modle/user_model.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:beyond_user/config/provider_manager.dart';
import 'package:beyond_user/config/router_config.dart';
import 'package:beyond_user/generated/i18n.dart';
import 'package:beyond_user/view_modle/locale_model.dart';
import 'package:beyond_user/view_modle/theme_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:beyond_user/config/storage_manager.dart';
import 'package:beyond_user/config/app_constans.dart';

/*起始页*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(MyApp());
  //设置状态栏透明
  /*SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);*/
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
            providers: providers,
            child: Consumer2<ThemeModel, LocaleModel>(
                builder: (context, themeModel, localeModel, child) {
              return RefreshConfiguration(
                hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                child: MaterialApp(
                  navigatorKey: AppConstans.navigatorState,
                  debugShowCheckedModeBanner: false,
                  theme: themeModel.themeData,
                  //darkTheme: themeModel.darkTheme,
                  locale: localeModel.locale,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  onGenerateRoute: Router.generateRoute,
                  initialRoute: RouteName.mainpage,
                  //initialRoute: Provider.of<UserModel>(context).user == null ? RouteName.login : RouteName.mainpage,
                  //home: routeWidget(window.defaultRouteName),
                ),
              );
            })));
  }
}
