class adminmodel {
  List<classmodel> classes = [];
}

class classmodel {
  String classid;
  String classname;
  String classdescription;
  List<studentmodel>? studentlist = [];

  classmodel({
    this.classid = "",
    this.classname = "",
    this.classdescription = "",
    this.studentlist = const [],
  });
}

class studentmodel {
  int studentphoneno;
  int studentname;
  List<classmodel> joinedclasses = [];
  studentmodel(
    this.studentphoneno,
    this.studentname,
  );
}
