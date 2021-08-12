

class JobModel {
  String? _staus;
  String? _message;
  List<Data>? _data;

  String? get staus => _staus;
  String? get message => _message;
  List<Data>? get data => _data;

  JobModel({
      String? staus, 
      String? message, 
      List<Data>? data}){
    _staus = staus;
    _message = message;
    _data = data;
}

  JobModel.fromJson(dynamic json) {
    _staus = json['staus'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['staus'] = _staus;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  String? _id;
  String? _jobType;
  String? _designation;
  String? _qualification;
  String? _jobLocation;
  String? _yearOfPassing;
  String? _preCgpa;
  String? _specialization;
  String? _areaOfSector;
  String? _exp;
  String? _numberOfVacancies;
  String? _lasrDateApplication;
  dynamic? _hiringProcess;
  String? _salaryRange;
  String? _min;
  String? _max;
  String? _rId;
  String? _payCount;
  String? _postDate;
  String? _application;
  String? _technology;
  String? _jobDesc;
  String? _writtenTest;
  String? _groupDiscussion;
  String? _technicalRound;
  String? _hrRound;
  String? _metaDesc;
  String? _metaKeyword;
  String? _author;

  String? get id => _id;
  String? get jobType => _jobType;
  String? get designation => _designation;
  String? get qualification => _qualification;
  String? get jobLocation => _jobLocation;
  String? get yearOfPassing => _yearOfPassing;
  String? get preCgpa => _preCgpa;
  String? get specialization => _specialization;
  String? get areaOfSector => _areaOfSector;
  String? get exp => _exp;
  String? get numberOfVacancies => _numberOfVacancies;
  String? get lasrDateApplication => _lasrDateApplication;
  dynamic? get hiringProcess => _hiringProcess;
  String? get salaryRange => _salaryRange;
  String? get min => _min;
  String? get max => _max;
  String? get rId => _rId;
  String? get payCount => _payCount;
  String? get postDate => _postDate;
  String? get application => _application;
  String? get technology => _technology;
  String? get jobDesc => _jobDesc;
  String? get writtenTest => _writtenTest;
  String? get groupDiscussion => _groupDiscussion;
  String? get technicalRound => _technicalRound;
  String? get hrRound => _hrRound;
  String? get metaDesc => _metaDesc;
  String? get metaKeyword => _metaKeyword;
  String? get author => _author;

  Data({
      String? id, 
      String? jobType, 
      String? designation, 
      String? qualification, 
      String? jobLocation, 
      String? yearOfPassing, 
      String? preCgpa, 
      String? specialization, 
      String? areaOfSector, 
      String? exp, 
      String? numberOfVacancies, 
      String? lasrDateApplication, 
      dynamic? hiringProcess, 
      String? salaryRange, 
      String? min, 
      String? max, 
      String? rId, 
      String? payCount, 
      String? postDate, 
      String? application, 
      String? technology, 
      String? jobDesc, 
      String? writtenTest, 
      String? groupDiscussion, 
      String? technicalRound, 
      String? hrRound, 
      String? metaDesc, 
      String? metaKeyword, 
      String? author}){
    _id = id;
    _jobType = jobType;
    _designation = designation;
    _qualification = qualification;
    _jobLocation = jobLocation;
    _yearOfPassing = yearOfPassing;
    _preCgpa = preCgpa;
    _specialization = specialization;
    _areaOfSector = areaOfSector;
    _exp = exp;
    _numberOfVacancies = numberOfVacancies;
    _lasrDateApplication = lasrDateApplication;
    _hiringProcess = hiringProcess;
    _salaryRange = salaryRange;
    _min = min;
    _max = max;
    _rId = rId;
    _payCount = payCount;
    _postDate = postDate;
    _application = application;
    _technology = technology;
    _jobDesc = jobDesc;
    _writtenTest = writtenTest;
    _groupDiscussion = groupDiscussion;
    _technicalRound = technicalRound;
    _hrRound = hrRound;
    _metaDesc = metaDesc;
    _metaKeyword = metaKeyword;
    _author = author;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _jobType = json['job_type'];
    _designation = json['designation'];
    _qualification = json['qualification'];
    _jobLocation = json['job_location'];
    _yearOfPassing = json['year_of_passing'];
    _preCgpa = json['pre_cgpa'];
    _specialization = json['specialization'];
    _areaOfSector = json['area_of_sector'];
    _exp = json['exp'];
    _numberOfVacancies = json['number_of_vacancies'];
    _lasrDateApplication = json['lasr_date_application'];
    _hiringProcess = json['hiring_process'];
    _salaryRange = json['salary_range'];
    _min = json['min'];
    _max = json['max'];
    _rId = json['r_id'];
    _payCount = json['pay_count'];
    _postDate = json['post_date'];
    _application = json['application'];
    _technology = json['technology'];
    _jobDesc = json['job_desc'];
    _writtenTest = json['written_test'];
    _groupDiscussion = json['group_discussion'];
    _technicalRound = json['technical_round'];
    _hrRound = json['hr_round'];
    _metaDesc = json['meta_desc'];
    _metaKeyword = json['meta_keyword'];
    _author = json['author'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['job_type'] = _jobType;
    map['designation'] = _designation;
    map['qualification'] = _qualification;
    map['job_location'] = _jobLocation;
    map['year_of_passing'] = _yearOfPassing;
    map['pre_cgpa'] = _preCgpa;
    map['specialization'] = _specialization;
    map['area_of_sector'] = _areaOfSector;
    map['exp'] = _exp;
    map['number_of_vacancies'] = _numberOfVacancies;
    map['lasr_date_application'] = _lasrDateApplication;
    map['hiring_process'] = _hiringProcess;
    map['salary_range'] = _salaryRange;
    map['min'] = _min;
    map['max'] = _max;
    map['r_id'] = _rId;
    map['pay_count'] = _payCount;
    map['post_date'] = _postDate;
    map['application'] = _application;
    map['technology'] = _technology;
    map['job_desc'] = _jobDesc;
    map['written_test'] = _writtenTest;
    map['group_discussion'] = _groupDiscussion;
    map['technical_round'] = _technicalRound;
    map['hr_round'] = _hrRound;
    map['meta_desc'] = _metaDesc;
    map['meta_keyword'] = _metaKeyword;
    map['author'] = _author;
    return map;
  }

}