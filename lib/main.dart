import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'routes/app_pages.dart';
import 'shared/color_shared.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return GetMaterialApp(
            theme: ThemeData(
              textTheme: Theme.of(context).textTheme,
              fontFamily: GoogleFonts.lato().toString(),
              primaryColor: primaryColor,
              hintColor: const Color(0xffcdd3e0),
              dividerColor: Colors.grey[100],
              scaffoldBackgroundColor: whiteColor,
              colorScheme: const ColorScheme.light(
                primary: primaryColor,
                secondary: secondaryColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(primaryColor),
                ),
              ),
            ),
            initialRoute: AppPages.initialPage,
            getPages: AppPages.pageList,
          );
        },
      );
}
