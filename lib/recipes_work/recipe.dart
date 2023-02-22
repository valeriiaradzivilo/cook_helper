class Recipe{
  final String name;
  final List<dynamic> ingredients;
  final String description;
  final List<dynamic> steps;
  final imageUrl;
  bool isLiked;

  Recipe(this.name,this.description,this.ingredients,this.steps, this.imageUrl, this.isLiked);

  List<String> getSmallRecipe()
  {
    List<String> answer = [this.name, this.description];
    return answer;
  }

  void setLike(bool like)
  {
    isLiked = like;
  }



}