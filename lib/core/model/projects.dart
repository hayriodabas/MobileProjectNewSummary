class Projects {
  Bugs bugs;
  int fixedBug;
  int hWBug;
  String projectName;
  int sWBug;
  int totalBug;
  String key;
  String source;
  String productType;
  String mPDate;
  String week;
  String yorum;
  String updateTime;

  Projects(
      {this.fixedBug,
      this.yorum,
      this.hWBug,
      this.projectName,
      this.sWBug,
      this.totalBug,
      this.key,
      this.bugs,
      this.mPDate,
      this.source,
      this.productType,
      this.week});

  Projects.fromJson(Map<String, dynamic> json) {
    bugs = json['Bugs'] != null ? new Bugs.fromJson(json['Bugs']) : null;
    key = json['key'];
    fixedBug = int.parse(json['FixedBug']);
    hWBug = int.parse(json['HWBug']);
    projectName = json['ProjectName'];
    sWBug = int.parse(json['SWBug']);
    totalBug = int.parse(json['TotalBug']);
    source = json['Source'];
    productType = json['ProductType'];
    mPDate = json['MPDate'];
    week = json['Week'];
    yorum = json['Yorum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bugs != null) {
      data['Bugs'] = this.bugs.toJson();
    }
    data['key'] = this.key;
    data['FixedBug'] = this.fixedBug;
    data['HWBug'] = this.hWBug;
    data['ProjectName'] = this.projectName;
    data['SWBug'] = this.sWBug;
    data['TotalBug'] = this.totalBug;
    data['Source'] = this.source;
    data['ProductType'] = this.productType;
    data['MPDate'] = this.mPDate;
    data['Week'] = this.week;
    data['Yorum'] = this.yorum;
    return data;
  }
}

class Bugs {
  List<HWBug> hWBug;
  List<SWBug> sWBug;
  List<FixedBug> fixedBug;
  Bugs({this.hWBug, this.sWBug,this.fixedBug});

  Bugs.fromJson(Map<String, dynamic> json) {
    if (json['HWBug'] != null) {
      hWBug = new List<HWBug>();
      json['HWBug'].forEach((v) {
        hWBug.add(new HWBug.fromJson(v));
      });
    }else{
       hWBug = new List<HWBug>();
    }
    if (json['SWBug'] != null) {
      sWBug = new List<SWBug>();
      json['SWBug'].forEach((v) {
        sWBug.add(new SWBug.fromJson(v));
      });
    }else{
       sWBug = new List<SWBug>();
    }
    if (json['FixedBug'] != null) {
      fixedBug = new List<FixedBug>();
      json['FixedBug'].forEach((v) {
        fixedBug.add(new FixedBug.fromJson(v));
      });
    }else{
       fixedBug = new List<FixedBug>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hWBug != null) {
      data['HWBug'] = this.hWBug.map((v) => v.toJson()).toList();
    }
    if (this.sWBug != null) {
      data['SWBug'] = this.sWBug.map((v) => v.toJson()).toList();
    }
    if (this.fixedBug != null) {
      data['FixedBug'] = this.fixedBug.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HWBug {
  String bugName;

  HWBug({this.bugName});

  HWBug.fromJson(Map<String, dynamic> json) {
    bugName = json['BugName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BugName'] = this.bugName;
    return data;
  }
}

class SWBug {
  String bugName;

  SWBug({this.bugName});

  SWBug.fromJson(Map<String, dynamic> json) {
    bugName = json['BugName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BugName'] = this.bugName;
    return data;
  }
}

class FixedBug {
  String bugName;

  FixedBug({this.bugName});

  FixedBug.fromJson(Map<String, dynamic> json) {
    bugName = json['BugName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BugName'] = this.bugName;
    return data;
  }
}