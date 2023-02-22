class Recipe{
  String id;
  String name;
  List<dynamic> ingredients;
  String description;
  List<dynamic> steps;
  var imageUrl;
  bool isLiked;

  Recipe(this.id, this.name,this.description,this.ingredients,this.steps, this.imageUrl, this.isLiked);

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