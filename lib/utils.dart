import 'package:flutter/widgets.dart';
import 'package:weather_icons/weather_icons.dart';

class Utils {
  static String getWeatherDescriptionFromCode(int code) {
    switch (code) {
      case 0:
        return "Céu limpo";
      case 1:
        return "Predomínio de sol";
      case 2:
        return "Parcialmente nublado";
      case 3:
        return "Nublado";
      case 45:
        return "Névoa";
      case 48:
        return "Névoa gelada";
      case 51:
        return "Garoa leve";
      case 53:
        return "Garoa moderada";
      case 55:
        return "Garoa intensa";
      case 56:
      case 57:
        return "Garoa congelante";
      case 61:
        return "Chuva leve";
      case 63:
        return "Chuva moderada";
      case 65:
        return "Chuva intensa";
      case 66:
      case 67:
        return "Chuva congelante";
      case 71:
      case 73:
      case 75:
        return "Neve";
      case 77:
        return "Cristais de gelo";
      case 80:
      case 81:
      case 82:
        return "Aguaceiros";
      case 85:
      case 86:
        return "Aguaceiros de neve";
      case 95:
        return "Trovoadas";
      case 96:
      case 99:
        return "Trovoadas com granizo";
      default:
        return "Desconhecido";
    }
  }

  static IconData getWeatherIconFromCode(int code) {
    switch (code) {
      case 0:
        return WeatherIcons.day_sunny;
      case 1:
        return WeatherIcons.day_sunny_overcast;
      case 2:
        return WeatherIcons.day_cloudy;
      case 3:
        return WeatherIcons.cloudy;
      case 45:
      case 48:
        return WeatherIcons.fog;
      case 51:
      case 53:
      case 55:
        return WeatherIcons.sprinkle;
      case 56:
      case 57:
        return WeatherIcons.sleet;
      case 61:
      case 63:
      case 65:
        return WeatherIcons.rain;
      case 66:
      case 67:
        return WeatherIcons.rain_mix;
      case 71:
      case 73:
      case 75:
        return WeatherIcons.snow;
      case 77:
        return WeatherIcons.snow_wind;
      case 80:
      case 81:
      case 82:
        return WeatherIcons.showers;
      case 85:
      case 86:
        return WeatherIcons.snowflake_cold;
      case 95:
        return WeatherIcons.thunderstorm;
      case 96:
      case 99:
        return WeatherIcons.hail;
      default:
        return WeatherIcons.alien;
    }
  }
}
