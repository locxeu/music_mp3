// class LeaveRequests {
//   List<ResponseLeaveRequest> response;

//   LeaveRequests({required this.response});

//   LeaveRequests.fromJson(Map<String, dynamic> json) {
//     if (json['response'] != null) {
//       response = <ResponseLeaveRequest>[];
//       json['response'].forEach((v) {
//         response.add(ResponseLeaveRequest.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (response != null) {
//       data['response'] = response.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ResponseLeaveRequest {
//   int id;
//   int companyId;
//   int dayFrom;
//   int dayTo;
//   String reason;
//   int userId;
//   int leaderId;
//   bool accepted;
//   bool approved;
//   int createTime;
//   bool active;

//   ResponseLeaveRequest(
//       {this.id,
//       this.companyId,
//       this.dayFrom,
//       this.dayTo,
//       this.reason,
//       this.userId,
//       this.leaderId,
//       this.accepted,
//       this.approved,
//       this.createTime,
//       this.active});

//   ResponseLeaveRequest.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     companyId = json['company_id'];
//     dayFrom = json['day_from'];
//     dayTo = json['day_to'];
//     reason = json['reason'];
//     userId = json['user_id'];
//     leaderId = json['leader_id'];
//     accepted = json['accepted'];
//     approved = json['approved'];
//     createTime = json['create_time'];
//     active = json['active'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['company_id'] = companyId;
//     data['day_from'] = dayFrom;
//     data['day_to'] = dayTo;
//     data['reason'] = reason;
//     data['user_id'] = userId;
//     data['leader_id'] = leaderId;
//     data['accepted'] = accepted;
//     data['approved'] = approved;
//     data['create_time'] = createTime;
//     data['active'] = active;
//     return data;
//   }
// }

class SongModel {
  String? id;
  String? title;
  String? thumbnail;

  SongModel({this.id, this.title, this.thumbnail});

  SongModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    return data;
  }
}
