// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ListOfAllConversationModel {
  int? conversationId;
  String? title;
  String? conversationType;
  PeerAtListConversationModel? peer;
  String? lastMessage;
  String? lastMessageAt;
  int? unreadCount;
  bool? isSelf;

  ListOfAllConversationModel(
      {this.conversationId,
      this.title,
      this.conversationType,
      this.peer,
      this.lastMessage,
      this.lastMessageAt,
      this.unreadCount,
      this.isSelf});

  ListOfAllConversationModel.fromJson(Map<String, dynamic> json) {
    conversationId = json['conversation_id'];
    title = json['title'];
    conversationType = json['conversation_type'];
    peer = json['peer'] != null ? new PeerAtListConversationModel.fromJson(json['peer']) : null;
    lastMessage = json['last_message'];
    lastMessageAt = json['last_message_at'];
    unreadCount = json['unread_count'];
    isSelf = json['is_self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conversation_id'] = this.conversationId;
    data['title'] = this.title;
    data['conversation_type'] = this.conversationType;
    if (this.peer != null) {
      data['peer'] = this.peer!.toJson();
    }
    data['last_message'] = this.lastMessage;
    data['last_message_at'] = this.lastMessageAt;
    data['unread_count'] = this.unreadCount;
    data['is_self'] = this.isSelf;
    return data;
  }
}
class PeerAtListConversationModel {
  int? id;
  String? name;
  String? profileImage;
  String? role;

  PeerAtListConversationModel({this.id, this.name, this.profileImage, this.role});

  PeerAtListConversationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = _normalizeStr(json['name']);
    profileImage = _normalizeStr(json['profile_image']); // ⬅️ هنا
    role = _normalizeStr(json['role']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['profile_image'] = profileImage;
    data['role'] = role;
    return data;
  }

  // يحوّل null / "" / "null" → null
  String? _normalizeStr(dynamic v) {
    if (v == null) return null;
    final s = v.toString().trim();
    if (s.isEmpty || s.toLowerCase() == 'null') return null;
    return s;
  }
}
