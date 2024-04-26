import 'package:flutter/material.dart';

abstract class TiedeNotify with ChangeNotifier {
  bool isLoading = false;
  
  notify({bool isLoading = false}){
    this.isLoading = isLoading;
    notifyListeners();
  }
}