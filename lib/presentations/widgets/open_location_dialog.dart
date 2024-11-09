import 'package:camdell/core/constants/app_button.dart';
import 'package:camdell/core/constants/app_text.dart';
import 'package:camdell/core/constants/size.dart';
import 'package:camdell/meta/utils/app_color.dart';
import 'package:camdell/meta/utils/image_constant.dart';
import 'package:camdell/meta/utils/responsive.dart';
import 'package:camdell/meta/utils/ts.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionDialog extends StatefulWidget {
  final Function() onAllow;
  final Function() onDeny;

  const LocationPermissionDialog({
    super.key,
    required this.onAllow,
    required this.onDeny,
  });

  @override
 State<LocationPermissionDialog> createState() => _LocationPermissionDialogState();
}

class _LocationPermissionDialogState extends State<LocationPermissionDialog> {

  bool _isGpsEnabled = false;
String _selectedOption = 'Precise';
  @override
  void initState() {
    super.initState();
    _checkGpsStatus();
  }

 void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  Future<void> _checkGpsStatus() async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();
    setState(() {
      _isGpsEnabled = isEnabled;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImage.location,height: 25,),
          const Hbox(16),
          AppText(
            'Allow CAMDELL to access this device\'s location?',
            style: Ts.bold10(color: AppColor.black),
            textAlign: TextAlign.center,
          ),
          const Hbox(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLocationOption('Precise', ),
              const Wbox(32),
              _buildLocationOption('Approximate', ),
            ],
          ),
          const SizedBox(height: 24),
          _buildButton('While using the app', widget.onAllow),
          const SizedBox(height: 8),
          _buildButton('Only this time', widget.onAllow),
          const SizedBox(height: 8),
          _buildButton('Don\'t allow', widget.onDeny, outlined: true),
          const Hbox(16),
          
        ],
      ),
    );
  }

  Widget _buildLocationOption(String label, ) {
    bool isSelected = _selectedOption == label;
    return GestureDetector(
      onTap: () => _selectOption(label),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isSelected ? AppColor.primary : Colors.transparent,
              image: DecorationImage(
                image: AssetImage(label == 'Precise' ? AppImage.precise : AppImage.approximate),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: AppColor.primary, width: 2) : null,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: AppColor.black,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildButton(String label, Function() onPressed, {bool outlined = false}) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: AppText(label, style: Ts.medium15(color: AppColor.black),
        ),
      )
    );
  }

 
}