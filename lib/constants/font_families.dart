enum FontFamily {
  bebasNeue,
  playfairDisplaySC,
  nunito,
  spaceGrotesk;

  String get name {
    switch (this) {
      case FontFamily.bebasNeue:
        return 'BebasNeue';
      case FontFamily.playfairDisplaySC:
        return 'PlayfairDisplaySC';
      case FontFamily.nunito:
        return 'Nunito';
      case FontFamily.spaceGrotesk:
        return 'SpaceGrotesk';
    }
  }
}
