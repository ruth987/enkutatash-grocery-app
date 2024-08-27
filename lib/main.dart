  import 'package:enk_asses/bloc_observer.dart';
  import 'package:enk_asses/features/glocery/data_layer/model/grocery_model.dart';
  import 'package:enk_asses/features/glocery/domain/usecase/get_groceries_usecase.dart';
  import 'package:enk_asses/features/glocery/presentation/bloc/food_bloc.dart';
  import 'package:enk_asses/features/glocery/presentation/bloc/food_event.dart';
  import 'package:enk_asses/features/glocery/presentation/pages/basket_page.dart';
  import 'package:enk_asses/features/glocery/presentation/pages/detail_page.dart';
  import 'package:enk_asses/features/glocery/presentation/pages/home_page.dart';
  import 'package:enk_asses/service_locator.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_native_splash/flutter_native_splash.dart';

  void main() {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
    
    init();
    Bloc.observer = AppBlocObserver();
    runApp(MainApp());
  }

  class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
      FlutterNativeSplash.remove();
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FoodBloc(
              getGroceriesUsecase: getIt<GetGroceriesUsecase>(),
            )..add(FetchFoodEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/detail': (context) => DetailPage(
              groceryModel: ModalRoute.of(context)!.settings.arguments as GroceryModel,
            ),
            '/basket': (context) => const BasketPage(),
          },
        ),
      );
    }
  }
