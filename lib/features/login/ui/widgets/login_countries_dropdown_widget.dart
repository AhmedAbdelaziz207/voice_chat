import 'package:flutter/material.dart';

class LoginCountriesDropdownWidget extends StatefulWidget {
  const LoginCountriesDropdownWidget({super.key});
  static const List<String> codes = ['+62', '+82', '+1'];

  @override
  State<LoginCountriesDropdownWidget> createState() => _LoginCountriesDropdownWidgetState();
}

class _LoginCountriesDropdownWidgetState extends State<LoginCountriesDropdownWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  DropdownButton(
        value: _selectedIndex,
        items: LoginCountriesDropdownWidget.codes
            .map((e) => DropdownMenuItem(
          value: LoginCountriesDropdownWidget.codes.indexOf(e),
          child: Text(e),
        ))
            .toList(),
        onChanged: (v) {
          _selectedIndex = v ?? 0;
          setState(() {});
        });
  }
}
