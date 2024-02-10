import 'package:flutter/material.dart';
import 'package:flutter_app/pages/common/colors.dart';
import 'package:flutter_app/pages/constant/dimensions.dart';
import 'package:flutter_app/widget/space.dart';

class EditableInput extends StatefulWidget {
  final String value;
  final bool isRequired;
  final String label;
  final Function(String value) onSave;
  const EditableInput(
      {Key? key,
      required this.value,
      required this.isRequired,
      required this.onSave,
      required this.label})
      : super(key: key);

  @override
  State<EditableInput> createState() => _EditableInputState();
}

class _EditableInputState extends State<EditableInput> {
  bool isEditable = false;

  String inputValue = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          isEditable
              ? Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      style: TextStyle(color: AppColors.secondryV6),
                      onChanged: (value) {
                        inputValue = value;
                      },
                      initialValue: widget.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (widget.isRequired) {
                          if (value == null || value.isEmpty) {
                            return 'required';
                          }
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: widget.label,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const VerticalSpace(size: AppDimensions.dp10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          focusColor: Colors.red,
                          child: const Icon(
                            Icons.check,
                            size: AppDimensions.dp30,
                            weight: 1,
                          ),
                          onTap: () {
                            setState(() {
                              widget.onSave(inputValue);
                              isEditable = false;
                            });
                          },
                        ),
                        const HorizontalSpace(size: AppDimensions.dp10),
                        InkWell(
                          child: const Icon(
                            Icons.close,
                            size: AppDimensions.dp30,
                          ),
                          onTap: () {
                            setState(() {
                              isEditable = false;
                            });
                          },
                        )
                      ],
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(color: AppColors.secondryV5),
                    ),
                    const VerticalSpace(size: AppDimensions.dp5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.value,
                          style: const TextStyle(
                              fontSize: AppDimensions.dp20,
                              fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.edit_rounded,
                            color: AppColors.secondryV5,
                          ),
                          onTap: () {
                            setState(() {
                              isEditable = true;
                            });
                          },
                        )
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
