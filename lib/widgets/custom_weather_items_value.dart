import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubits/get_weather_cubit/get_weather_cubit.dart';
import '../cubits/get_weather_cubit/get_weather_state.dart';
import '../utils/constants.dart';
import '../utils/responsive_helpers/size_provider.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';
import 'main_card_items.dart';

class CustomWeatherItemsValue extends StatelessWidget {
  const CustomWeatherItemsValue({
    super.key,
  });

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
              padding: EdgeInsets.all(context.setMinSize(20)),
              margin: EdgeInsets.symmetric(horizontal: context.setMinSize(12)),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.7),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kGreyColor.withValues(alpha: 0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/air_quality.svg',
                        colorFilter: ColorFilter.mode(
                          AppColors.kPrimaryColor,
                          BlendMode.srcIn,
                        ),
                        width: context.setWidth(40),
                      ),
                      SizedBox(width: context.setWidth(12)),
                      Text(
                        'Air Quality',
                        style: TextStyle(
                          color: AppColors.kPurpleColor,
                          fontWeight: FontWeight.w500,
                          fontSize: context.setSp(26),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.setWidth(12)),
                  Row(
                    children: [
                      MainCardItems(
                        value: state is WeatherLoadedState
                            ? state.weatherModel.feelsLike.round()
                            : 0,
                        unit: ' °',
                        imageUrl: 'assets/icons/real_feel.svg',
                        valueType: 'Real Feel',
                      ),
                      Spacer(),
                      MainCardItems(
                        value: state is WeatherLoadedState
                            ? state.weatherModel.windSpeed.round()
                            : 0,
                        unit: ' km/h',
                        imageUrl: 'assets/icons/wind.svg',
                        valueType: 'Wind',
                      ),
                      Spacer(),
                      MainCardItems(
                        value: state is WeatherLoadedState
                            ? state.weatherModel.humidity.round()
                            : 0,
                        unit: '%',
                        imageUrl: 'assets/icons/humidity.svg',
                        valueType: 'Humidity',
                      ),
                    ],
                  ),
                  SizedBox(height: context.setWidth(12)),
                  Row(
                    children: [
                      MainCardItems(
                        value: state is WeatherLoadedState
                            ? state.weatherModel.rain.round()
                            : 0,
                        unit: '%',
                        imageUrl: 'assets/icons/chance_of_rain.svg',
                        valueType: 'Rain    ',
                      ),
                      Spacer(),
                      MainCardItems(
                        value: state is WeatherLoadedState
                            ? state.weatherModel.uvIndex.toInt()
                            : 0,
                        unit: ' ',
                        imageUrl: 'assets/icons/uv_index.svg',
                        valueType: 'UV Index',
                      ),
                      Spacer(),
                      MainCardItems(
                        value: state is WeatherLoadedState
                            ? state.weatherModel.cloudCover.toInt()
                            : 0,
                        unit: '%',
                        imageUrl: 'assets/icons/cloud_value.svg',
                        valueType: 'Cloud    ',
                      ),
                    ],
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
