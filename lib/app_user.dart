import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loadserv_task/cart/presentation/manager/cart_cubit.dart';
import 'package:loadserv_task/common/presentation/ui/app_responsive/app_responsive_scaled_box.dart';
import 'package:loadserv_task/common/presentation/ui/app_responsive/mediaquery_scale_overrider.dart';
import 'package:loadserv_task/common/presentation/ui/rotate_screen.dart';
import 'package:loadserv_task/common/presentation/utils/app_style/app_colors.dart';
import 'package:loadserv_task/product/presentation/manager/category_cubit.dart';
import 'package:loadserv_task/product/presentation/ui/category_details_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'common/base/localization/app_languages.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TheAppUser extends StatefulWidget {

  const TheAppUser({super.key});

  @override
  State<TheAppUser> createState() => _TheAppUserState();
}

class _TheAppUserState extends State<TheAppUser> {
  @override
  void initState() {
    PaintingBinding.instance.imageCache.maximumSizeBytes =
        500 * 1024 *1024; //200 MB
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RotateScreenContainer(
      child: DevicePreview(
        enabled: false,
        builder: (BuildContext context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => CategoryCubit()..getCategoryDetails()),
              BlocProvider(create: (context) => CartCubit()),
            ],
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: DevicePreview.appBuilder(
                context,
                MaterialApp(
                  key: ValueKey('en'),
                  debugShowCheckedModeBanner: false,
                  color: AppColors.grayColor,
                  navigatorKey: navigatorKey,
                  navigatorObservers: [
                    // NestedNavObserver.instance,
                  ],
                  theme: ThemeData(
                    fontFamily: 'NotoSans',
                    primaryColor: Colors.white,
                    bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor:Colors.white,
                      surfaceTintColor: Colors.white,
                    ),
                    useMaterial3: false,
                    dialogTheme: const DialogTheme(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,

                    ),
                    scaffoldBackgroundColor: Colors.white,
                    canvasColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.transparent,
                    ),
                  ),
                  locale: Locale("en"),
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppLanguages.supportedLocales,
                  title: "Ajmal",
                  builder: (context, child) {
                    return ScrollConfiguration(
                      behavior: RemoveScrollGlow(),

                      child: ResponsiveBreakpoints.builder(
                        breakpoints: [
                          const Breakpoint(start: 0, end: 450, name: MOBILE),
                          const Breakpoint(start: 451, end: 800, name: TABLET),
                          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                          const Breakpoint(
                              start: 1921,
                              end: double.infinity,
                              name: '4K'),
                        ],
                        child: MediaQueryScaleOverrider(

                                child: child!
                        ),
                      ),
                    );
                  },
                  initialRoute: '/',

                  onGenerateRoute: (settings) {

                    RouteInfoModel? routeInfo =
                    settings.arguments as RouteInfoModel?;

                    PageRoute pageRoute;
                    Widget page;
                    String? routeName = settings.name;

                    //set main page
                    if (routeName == '/') {
                      page = const CategoryDetailsPage();
                    } else {
                      assert(routeInfo?.page != null); //route info can not be null here
                      page = routeInfo!.page;
                    }
                    //set responsive scaled box on the page
                    page = AppResponsiveScaledBox(
                      calculateMediaQuery: false,
                      child: page,
                    );

                    //set page route if passed
                    if (routeInfo?.materialPageRoute != null) {
                      pageRoute = routeInfo!.materialPageRoute!(page);
                    } else {
                      pageRoute = MaterialPageRoute(
                        settings: RouteSettings(name: routeName),
                        builder: (context) {
                          return page;
                        },
                      );
                    }

                    return pageRoute;
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// very important when you decide to another page and you already playing video or sound
// then you need to dispose based on push

class RemoveScrollGlow extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
class RouteInfoModel {
  final Widget page;
  final PageRoute Function(Widget child)? materialPageRoute;

  const RouteInfoModel({
    required this.page,
    this.materialPageRoute,
  });
}