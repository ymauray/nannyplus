class FontItem {
  final String family;
  final String asset;

  const FontItem(this.family, this.asset);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FontItem && other.family == family && other.asset == asset;
  }

  @override
  int get hashCode => family.hashCode ^ asset.hashCode;
}

class FontUtils {
  static const fontItems = [
    FontItem("SF Pro Text", "assets/fonts/SF-Pro-Text-Regular.otf"),
    FontItem("STCaiyun", "assets/fonts/STCaiyun.ttf"),
    FontItem("Butterfly Kids", "assets/fonts/ButterflyKids-Regular.ttf"),
    FontItem(
        "Fredericka the Great", "assets/fonts/FrederickatheGreat-Regular.ttf"),
    FontItem("Gwendolyn", "assets/fonts/Gwendolyn-Bold.ttf"),
    FontItem("Mystery Quest", "assets/fonts/MysteryQuest-Regular.ttf"),
    FontItem("Oswald", "assets/fonts/Oswald-Regular.ttf"),
    FontItem("Playfair Display", "assets/fonts/PlayfairDisplay-Italic.ttf"),
    FontItem("Rampart One", "assets/fonts/RampartOne-Regular.ttf"),
  ];

  static get defaultFontItem => fontItems[0];
}
