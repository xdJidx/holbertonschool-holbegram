import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
    String uid;
    String email;
    String username;
    String bio;
    String photoUrl;
    List<dynamic> followers;
    List<dynamic> following;
    List<dynamic> posts;
    List<dynamic> saved;
    String searchKey;

    Users({
        required this.uid,
        required this.email,
        required this.username,
        required this.bio,
        required this.photoUrl,
        required this.followers,
        required this.following,
        required this.posts,
        required this.saved,
        required this.searchKey,
    });

    static Users fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

     return Users(
       uid: data['uid'],
       email: data['email'],
       username: data['username'],
       bio: data['bio'],
       photoUrl: data['photoUrl'],
       followers: data['followers'] ?? [],
       following: data['following'] ?? [],
       posts: data['posts'] ?? [],
       saved: data['saved'] ?? [],
       searchKey: data['searchKey'],
     );
    }
    Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'bio': bio,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
        'posts': posts,
        'saved': saved,
        'searchKey': searchKey,
    };
}
