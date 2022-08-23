class Category {
  const Category({
    required this.name,
    required this.searchValue,
  });

  final String name;
  final String searchValue;
}

const List<Category> apiCategories = [
  Category(name: 'General', searchValue: 'general'),
  Category(name: 'Negocios', searchValue: 'business'),
  Category(name: 'Entretenimiento', searchValue: 'entertainment'),
  Category(name: 'Salud', searchValue: 'health'),
  Category(name: 'Ciencias', searchValue: 'science'),
  Category(name: 'Deportes', searchValue: 'sports'),
  Category(name: 'Tecnología', searchValue: 'technology'),
];
