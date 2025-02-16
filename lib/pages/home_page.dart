import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/get_weather_cubit/get_weather_cubit.dart';
import '../cubits/get_weather_cubit/get_weather_state.dart';
import '../utils/constants.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';
import '../widgets/custom_weather_card.dart';
import '../widgets/custom_weather_items_value.dart';
import '../widgets/forecasts_header_widget.dart';
import '../widgets/hourly_forecast_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();

  final String cityName = 'Cairo';

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );

    Future.delayed(Duration.zero, () {
      BlocProvider.of<GetWeatherCubit>(context).getWeather(cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kBackgroundColor,
      body: BlocBuilder<GetWeatherCubit, WeatherState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SafeArea(
                  child: CustomWeatherCard(
                    cityController: _cityController,
                    size: size,
                  ),
                ),
                SizedBox(height: context.setHeight(10)),
                CustomWeatherItemsValue(),
                SizedBox(height: context.setHeight(10)),
                ForecastsHeaderWidget(state: state),
                SizedBox(height: context.setHeight(8)),
                HourlyForecastList(state: state),
                SizedBox(height: context.setHeight(10)),
              ],
            ),
          );
        },
      ),
    );
  }
}
