import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cubits/get_weather_cubit/get_weather_state.dart';
import '../pages/details_page.dart';
import '../utils/constants.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';

class ForecastsHeaderWidget extends StatelessWidget {
  const ForecastsHeaderWidget({super.key, required this.state});

  final WeatherState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Today',
            style: TextStyle(
              color: AppColors.kFontColor,
              fontWeight: FontWeight.bold,
              fontSize: context.setSp(20),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (state is WeatherLoadedState) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsPage(
                      cityName:
                          (state as WeatherLoadedState).weatherModel.cityName,
                      weatherData: (state as WeatherLoadedState)
                          .weatherModel
                          .dailyForecast,
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Forecasts',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: context.setSp(18),
                color: AppColors.kPurpleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
