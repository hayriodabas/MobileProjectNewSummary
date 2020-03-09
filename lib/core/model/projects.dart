class Projects {
  Bugs bugs;
  int fixedBug;
  int rcBug;
  int hWBug;
  String projectName;
  int sWBug;
  int totalBug;
  String key;
  String source;
  String productType;
  String mPDate;
  String week;
  String year;
  String yorum;
  String updateTime;

  Projects(
      {this.fixedBug,
      this.rcBug,
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
    bugs = json['Bugs'] != null ? new Bugs.fromJson(json['Bugs']) : new Bugs();
    key = json['key'];
    fixedBug = int.parse(json['FixedBug']);
    if (json.containsKey('RCBugCount')) {
      rcBug = int.parse(json['RCBugCount']);
    } else {
      rcBug = 0;
    }
    //rcBug = int.parse(json.containsKey('RCBugCount') == false ? json['RCBugCount'] : 0);
    hWBug = int.parse(json['HWBug']);
    projectName = json['ProjectName'];
    sWBug = int.parse(json['SWBug']);
    totalBug = int.parse(json['TotalBug']);
    source = json['Source'];
    productType = json['ProductType'];
    mPDate = json['MPDate'];
    String weekAndYear = json['Week'];
    if (weekAndYear.contains(".")) {
      List<String> splitList = weekAndYear.split(".");
      week = splitList[0].toString();
      year = splitList[1].toString();
    } else {
      week = json['Week'];
    }
    yorum = json['Yorum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bugs != null) {
      data['Bugs'] = this.bugs.toJson();
    }
    data['key'] = this.key;
    data['FixedBug'] = this.fixedBug;
    data['RCBugCount'] = this.rcBug;
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
  List<FixedBug> fixedBugHW;
  List<FixedBug> fixedBugSW;
  List<RCBug> rcBugHW;
  List<RCBug> rcBugSW;
  Bugs(
      {this.hWBug,
      this.sWBug,
      this.fixedBugHW,
      this.fixedBugSW,
      this.rcBugHW,
      this.rcBugSW});

  Bugs.fromJson(Map<String, dynamic> json) {
    if (json['HWBug'] != null) {
      hWBug = new List<HWBug>();
      json['HWBug'].forEach((v) {
        hWBug.add(new HWBug.fromJson(v));
      });
    } else {
      hWBug = new List<HWBug>();
      
    }
    if (json['SWBug'] != null) {
      sWBug = new List<SWBug>();
      json['SWBug'].forEach((v) {
        sWBug.add(new SWBug.fromJson(v));
      });
    } else {
      sWBug = new List<SWBug>();
    }
    if (json['FixedBugHW'] != null) {
      fixedBugHW = new List<FixedBug>();
      json['FixedBugHW'].forEach((v) {
        fixedBugHW.add(new FixedBug.fromJson(v));
      });
    } else {
      fixedBugHW = new List<FixedBug>();
    }
    if (json['FixedBugSW'] != null) {
      fixedBugSW = new List<FixedBug>();
      json['FixedBugSW'].forEach((v) {
        fixedBugSW.add(new FixedBug.fromJson(v));
      });
    } else {
      fixedBugSW = new List<FixedBug>();
    }
    if (json['RCBugHW'] != null) {
      rcBugHW = new List<RCBug>();
      json['RCBugHW'].forEach((v) {
        rcBugHW.add(new RCBug.fromJson(v));
      });
    } else {
      rcBugHW = new List<RCBug>();
    }
    if (json['RCBugSW'] != null) {
      rcBugSW = new List<RCBug>();
      json['RCBugSW'].forEach((v) {
        rcBugSW.add(new RCBug.fromJson(v));
      });
    } else {
      rcBugSW = new List<RCBug>();
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
    if (this.fixedBugHW != null) {
      data['FixedBugHW'] = this.fixedBugHW.map((v) => v.toJson()).toList();
    } 
    if (this.fixedBugSW != null) {
      data['FixedBugSW'] = this.fixedBugSW.map((v) => v.toJson()).toList();
    }
    if (this.rcBugHW != null) {
      data['RCBugHW'] = this.rcBugHW.map((v) => v.toJson()).toList();
    }if (this.rcBugSW != null) {
      data['RCBugSW'] = this.rcBugSW.map((v) => v.toJson()).toList();
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

class RCBug {
  String bugName;

  RCBug({this.bugName});

  RCBug.fromJson(Map<String, dynamic> json) {
    bugName = json['BugName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BugName'] = this.bugName;
    return data;
  }
}
