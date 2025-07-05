class DataModel{
  String? title;
  String? subtitle;
  String? id;

  DataModel({
  required this.title,
  required this.subtitle,
  this.id});

  Map<String,dynamic>toFirestore(){
    return {
      'title':title,
      'subtitle':subtitle,
    };
  }


  factory DataModel.fromFirebase(Map<String,dynamic>docs,String id){
    return DataModel(
      title: docs['title'],
       subtitle: docs['subtitle'],
       id: id
      );
  }
}