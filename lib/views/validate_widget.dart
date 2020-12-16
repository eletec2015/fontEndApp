// import 'package:form_field_validator/form_field_validator.dart';

// class CustomValidator<T> extends FieldValidator<T> {
//   CustomValidator(String errorText) : super(errorText);

//   @override
//   bool isValid(T value) {
//     return errorText != null;
//   }
// }

// import 'package:flutter/material.dart';

// String customValidator(dynamic errors) {
//   if (errors != null) {
//     if (errors is Iterable) {
//       for (String validator in errors) {
//         return validator;
//       }
//     } else {
//       return errors;
//     }
//   }

//   return null;
// }

// class CustomMultiValidator extends FieldValidator {
//   final List<FieldValidator> validators;
//   final dynamic errors;
//   static String _errorText = '';

//   CustomMultiValidator({this.validators, this.errors}) : super(_errorText);

//   @override
//   bool isValid(value) {
//     if (validators != null) {
//       for (FieldValidator validator in validators) {
//         if (!validator.isValid(value)) {
//           _errorText = validator.errorText;
//           return false;
//         }
//       }
//     }

//     if (errors != null) {
//       if (errors is Iterable) {
//         for (String validator in errors) {
//           _errorText = validator;
//           return false;
//         }
//       } else {
//         _errorText = errors;
//         return false;
//       }
//     }

//     return true;
//   }

//   @override
//   String call(dynamic value) {
//     return isValid(value) ? null : _errorText;
//   }
// }
