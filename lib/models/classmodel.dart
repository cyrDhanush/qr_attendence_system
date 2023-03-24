class Classmodel {
  final String classkey;
  final String classname;
  final String classdescription;
  final Map joinedusers;

  Classmodel(
      {required this.classkey,
      required this.classname,
      required this.classdescription,
      required this.joinedusers}) {
    this.joinedusers.removeWhere((key, value) => value == null);
  }
}

class Usermodel {
  final String userkey;
  final String username;
  final Map joinedclasses;

  Usermodel(
      {required this.userkey,
      required this.username,
      required this.joinedclasses}) {
    this.joinedclasses.removeWhere((key, value) => value == null);
  }
}

class iddata {
  // to store id and data both at single object
  final String id;
  final dynamic data;

  iddata(this.id, this.data);
}
