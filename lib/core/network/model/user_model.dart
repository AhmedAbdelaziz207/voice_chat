import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
    late final String? userId;

    late  String? name;

    late final String? profileImageUrl;

    late final String? phoneNumber;

    late final DateTime? lastSeen;

    late final bool? isOnline;

    UserModel({
        this.name,
        this.userId,
        this.profileImageUrl,
        this.phoneNumber,
        this.lastSeen,
        this.isOnline = false
    });

    UserModel.fromJson(Map<String, dynamic> json) {
        userId = json['user_id'];
        name = json['name'];
        profileImageUrl = json['profile_image_url'];
        phoneNumber = json['phone_number'];
        if (json['last_seen'] != null) {
            lastSeen = (json['last_seen'] as Timestamp).toDate();
        } else {
            lastSeen = null;
        }

        isOnline = json['is_online'] ?? false;
    }
    Map<String, dynamic> toJson() {
        return {
            'user_id': userId,
            'name': name,
            'profile_image_url': profileImageUrl,
            'phone_number': phoneNumber,
            'last_seen': lastSeen,
        };
    }
}
