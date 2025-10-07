// import 'dart:io';
// import 'package:flutter/services.dart';
//---------------------------------------------

import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

//--------------------------------------

import 'bloc/Observe/appBlocObserver.dart';
import 'bloc/cubit/Rebuild.dart';
import 'mainBody.dart';

//--------------------------------------

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // ByteData data = await PlatformAssetBundle().load('assets/ca/mindmillo.pem');
  // SecurityContext.defaultContext
  //     .setTrustedCertificatesBytes(data.buffer.asInt8List());

  // Bloc.observer = AppBlocObserver();
  // WidgetsFlutterBinding.ensureInitialized();
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getTemporaryDirectory(),
  // );
  runApp(
    const DefaultTextStyle(
      style: TextStyle(fontFamily: 'NotoSansThai'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<BlocPageRebuild>(
        create: (BuildContext context) =>
            BlocPageRebuild(), //For rebuild only page inside without app bar/left menu
      ),
    ], child: const MainContext());
  }
}

class MainContext extends MyApp {
  const MainContext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocPageRebuild, bool>(
      builder: (_, e) {
        return MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          title: 'EXPORT ALERT',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: const MainBlocRebuild(),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
