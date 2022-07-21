class Package {
  final String id;
  String? title;
  String? iconUrl;
  String? description;
  String? playStoreUrl;
  bool isSelected;

  Package({
    required this.id,
    this.title,
    this.iconUrl,
    this.description,
    this.playStoreUrl,
    this.isSelected = false,
  });
}

List<Package> testPackages = [
  Package(id: 'com.google.android.youtube'),
  Package(id: 'com.google.android.apps.maps'),
  Package(id: 'com.google.android.apps.photos'),
  Package(id: 'com.google.android.apps.tachyon'),
  Package(id: 'com.google.android.apps.magazines'),
  Package(id: 'com.google.android.apps.books'),
];
