class User {
  int? id;
  String? username;
  String? password;
  List<Comment>? comment;

  User({this.id, this.username, this.password, this.comment});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    if (json['comment'] != null) {
      comment = <Comment>[];
      json['comment'].forEach((v) {
        comment!.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.comment != null) {
      data['comment'] = this.comment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int? cid;
  int? pid;
  String? content;

  Comment({this.cid, this.pid, this.content});

  Comment.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    pid = json['pid'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['pid'] = this.pid;
    data['content'] = this.content;
    return data;
  }
}
