class Classmodel {
  final String classkey;
  final String classname;
  final String classdescription;
  final List studentlist;

  Classmodel(
      this.classkey, this.classname, this.classdescription, this.studentlist);
}

class iddata {
  // to store id and data both at single object
  final String id;
  final dynamic data;

  iddata(this.id, this.data);
}
