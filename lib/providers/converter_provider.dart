
import 'package:flutter/material.dart';


enum UnitCategory{length, weight, temp}

class ConverterProvider with ChangeNotifier{
  UnitCategory _selectedCategory = UnitCategory.length;


  final Map<UnitCategory, double> _inputValues = {
    UnitCategory.length: 25.0,
    UnitCategory.weight: 40.0,
    UnitCategory.temp: 0.0,
  };

  final Map<UnitCategory, String> _fromUnits = {
    UnitCategory.length: 'Meter',
    UnitCategory.weight: 'Kilogram',
    UnitCategory.temp: 'Celsius',
  };

  final Map<UnitCategory, String> _toUnits = {
    UnitCategory.length: 'Kilometer',
    UnitCategory.weight: 'Gram',
    UnitCategory.temp: 'Fahrenheit',
  };

  final Map<UnitCategory, double> _results = {
    UnitCategory.length: 0.025,
    UnitCategory.weight: 40000.0,
    UnitCategory.temp: 32.0,
  };



  // Getters
UnitCategory get selectedCategory => _selectedCategory;
double get inputValue => _inputValues[_selectedCategory]!;
String get fromUnit => _fromUnits[_selectedCategory]!;
String get toUnit => _toUnits[_selectedCategory]!;
double get result => _results[_selectedCategory]!;

// Units list based on categories
final Map<UnitCategory, List<String>> unitsMAp = {
  UnitCategory.length: ['Meter', 'Kilometer', 'Centimeter', 'Feet','Inch'],
  UnitCategory.weight : ['Kilogram', 'Gram', 'Pound', 'Ounce'],
  UnitCategory.temp: ['Celsius','Fahrenheit', 'Kelvin'],
};

List <String> get currentUnits => unitsMAp[_selectedCategory]!;

void setCategory(UnitCategory category){
  _selectedCategory = category;
  _convert();
  notifyListeners();
}

void setInputValue(String value){
  _inputValues[_selectedCategory] = double.tryParse(value) ?? 0.0;
  _convert();
  notifyListeners();
}

void setFromUnit(String? unit){
  if(unit != null){
    _fromUnits[_selectedCategory] = unit;
    _convert();
    notifyListeners();
  }
}

void setToUnit(String ? unit){
  if(unit != null){
    _toUnits[_selectedCategory] = unit;
    _convert();
    notifyListeners();
  }
}

void swapUnits(){
  final temp = _fromUnits[_selectedCategory];
  _fromUnits[_selectedCategory] = _toUnits[_selectedCategory]!;
  _toUnits[_selectedCategory] = temp!;
  _convert();
  notifyListeners();
}

void _convert(){

  double val = _inputValues[_selectedCategory]!;
  String from = _fromUnits[_selectedCategory]!;
  String to = _toUnits[_selectedCategory]!;

  if(_selectedCategory == UnitCategory.length){
    _results[_selectedCategory] = _convertLength(val, from, to);
  }else if(_selectedCategory == UnitCategory.weight){
    _results[_selectedCategory] = _convertWeight(val, from, to);
  }else if(_selectedCategory == UnitCategory.temp){
    _results[_selectedCategory] = _convertTemp(val, from, to);
  }
}

// Length Conversion Logic
double _convertLength(double val, String from, String to){
  double inMeters = val;
  switch (from){
    case 'Kilometer' : inMeters = val * 1000; break;
    case 'Centimeter' : inMeters = val / 100; break;
    case 'Feet' : inMeters = val / 3.28084; break;
    case 'Inch' : inMeters = val / 39.3701; break;
    default: inMeters = val;
  }
  switch (to){
    case 'Kilometer' : return inMeters / 1000;
    case 'Centimeter' : return inMeters * 100;
    case 'Feet' : return inMeters * 3.28084;
    case 'Inch' : return inMeters * 39.3701;
    default: return inMeters;
  }
}

// Weight Conversion Logic
  double _convertWeight(double val, String from, String to) {
    double inGrams = val;
    switch (from) {
      case 'Kilogram': inGrams = val * 1000; break;
      case 'Pound': inGrams = val * 453.592; break;
      case 'Ounce': inGrams = val * 28.3495; break;
      default: inGrams = val; // Gram
    }

    switch (to) {
      case 'Kilogram': return inGrams / 1000;
      case 'Pound': return inGrams / 453.592;
      case 'Ounce': return inGrams / 28.3495;
      default: return inGrams; // Gram
    }
  }

  // Temperature Conversion Logic
double _convertTemp(double val, String from, String to){
  if (from == to) return val;
  double celsius = val;

  // Convert from source to Celsius
  if (from == 'Fahrenheit') {
    celsius = (val - 32) * 5 / 9;
  } else if (from == 'Kelvin') {
    celsius = val - 273.15;
  }

  // Convert from Celsius to target
  if (to == 'Fahrenheit') {
    return (celsius * 9 / 5) + 32;
  } else if (to == 'Kelvin') {
    return celsius + 273.15;
  }
  return celsius; // Celsius
}
}
