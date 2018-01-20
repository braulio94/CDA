
class Member {

  String beltColor;
  int concludedProjects;
  Object disponibilities;
  String id;
  String name;
  String photoUri;
  Object programmingLangs;
  Object technologies;

  Member.fromJson(Map value){
    beltColor = value["beltColor"];
    concludedProjects = value["concludedProjects"];
    disponibilities = value["disponibilities"];
    id = value["id"];
    name = value["name"];
    photoUri = value["photoUri"];
    programmingLangs = value["programmingLangs"];
    technologies = value["technologies"];

  }

}