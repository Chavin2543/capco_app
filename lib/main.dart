import 'package:capco_app/base/themes.dart';
import 'package:capco_app/scene/user/data/models/user_address/address_model.dart';
import 'package:capco_app/scene/user/data/models/user_address/geo_model.dart';
import 'package:capco_app/scene/user/data/models/user_company/company_model.dart';
import 'package:capco_app/scene/user/data/models/user_model.dart';
import 'package:capco_app/scene/user/presentation/bloc/user_bloc.dart';
import 'package:capco_app/scene/user/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'dependecy_injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  _registerAdapter();
  await di.inject();
  runApp(const CapcoApp());
}

void _registerAdapter() {
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(AddressModelAdapter());
  Hive.registerAdapter(CompanyModelAdapter());
  Hive.registerAdapter(GeoModelAdapter());
}

class CapcoApp extends StatelessWidget {
  const CapcoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => di.injector<UserBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.appTheme,
        title: 'CAPCO App',
        home: const HomeScreen(),
      ),
    );
  }
}