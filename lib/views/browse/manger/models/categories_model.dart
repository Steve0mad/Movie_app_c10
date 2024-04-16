class CategoriesModel {
  int id;
  String name;
  String imagePath;
  CategoriesModel({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}

List<CategoriesModel> categories = [
  CategoriesModel(
      id: 28, name: "Action", imagePath: 'assets/categories_images/action.jpg'),
  CategoriesModel(
      id: 12,
      name: "Adventure",
      imagePath: 'assets/categories_images/adventure.jpg'),
  CategoriesModel(
      id: 16,
      name: "Animation",
      imagePath: 'assets/categories_images/animation.jpeg'),
  CategoriesModel(
      id: 35, name: "comedy", imagePath: 'assets/categories_images/comedy.jpg'),
  CategoriesModel(
      id: 80, name: "Crime", imagePath: 'assets/categories_images/crime.jpg'),
  CategoriesModel(
      id: 18, name: "Drama", imagePath: 'assets/categories_images/drama.jpg'),
  CategoriesModel(
      id: 14,
      name: "Fantasy",
      imagePath: 'assets/categories_images/fantasy.jpg'),
  CategoriesModel(
      id: 27, name: "Horror", imagePath: 'assets/categories_images/horror.png'),
  CategoriesModel(
      id: 99,
      name: "Documentary",
      imagePath: 'assets/categories_images/documentary.jpg'),
  CategoriesModel(
      id: 10751,
      name: "Family",
      imagePath: 'assets/categories_images/family.jpg'),
  CategoriesModel(
      id: 36,
      name: "History",
      imagePath: 'assets/categories_images/history.jpg'),
  CategoriesModel(
      id: 878,
      name: "Science Fiction",
      imagePath: 'assets/categories_images/science-fiction.jpg'),
  CategoriesModel(
      id: 10402,
      name: "Music",
      imagePath: 'assets/categories_images/music.jpeg'),
  CategoriesModel(
      id: 10749,
      name: "Romance",
      imagePath: 'assets/categories_images/romance.jpg'),
  CategoriesModel(
      id: 10752, name: "War", imagePath: 'assets/categories_images/war.jpg'),
  CategoriesModel(
      id: 37,
      name: "Western",
      imagePath: 'assets/categories_images/western.jpg'),
  CategoriesModel(
      id: 10770,
      name: "TV Movie",
      imagePath: 'assets/categories_images/tv-movie.jpg'),
  CategoriesModel(
      id: 9648,
      name: "Mystery",
      imagePath: 'assets/categories_images/mystery.jpeg'),
];
