
class ReactionModel {
  final String userId;
  final String profilePicUrl;
  final String reactionIcon;
  final String userName;

  ReactionModel({
    required this.userId,
    required this.profilePicUrl,
    required this.reactionIcon,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'profilePicUrl': profilePicUrl,
      'reactionIcon': reactionIcon,
      'userName': userName,
    };
  }
}