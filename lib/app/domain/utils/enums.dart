enum UtmFuso {
  fuso18,
  fuso19,
  fuso20,
  fuso21,
  fuso22,
  fuso23,
  fuso24,
  fuso25;

  String get name {
    switch (this) {
      case UtmFuso.fuso18:
        return '18';
      case UtmFuso.fuso19:
        return '19';
      case UtmFuso.fuso20:
        return '20';
      case UtmFuso.fuso21:
        return '21';
      case UtmFuso.fuso22:
        return '22';
      case UtmFuso.fuso23:
        return '23';
      case UtmFuso.fuso24:
        return '24';
      case UtmFuso.fuso25:
        return '25';
    }
  }
}

enum UtmZona {
  zonaX,
  zonaH,
  zonaJ,
  zonaK,
  zonaL,
  zonaM,
  zonaN;

  String get name {
    switch (this) {
      case UtmZona.zonaX:
        return '?';
      case UtmZona.zonaH:
        return 'N';
      case UtmZona.zonaJ:
        return 'S';
      case UtmZona.zonaK:
        return 'K';

      case UtmZona.zonaL:
        return 'L';

      case UtmZona.zonaM:
        return 'M';

      case UtmZona.zonaN:
        return 'N';
    }
  }
}

enum UtmPole {
  norte,
  sul;

  String get name {
    switch (this) {
      case UtmPole.norte:
        return 'N';
      case UtmPole.sul:
        return 'S';
    }
  }
}
