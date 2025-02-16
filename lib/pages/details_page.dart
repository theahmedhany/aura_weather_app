import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../cubits/get_weather_cubit/get_weather_cubit.dart';
import '../cubits/get_weather_cubit/get_weather_state.dart';
import '../models/weather_model.dart';
import '../utils/constants.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';
import '../widgets/custom_progress_indicator.dart';
import '../widgets/weather_details_card.dart';

class DetailsPage extends StatelessWidget {
  final String cityName;
  final List<dynamic> weatherData;

  const DetailsPage(
      {super.key, required this.cityName, required this.weatherData});

  Map<String, dynamic> getForecastWeather(int index) {
    if (weatherData.isEmpty || index >= weatherData.length) {
      throw Exception("Invalid index or empty weather data");
    }

    var dayData = weatherData[index]["day"];
    int maxWindSpeed = dayData["maxwind_kph"].toInt();
    int avgHumidity = dayData["avghumidity"].toInt();
    int chanceOfRain = dayData["daily_chance_of_rain"].toInt();
    var parsedDate = DateTime.parse(weatherData[index]["date"]);
    var forecastDate = DateFormat('EEEE, d MMMM').format(parsedDate);

    String weatherName = dayData["condition"]["text"];
    String weatherIcon = "${weatherName.replaceAll(' ', '').toLowerCase()}.png";

    int minTemperature = dayData["mintemp_c"].toInt();
    int maxTemperature = dayData["maxtemp_c"].toInt();

    return {
      'maxWindSpeed': maxWindSpeed,
      'avgHumidity': avgHumidity,
      'chanceOfRain': chanceOfRain,
      'forecastDate': forecastDate,
      'weatherName': weatherName,
      'weatherIcon': weatherIcon,
      'minTemperature': minTemperature,
      'maxTemperature': maxTemperature,
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit()..getWeather(cityName),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            'Forecasts',
            style: TextStyle(
              color: AppColors.kPurpleColor,
              fontSize: context.setSp(24),
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.kBackgroundColor,
          elevation: 0.0,
          leading: Padding(
            padding: EdgeInsets.only(left: context.setMinSize(8)),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(
                'assets/icons/back_arrow.svg',
                colorFilter: ColorFilter.mode(
                  AppColors.kPurpleColor,
                  BlendMode.srcIn,
                ),
                width: context.setWidth(40),
                height: context.setHeight(40),
              ),
            ),
          ),
        ),
        body: BlocBuilder<GetWeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherInitialState) {
              return CustomProgressIndicator();
            } else if (state is WeatherLoadedState) {
              return _buildWeatherDetails(
                  weather: state.weatherModel, context: context);
            } else {
              return CustomProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWeatherDetails(
      {required BuildContext context, required WeatherModel weather}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.setMinSize(14)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.setHeight(20)),
            WeatherDetailsCard(
              forecastData: getForecastWeather(0),
              isToday: true,
            ),
            WeatherDetailsCard(
              forecastData: getForecastWeather(1),
              isToday: false,
            ),
            WeatherDetailsCard(
              forecastData: getForecastWeather(2),
              isToday: false,
            ),
            WeatherDetailsCard(
              forecastData: getForecastWeather(3),
              isToday: false,
            ),
            WeatherDetailsCard(
              forecastData: getForecastWeather(4),
              isToday: false,
            ),
            WeatherDetailsCard(
              forecastData: getForecastWeather(5),
              isToday: false,
            ),
            WeatherDetailsCard(
              forecastData: getForecastWeather(6),
              isToday: false,
            ),
            SizedBox(height: context.setHeight(20)),
          ],
        ),
      ),
    );
  }
}
