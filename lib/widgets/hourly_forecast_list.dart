import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../cubits/get_weather_cubit/get_weather_state.dart';
import '../utils/responsive_helpers/size_provider.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';
import 'hourly_forecast_item.dart';

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({super.key, required this.state});

  final WeatherState state;

  @override
  Widget build(BuildContext context) {
    return SizeProvider(
      baseSize: Size(65, 160),
      width: context.setMinSize(65),
      height: context.setMinSize(160),
      child: Builder(builder: (context) {
        return Container(
          margin: EdgeInsets.only(left: context.setMinSize(14)),
          height: context.sizeProvider.height,
          child: ListView.builder(
            itemCount: state is WeatherLoadedState
                ? (state as WeatherLoadedState)
                    .weatherModel
                    .hourlyForecast
                    .length
                : 0,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              String currentTimeFormatted =
                  DateFormat('hh a').format(DateTime.now());

              DateTime forecastDateTime = DateTime.parse(
                (state as WeatherLoadedState).weatherModel.hourlyForecast[index]
                    ["time"],
              ).toLocal();
              String forecastTimeFormatted =
                  DateFormat('hh a').format(forecastDateTime);

              String forecastWeatherName = (state as WeatherLoadedState)
                  .weatherModel
                  .hourlyForecast[index]["condition"]["text"];
              String forecastWeatherIcon =
                  "${forecastWeatherName.replaceAll(' ', '').toLowerCase()}.png";
              String forecastTemperature = (state as WeatherLoadedState)
                  .weatherModel
                  .hourlyForecast[index]["temp_c"]
                  .round()
                  .toString();

              return HourlyForecastItem(
                forecastTimeFormatted: forecastTimeFormatted,
                forecastWeatherIcon: forecastWeatherIcon,
                forecastTemperature: forecastTemperature,
                currentTimeFormatted: currentTimeFormatted,
              );
            },
          ),
        );
      }),
    );
  }
}
