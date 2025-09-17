
int? _asInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is String) return int.tryParse(v);
  return null;
}

String? _asString(dynamic v) {
  if (v == null) return null;
  return v.toString();
}

bool? _asBool(dynamic v) {
  if (v == null) return null;
  if (v is bool) return v;
  if (v is int) return v != 0;
  if (v is String) return v == 'true' || v == '1';
  return null;
}

class ChatModel {
  ConversationDetails? conversationDetails;
  List<Messages>? messages;
  String? nextBeforeId; // ← نصي: المؤشر "التالي" فقط
  int? statusCode;

  ChatModel({
    this.conversationDetails,
    this.messages,
    this.nextBeforeId,
    this.statusCode,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    final conv = json['conversation_details'];
    if (conv is Map<String, dynamic>) {
      conversationDetails = ConversationDetails.fromJson(conv);
    }

    final msgs = json['messages'];
    if (msgs is List) {
      messages = msgs
          .whereType<Map<String, dynamic>>()
          .map((e) => Messages.fromJson(e))
          .toList();
    } else {
      messages = <Messages>[];
    }

    // ✅ اقرأ فقط مفاتيح "المؤشر التالي" الحقيقية (لا تستخدم before_id هنا)
    nextBeforeId =
        _asString(json['next_before_id']) ??
        _asString(json['nextsendbefore']) ??
        _asString(json['next']) ??
        _asString(json['cursor']);

    statusCode = _asInt(json['statusCode']) ?? _asInt(json['status_code']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (conversationDetails != null) {
      data['conversation_details'] = conversationDetails!.toJson();
    }
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    data['next_before_id'] = nextBeforeId;
    data['statusCode'] = statusCode;
    return data;
  }
}

class ConversationDetails {
  int? conversationId;
  String? conversationType;
  Peer? peer;

  ConversationDetails({this.conversationId, this.conversationType, this.peer});

  ConversationDetails.fromJson(Map<String, dynamic> json) {
    conversationId = _asInt(json['conversation_id']);
    conversationType = _asString(json['conversation_type']);
    final p = json['peer'];
    if (p is Map<String, dynamic>) {
      peer = Peer.fromJson(p);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['conversation_id'] = conversationId;
    data['conversation_type'] = conversationType;
    if (peer != null) {
      data['peer'] = peer!.toJson();
    }
    return data;
  }
}

class Peer {
  int? id;
  String? name;
  String? profileImage; // ← تُطبَّع لتصبح null إذا كانت "" أو "null"
  String? role;

  Peer({this.id, this.name, this.profileImage, this.role});

  Peer.fromJson(Map<String, dynamic> json) {
    id = _asInt(json['id']);
    name = _asString(json['name']);
    final img = _asString(json['profile_image'])?.trim();
    profileImage = (img == null || img.isEmpty || img.toLowerCase() == 'null') ? null : img;
    role = _asString(json['role']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['profile_image'] = profileImage;
    data['role'] = role;
    return data;
  }
}

class Messages {
  int? id;
  int? senderId;
  int? faqId;            // ← int? (ليس String)
  String? messageType;
  String? content;
  String? attachmentPath;
  bool? isMine;
  String? messageTime;   // يبقى نص (مثلاً dd/MM/yyyy)

  Messages({
    this.id,
    this.senderId,
    this.faqId,
    this.messageType,
    this.content,
    this.attachmentPath,
    this.isMine,
    this.messageTime,
  });

  Messages.fromJson(Map<String, dynamic> json) {
    id = _asInt(json['id']);
    senderId = _asInt(json['sender_id']);
    faqId = _asInt(json['faq_id']); // ← يحوّل رقم/نص إلى int?
    messageType = _asString(json['message_type']);
    content = _asString(json['content']);
    attachmentPath = _asString(json['attachment_path']);
    isMine = _asBool(json['is_mine']);
    messageTime = _asString(json['messageTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['faq_id'] = faqId;
    data['message_type'] = messageType;
    data['content'] = content;
    data['attachment_path'] = attachmentPath;
    data['is_mine'] = isMine;
    data['messageTime'] = messageTime;
    return data;
  }
}
