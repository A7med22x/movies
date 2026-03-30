import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/resources/color_manager.dart';
import 'package:movies/core/resources/font_manager.dart';
import 'package:movies/core/resources/new_styles_manager.dart';
import 'package:movies/core/resources/styles_manager.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? prefixIconImageName;
  final String? suffixIconImageName;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool isPassword;
  final int maxLines;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIconImageName,
    this.suffixIconImageName,
    this.controller,
    this.onEditingComplete,
    this.onChanged,
    this.validator,
    this.isPassword = false,
    this.maxLines = 1,
    this.readOnly = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        ),
        prefixIcon: widget.prefixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  widget.prefixIconImageName!,
                  colorFilter: ColorFilter.mode(
                    ColorManager.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  isObscure = !isObscure;
                  setState(() {});
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: ColorManager.white,
                ),
              )
            : widget.suffixIconImageName == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  widget.suffixIconImageName!,
                  colorFilter: ColorFilter.mode(
                    ColorManager.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
        fillColor: ColorManager.lightBlack,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.lightBlack),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.lightBlack),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.error),
        ),
      ),
      onEditingComplete: widget.onEditingComplete,
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: isObscure,
      autovalidateMode: .onUserInteraction,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      cursorColor: ColorManager.primary,
      style: NewStylesManager.textstyle16,
    );
  }
}
