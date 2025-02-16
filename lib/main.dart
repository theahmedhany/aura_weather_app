import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/get_weather_cubit/get_weather_cubit.dart';
import 'cubits/get_weather_cubit/get_weather_state.dart';
import 'pages/home_page.dart';
import 'utils/responsive_helpers/size_provider.dart';
import 'utils/responsive_helpers/sizer_helper_extension.dart';
import 'widgets/network_connection.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (context) => BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            return SizeProvider(
              baseSize: const Size(360, 690),
              height: context.screenHeight,
              width: context.screenWidth,
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                builder: (context, child) {
                  return NetworkConnection(child: child!);
                },
                home: const HomePage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
