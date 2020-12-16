import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_form_bloc/src/utils/utils.dart';
import 'package:form_bloc/form_bloc.dart';

// ignore_for_file: implementation_imports

class AnyFieldBlocBuilder<T> extends StatefulWidget {
  const AnyFieldBlocBuilder(
      {Key key,
      @required this.inputFieldBloc,
      @required this.builder,
      this.enableOnlyWhenFormBlocCanSubmit = false,
      this.isEnabled = true,
      this.errorBuilder,
      this.padding,
      this.decoration = const InputDecoration(border: InputBorder.none),
      this.onPick,
      this.animateWhenCanShow = true,
      this.showClearIcon = true,
      this.clearIcon,
      this.nextFocusNode,
      this.focusNode})
      : assert(enableOnlyWhenFormBlocCanSubmit != null),
        assert(isEnabled != null),
        super(key: key);

  final InputFieldBloc<T, Object> inputFieldBloc;
  final FieldBlocErrorBuilder errorBuilder;
  final bool enableOnlyWhenFormBlocCanSubmit;
  final bool isEnabled;
  final EdgeInsetsGeometry padding;
  final InputDecoration decoration;
  final bool animateWhenCanShow;
  final FocusNode nextFocusNode;
  final FocusNode focusNode;
  final bool showClearIcon;
  final Icon clearIcon;
  final BlocWidgetBuilder builder;
  final Future<T> Function(BuildContext context) onPick;

  @override
  AnyFieldBlocBuilderState createState() => AnyFieldBlocBuilderState();
}

class AnyFieldBlocBuilderState<T> extends State<AnyFieldBlocBuilder<T>> {
  FocusNode _focusNode = FocusNode();

  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  @override
  void initState() {
    _effectiveFocusNode.addListener(_onFocusRequest);
    super.initState();
  }

  @override
  void dispose() {
    _effectiveFocusNode.removeListener(_onFocusRequest);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusRequest() {
    if (_effectiveFocusNode.hasFocus) {
      _showPicker(context);
    }
  }

  void _showPicker(BuildContext context) async {
    if (_showPicker == null) {
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    var result = await widget.onPick(context);

    if (result != null) {
      fieldBlocBuilderOnChange<T>(
        isEnabled: widget.isEnabled,
        nextFocusNode: widget.nextFocusNode,
        onChanged: (value) {
          widget.inputFieldBloc.updateValue(value);
        },
      )(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.inputFieldBloc == null) {
      return SizedBox();
    }

    return Focus(
      focusNode: _effectiveFocusNode,
      child: CanShowFieldBlocBuilder(
        fieldBloc: widget.inputFieldBloc,
        animate: widget.animateWhenCanShow,
        builder: (context, canShow) {
          return BlocBuilder<InputFieldBloc<T, Object>,
                  InputFieldBlocState<T, Object>>(
              cubit: widget.inputFieldBloc,
              builder: (context, state) {
                final isEnabled = fieldBlocIsEnabled(
                  isEnabled: this.widget.isEnabled,
                  enableOnlyWhenFormBlocCanSubmit:
                      widget.enableOnlyWhenFormBlocCanSubmit,
                  fieldBlocState: state,
                );

                return DefaultFieldBlocBuilderPadding(
                  padding: widget.padding,
                  child: GestureDetector(
                    onTap: !isEnabled ? null : () => _showPicker(context),
                    child: InputDecorator(
                      decoration: _buildDecoration(context, state, isEnabled),
                      isEmpty: state.value == null &&
                          widget.decoration.hintText == null,
                      child: widget.builder(context, state),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  InputDecoration _buildDecoration(BuildContext context,
      InputFieldBlocState<T, Object> state, bool isEnabled) {
    InputDecoration decoration = this.widget.decoration;

    decoration = decoration.copyWith(
      enabled: isEnabled,
      errorText: Style.getErrorText(
        context: context,
        errorBuilder: widget.errorBuilder,
        fieldBlocState: state,
        fieldBloc: widget.inputFieldBloc,
      ),
      suffixIcon: decoration.suffixIcon ??
          (widget.showClearIcon && widget.inputFieldBloc.state.value != null
              ? AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity:
                      widget.inputFieldBloc.state.value == null ? 0.0 : 1.0,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(25),
                    child: widget.clearIcon ?? Icon(Icons.clear),
                    onTap: widget.inputFieldBloc.state.value == null
                        ? null
                        : widget.inputFieldBloc.clear,
                  ),
                )
              : null),
    );

    return decoration;
  }
}
