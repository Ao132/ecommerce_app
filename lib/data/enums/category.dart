enum Category {
  hoodies(title: 'Hoodies'),
  tshirts(title: 'T-shirts'),
  pants(title: 'Pants'),
  jackets(title: 'Jackets'),
  sneakers(title: 'Sneakers');

  final String title;
  const Category({required this.title});
}

enum Gender {
  male,
  female,
}
