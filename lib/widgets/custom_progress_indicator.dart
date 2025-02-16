import 'package:flutter/cupertino.dart';

import '../utils/constants.dart';
import '../utils/responsive_helpers/sizer_helper_extension.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        color: AppColors.kPurpleColor,
        radius: context.setMinSize(32),
      ),
    );
  }
}
