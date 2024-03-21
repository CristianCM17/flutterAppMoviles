
class ActorsModel {
  String? name;
  String? profilePath;


  ActorsModel({
    this.name,
    this.profilePath
  });

  factory ActorsModel.fromMap(Map<String,dynamic> actor){
    return ActorsModel(
      name: actor['name'],
      profilePath: actor['profile_path']
    );
  }
}
