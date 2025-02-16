import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../cubits/get_weather_cubit/get_weather_cubit.dart';
import '../cubits/get_weather_cubit/get_weather_state.dart';
import '../utils/constants.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';
import 'custom_model_bottom_sheet.dart';

class CustomSearchButton extends StatelessWidget {
  const CustomSearchButton({
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
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _cityController.clear();
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: AppColors.kBackgroundColor,
              builder: (context) => CustomModelBottomSheet(
                size: size,
                cityController: _cityController,
              ),
            );
          },
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/location.svg',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: context.setWidth(22),
                height: context.setHeight(22),
              ),
              SizedBox(width: context.setWidth(8)),
              Text(
                state is WeatherLoadedState
                    ? (state.weatherModel.cityName.length > 15
                        ? '${state.weatherModel.cityName.substring(0, 18)}...'
                        : state.weatherModel.cityName)
                    : "Enter a city",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.setSp(20),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: context.setWidth(8)),
              SvgPicture.asset(
                'assets/icons/bottom_arrow.svg',
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: context.setWidth(18),
                height: context.setHeight(18),
              ),
            ],
          ),
        );
      },
    );
  }
}
