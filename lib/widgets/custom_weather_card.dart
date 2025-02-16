import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubits/get_weather_cubit/get_weather_cubit.dart';
import '../cubits/get_weather_cubit/get_weather_state.dart';
import '../utils/constants.dart';
import '../utils/responsive_helpers/size_provider.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';
import 'custom_head_row_data.dart';

class CustomWeatherCard extends StatelessWidget {
  const CustomWeatherCard({
    super.key,
    required TextEditingController cityController,
    required this.size,
  }) : _cityController = cityController;

  final TextEditingController _cityController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeatherCubit, WeatherState>(
      builder: (context, state) {
        return SizeProvider(
          baseSize: Size(250, 250),
          width: context.setMinSize(250),
          height: context.setMinSize(250),
          child: Builder(builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(
                vertical: context.setMinSize(10),
                horizontal: context.setMinSize(10),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: context.setMinSize(12),
                vertical: context.setMinSize(14),
              ),
              decoration: BoxDecoration(
                gradient: AppColors.kPrimaryGradient,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kPurpleColor.withValues(alpha: 0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomHeadRowData(
                    cityController: _cityController,
                    size: size,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setMinSize(8),
                      vertical: context.setMinSize(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: context.setHeight(130),
                          width: context.setWidth(180),
                          child: state is WeatherLoadedState
                              ? Image.asset(
                                  "assets/images/${state.weatherModel.weatherIcon}",
                                )
                              : Image.asset(
                                  "assets/images/heavycloudy.png",
                                ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              state is WeatherLoadedState
                                  ? '${state.weatherModel.temp.toInt()}°'
                                  : "22°",
                              style: TextStyle(
                                fontSize: context.setSp(76),
                                fontWeight: FontWeight.bold,
                                foreground: Paint()
                                  ..shader = AppColors.kFontGradient,
                              ),
                            ),
                            Text(
                              state is WeatherLoadedState
                                  ? 'Feel Like ${state.weatherModel.feelsLike.round()}°'
                                  : "Feel Like 26°",
                              style: TextStyle(
                                fontSize: context.setSp(16),
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.setMinSize(14),
                      vertical: context.setMinSize(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state is WeatherLoadedState
                                  ? state.weatherModel.condition.length > 13
                                      ? "${state.weatherModel.condition.substring(0, 13)}..."
                                      : state.weatherModel.condition
                                  : "Loading...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: context.setSp(30),
                              ),
                            ),
                            Text(
                              DateFormat('EEEE, MMM d').format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.setSp(18),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/images/weather.png',
                          width: context.setWidth(64),
                          height: context.setHeight(64),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
