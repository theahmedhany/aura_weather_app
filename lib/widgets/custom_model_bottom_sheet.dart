import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/get_weather_cubit/get_weather_cubit.dart';
import '../utils/constants.dart';

class CustomModelBottomSheet extends StatelessWidget {
  const CustomModelBottomSheet({
    super.key,
    required this.size,
    required TextEditingController cityController,
  }) : _cityController = cityController;

  final Size size;
  final TextEditingController _cityController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.2,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 22),
            TextField(
              onChanged: (value) async {
                var getWeatherCubit = BlocProvider.of<GetWeatherCubit>(context);
                await getWeatherCubit.getWeather(value);
              },
              controller: _cityController,
              autofocus: true,
              style: const TextStyle(
                color: AppColors.kPurpleColor,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.kPrimaryColor,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _cityController.clear();
                    Navigator.pop(context);
                  },
                  child: Icon(
                    _cityController.text.isEmpty
                        ? Icons.close_rounded
                        : Icons.check_rounded,
                    color: AppColors.kPrimaryColor,
                  ),
                ),
                hintText: 'Search city e.g. London',
                hintStyle: TextStyle(
                  color: AppColors.kPurpleColor,
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: AppColors.kPurpleColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: AppColors.kPurpleColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
