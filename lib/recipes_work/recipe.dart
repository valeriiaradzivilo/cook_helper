class Recipe{
  final String name;
  final Map<double,String> ingredients;
  final String description;
  final List<String> steps;

  Recipe(this.name,this.description,this.ingredients,this.steps);

  List<String> getSmallRecipe()
  {
    List<String> answer = [this.name, this.description];
    return answer;
  }



}