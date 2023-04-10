class Weather {
  var icon;
  var tinhtrang;
  var nhietdo;
  var gio;
  var doam;
  var luongmua;
  var khongkhi;
  var thoigian;
  var image;

  Weather(
      {
        required this.icon,
        required this.tinhtrang,
        required this.nhietdo,
        required this.gio,
        required this.doam,
        required this.luongmua,
        required this.khongkhi,
        required this.thoigian,
        required this.image});


  @override
  String toString() {
    return 'Weather{'+ "\n" +
        'icon: $icon,' + "\n" +
        'tinhtrang: $tinhtrang, ' + "\n" +
        'nhietdo: $nhietdo,' + "\n" +
        ' gio: $gio, ' + "\n" +
        'doam: $doam, ' + "\n" +
        'luongmua: $luongmua,' + "\n" +
        ' khongkhi: $khongkhi, ' + "\n" +
        'thoigian: $thoigian}'  + "\n" +
        'image: $image}'  + "\n";
  }
}