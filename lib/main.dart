import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:good_food_app/features/categories/di/categories_di.dart';
import 'package:provider/provider.dart';

import 'core/localization/provider/app_translations.dart';
import 'core/theme/text_styles/global_text_style.dart';
import 'features/cart/presentation/viewmodel/state_management/provider/cart_provider.dart';
import 'features/categories/provider/categories_provider.dart';
import 'features/di/service_locator.dart';
import 'features/pages/auth/1.splash/splash_screen.dart';
import 'features/products/products_card/provider/products_provider.dart';
import 'features/products/products_card/viewmodel/products_viewmodel.dart';
import 'features/screens/profile/location_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  debugPaintSizeEnabled = false;

  final getIt = GetIt.instance;
  CategoriesDI.init(getIt);

  // Initialize service locator
  await setupProductDependencies();
  // await setupCategoryDependencies();
  await setupCartDependencies();

  // Initialize LOCALIZATION translations
  final translations = AppTranslations();
  await translations.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: translations),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
        ChangeNotifierProvider(create: (_) => getIt<ProductsProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<CategoriesProvider>()),
        ChangeNotifierProvider(create: (_) => getIt<ProductsViewModel>()),
        ChangeNotifierProvider(create: (_) => getIt<CartProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTranslations>(
      builder: (context, translations, _) {
        return MaterialApp(
          title: 'Good Food App',
          debugShowCheckedModeBanner: false,
          // LOCALIZATION defaults
          locale: translations.currentLocale,
          supportedLocales: const [
            Locale('en'), //English
            Locale('hi'), //Hindi
            Locale('te'), //Telugu
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: GlobalTextStyles.interFont,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
