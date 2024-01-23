import 'package:flutter/material.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';

enum MButtonType { elevated, text }

class MButton extends StatelessWidget {
  const MButton({
    super.key,
    required this.child,
    this.type = MButtonType.elevated,
    this.onPressed,
    this.isLoading = false,
  }) : _isDisabled = onPressed == null || isLoading || false;

  final Widget child;
  final MButtonType type;

  final VoidCallback? onPressed;
  final bool isLoading;
  final bool _isDisabled;

  final Widget loaderWidget = const SizedBox(
    width: 20,
    height: 20,
    child: CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation(Colors.white),
    ),
  );

  Widget _buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isDisabled ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            return AppColors.secondryV6; // Use the color you want
          },
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(AppDimensions.dp12),
        ),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        child: isLoading ? loaderWidget : child,
      ),
    );
  }

  Widget _buildTextButton(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: isLoading ? loaderWidget : child,
        ));
  }

  Widget _buildMButton(BuildContext context) {
    switch (type) {
      case MButtonType.elevated:
        return _buildElevatedButton(context);
      case MButtonType.text:
        return _buildTextButton(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildMButton(context);
  }
}
