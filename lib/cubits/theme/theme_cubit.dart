import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:laza/di/di.dart';
import 'package:laza/domain/repository/theme_repository.dart';

part 'theme_state.dart';
part 'theme_cubit.freezed.dart';

@injectable
class ThemeCubit extends Cubit<ThemeState> {
  static ThemeCubit get instance => getIt<ThemeCubit>();
  ThemeCubit() : super(const ThemeState(ThemeMode.system)) ;
  void updateTheme(ThemeMode themeMode) {
    final themeRepo = ThemeRepository.instance;
    themeRepo.saveTheme(themeMode);
    emit(ThemeState(themeMode));
  }

  void loadTheme() {
    final themeRepo = getIt<ThemeRepository>();
    emit(ThemeState(themeRepo.loadFromPrefs()));
  }
}
