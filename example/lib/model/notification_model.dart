class notificationModel {
 int id;
  int orderId = 0;
  String title = '';
  String description = '';
  bool seen=false;

  notificationModel();

  notificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    title = json['title'];
    description = json['description'];
    seen=json['seen'];
  }

  

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['orderId'] = this.orderId;
  //   data['title'] = this.title;
  //   data['description'] = this.description;
  //   return data;
  // }
}
