import 'package:nonstop/core/theme/app_colors.dart';

/// Mock data for design and development phase
/// Contains static data structures for all features

class MockData {
  // Universities
  static final List<University> universities = [
    University(
      id: '1',
      name: 'Tashkent State University of Economics',
      shortName: 'TSUE',
      color: AppColors.primary.toARGB32(),
      logoUrl: 'https://picsum.photos/seed/tsue/100/100',
    ),
    University(
      id: '2',
      name: 'National University of Uzbekistan',
      shortName: 'NUUz',
      color: AppColors.universityRed.toARGB32(),
      logoUrl: 'https://picsum.photos/seed/nuuz/100/100',
    ),
    University(
      id: '3',
      name: 'Inha University in Tashkent',
      shortName: 'IUT',
      color: AppColors.universityGreen.toARGB32(),
      logoUrl: 'https://picsum.photos/seed/iut/100/100',
    ),
    University(
      id: '4',
      name: 'Tashkent University of Information Technologies',
      shortName: 'TUIT',
      color: AppColors.universityPurple.toARGB32(),
      logoUrl: 'https://picsum.photos/seed/tuit/100/100',
    ),
  ];

  // Users
  static final List<User> users = [
    User(
      id: '1',
      name: 'Azizbek Rahimov',
      email: 'azizbek@example.com',
      universityId: '1',
      avatarUrl: 'https://picsum.photos/seed/ar/100/100',
      major: 'Computer Science',
      year: 3,
      isOnline: true,
    ),
    User(
      id: '2',
      name: 'Malika Karimova',
      email: 'malika@example.com',
      universityId: '2',
      avatarUrl: 'https://picsum.photos/seed/mk/100/100',
      major: 'Business Administration',
      year: 2,
      isOnline: false,
    ),
    User(
      id: '3',
      name: 'Jasurbek Tursunov',
      email: 'jasurbek@example.com',
      universityId: '3',
      avatarUrl: 'https://picsum.photos/seed/jt/100/100',
      major: 'Economics',
      year: 4,
      isOnline: true,
    ),
    User(
      id: '4',
      name: 'Nilufar Abdullayeva',
      email: 'nilufar@example.com',
      universityId: '1',
      avatarUrl: 'https://picsum.photos/seed/na/100/100',
      major: 'Mathematics',
      year: 3,
      isOnline: true,
    ),
  ];

  // Courses
  static final List<Course> courses = [
    Course(
      id: '1',
      name: 'Data Structures & Algorithms',
      code: 'CS201',
      professor: 'Dr. Ahmadjon Abdullayev',
      day: 1, // Monday
      startTime: 9,
      duration: 2,
      location: 'Room 301',
      color: AppColors.courseColors[0].toARGB32(),
      credits: 3,
      universityId: '1',
      description:
          'Fundamental data structures and algorithm design principles.',
    ),
    Course(
      id: '2',
      name: 'Microeconomics',
      code: 'ECON101',
      professor: 'Prof. Gulnora Karimova',
      day: 2, // Tuesday
      startTime: 10,
      duration: 1.5,
      location: 'Room 205',
      color: AppColors.courseColors[1].toARGB32(),
      credits: 2,
      universityId: '1',
      description: 'Introduction to microeconomic theory and applications.',
    ),
    Course(
      id: '3',
      name: 'Database Systems',
      code: 'CS301',
      professor: 'Dr. Rustam Alimov',
      day: 3, // Wednesday
      startTime: 14,
      duration: 2,
      location: 'Lab 102',
      color: AppColors.courseColors[2].toARGB32(),
      credits: 3,
      universityId: '1',
      description: 'Relational database design and SQL programming.',
    ),
    Course(
      id: '4',
      name: 'Linear Algebra',
      code: 'MATH201',
      professor: 'Dr. Madina Tursunova',
      day: 4, // Thursday
      startTime: 11,
      duration: 1.5,
      location: 'Room 150',
      color: AppColors.courseColors[3].toARGB32(),
      credits: 3,
      universityId: '2',
      description: 'Vector spaces, matrices, and linear transformations.',
    ),
    Course(
      id: '5',
      name: 'Software Engineering',
      code: 'CS401',
      professor: 'Prof. Bakhtiyor Saidov',
      day: 5, // Friday
      startTime: 13,
      duration: 2,
      location: 'Room 402',
      color: AppColors.courseColors[4].toARGB32(),
      credits: 4,
      universityId: '3',
      description: 'Software development lifecycle and project management.',
    ),
  ];

  // Board Posts
  static final List<Post> posts = [
    Post(
      id: '1',
      category: PostCategory.free,
      title: 'Best study spots in Tashkent?',
      content:
          'Hey everyone! I\'m looking for good places to study near TSUE. Any recommendations for quiet cafes or libraries?',
      author: 'Azizbek Rahimov',
      authorId: '1',
      authorAvatar: 'https://picsum.photos/seed/ar40/40/40',
      likes: 32,
      comments: 18,
      views: 245,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isAnonymous: false,
      tags: ['study', 'tashkent', 'cafe'],
      university: 'TSUE',
      major: 'Computer Science',
    ),
    Post(
      id: '2',
      category: PostCategory.question,
      title: 'CS201 Assignment Help',
      content:
          'Struggling with the graph algorithms problem. Anyone willing to explain BFS vs DFS?',
      author: 'Anonymous',
      authorId: 'anon_1',
      authorAvatar: 'https://picsum.photos/seed/anon1/40/40',
      likes: 5,
      comments: 15,
      views: 120,
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isAnonymous: true,
      tags: ['cs201', 'algorithms', 'help'],
      university: 'TUIT',
      major: 'Software Engineering',
    ),
    Post(
      id: '3',
      category: PostCategory.market,
      title: 'Selling Calculus Textbook',
      content:
          'Stewart Calculus 8th edition, barely used. Selling for 50,000 UZS. Pick up at TSUE.',
      author: 'Malika Karimova',
      authorId: '2',
      authorAvatar: 'https://picsum.photos/seed/mk40/40/40',
      likes: 3,
      comments: 2,
      views: 45,
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      isAnonymous: false,
      tags: ['textbook', 'calculus', 'sale'],
      university: 'NUUz',
      major: 'Mathematics',
    ),
    Post(
      id: '4',
      category: PostCategory.secret,
      title: 'Secret: Best professor ratings',
      content:
          'Don\'t tell anyone, but Dr. Ahmadjon\'s lectures are actually recorded and available online...',
      author: 'Anonymous',
      authorId: 'anon_2',
      authorAvatar: 'https://picsum.photos/seed/anon2/40/40',
      likes: 28,
      comments: 12,
      views: 310,
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      isAnonymous: true,
      tags: ['professor', 'secret', 'ratings'],
      university: 'IUT',
      major: 'Business',
    ),
    Post(
      id: '5',
      category: PostCategory.free,
      title: 'Group study session this weekend',
      content:
          'Planning a group study for midterms. Topics: Data Structures and Algorithms. Saturday 2 PM at Central Library.',
      author: 'Jasurbek Tursunov',
      authorId: '3',
      authorAvatar: 'https://picsum.photos/seed/jt40/40/40',
      likes: 18,
      comments: 6,
      views: 156,
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      isAnonymous: false,
      tags: ['study-group', 'midterms', 'algorithms'],
      university: 'TSUE',
      major: 'Economics',
    ),
  ];

  // Messages
  static final List<Message> messages = [
    Message(
      id: '1',
      senderId: '1',
      recipientId: '2',
      content: 'Hey Malika, are you coming to the study group tomorrow?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
    ),
    Message(
      id: '2',
      senderId: '2',
      recipientId: '1',
      content: 'Yes! I\'ll be there around 2 PM. Should I bring my notes?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      isRead: true,
    ),
    Message(
      id: '3',
      senderId: '1',
      recipientId: '2',
      content: 'That would be great! Thanks 😊',
      timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      isRead: false,
    ),
  ];

  // Chat conversations (grouped messages)
  static final List<Conversation> conversations = [
    Conversation(
      id: '1',
      participants: [users[0], users[1]], // Azizbek and Malika
      lastMessage: messages.last,
      unreadCount: 1,
      updatedAt: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
    Conversation(
      id: '2',
      participants: [users[0], users[2]], // Azizbek and Jasurbek
      lastMessage: Message(
        id: '4',
        senderId: '3',
        recipientId: '1',
        content: 'See you at the group study!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isRead: true,
      ),
      unreadCount: 0,
      updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
  ];

  // Cafeteria Items
  static final List<CafeteriaItem> cafeteriaItems = [
    CafeteriaItem(
      id: '1',
      name: 'Plov (Pilaf)',
      price: '25,000',
      category: CafeteriaCategory.food,
      imageUrl: 'https://picsum.photos/seed/plov/200/150',
      description: 'Traditional Uzbek rice dish with meat and carrots',
    ),
    CafeteriaItem(
      id: '2',
      name: 'Green Tea',
      price: '5,000',
      category: CafeteriaCategory.drink,
      imageUrl: 'https://picsum.photos/seed/tea/200/150',
      description: 'Fresh green tea',
    ),
    CafeteriaItem(
      id: '3',
      name: 'Beshbarmak',
      price: '30,000',
      category: CafeteriaCategory.food,
      imageUrl: 'https://picsum.photos/seed/beshbarmak/200/150',
      description: 'Kazakh meat and noodle dish',
    ),
    CafeteriaItem(
      id: '4',
      name: 'Kompot',
      price: '8,000',
      category: CafeteriaCategory.drink,
      imageUrl: 'https://picsum.photos/seed/kompot/200/150',
      description: 'Fruit drink made from dried fruits',
    ),
  ];

  // Comments
  static final List<Comment> comments = [
    Comment(
      id: '1',
      postId: '1',
      author: 'Sardor_21',
      authorAvatar: 'https://picsum.photos/seed/sardor/40/40',
      content: 'Try Cafe Mix on Amir Temur! Great coffee and fast wifi',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      likes: 8,
    ),
    Comment(
      id: '2',
      postId: '1',
      author: 'Jamshid_dev',
      authorAvatar: 'https://picsum.photos/seed/jamshid/40/40',
      content: 'Thanks! Will check it out',
      timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
      likes: 2,
      parentId: '1',
    ),
    Comment(
      id: '3',
      postId: '1',
      author: 'Nigora_student',
      authorAvatar: 'https://picsum.photos/seed/nigora/40/40',
      content: 'Coffee Land has student discounts!',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      likes: 15,
    ),
  ];

  // Helper methods
  static University getUniversityById(String id) {
    return universities.firstWhere((u) => u.id == id);
  }

  static User getUserById(String id) {
    return users.firstWhere((u) => u.id == id);
  }

  static List<Course> getCoursesByDay(int day) {
    return courses.where((c) => c.day == day).toList();
  }

  static List<Post> getPostsByCategory(PostCategory category) {
    return posts.where((p) => p.category == category).toList();
  }
  
  static List<Comment> getCommentsByPostId(String postId) {
    // Return top-level comments (no parent) for the post
    // The UI handles fetching replies recursively if needed, or we just flat list them.
    // For this simple mock, we'll return all and filter in UI or return nested structure.
    // Let's return all for now.
    return comments.where((c) => c.postId == postId).toList();
  }
}

// Data Models
class Comment {
  final String id;
  final String postId;
  final String author;
  final String? authorAvatar;
  final String content;
  final DateTime timestamp;
  final int likes;
  final String? parentId; // For nested replies

  const Comment({
    required this.id,
    required this.postId,
    required this.author,
    this.authorAvatar,
    required this.content,
    required this.timestamp,
    required this.likes,
    this.parentId,
  });

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}


class University {
  final String id;
  final String name;
  final String shortName;
  final int color;
  final String logoUrl;

  const University({
    required this.id,
    required this.name,
    required this.shortName,
    required this.color,
    required this.logoUrl,
  });
}

class User {
  final String id;
  final String name;
  final String email;
  final String universityId;
  final String? avatarUrl;
  final String? major;
  final int? year;
  final bool isOnline;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.universityId,
    this.avatarUrl,
    this.major,
    this.year,
    this.isOnline = false,
  });

  University get university => MockData.getUniversityById(universityId);
}

class Course {
  final String id;
  final String name;
  final String code;
  final String professor;
  final int day; // 1 = Monday, 7 = Sunday
  final double startTime; // Hour (8.0 = 8:00 AM)
  final double duration; // In hours
  final String location;
  final int color;
  final int credits;
  final String universityId;
  final String description;

  const Course({
    required this.id,
    required this.name,
    required this.code,
    required this.professor,
    required this.day,
    required this.startTime,
    required this.duration,
    required this.location,
    required this.color,
    required this.credits,
    required this.universityId,
    required this.description,
  });

  University get university => MockData.getUniversityById(universityId);

  DateTime get startDateTime {
    final now = DateTime.now();
    final daysToAdd = day - now.weekday;
    final courseDate = now.add(Duration(days: daysToAdd));
    final hour = startTime.toInt();
    final minute = ((startTime - hour) * 60).toInt();
    return DateTime(
      courseDate.year,
      courseDate.month,
      courseDate.day,
      hour,
      minute,
    );
  }

  DateTime get endDateTime {
    return startDateTime.add(Duration(minutes: (duration * 60).toInt()));
  }

  String get dayName {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[day - 1];
  }

  String get timeRange {
    final start =
        '${startTime.toInt()}:${((startTime - startTime.toInt()) * 60).toInt().toString().padLeft(2, '0')}';
    final endTime = startTime + duration;
    final end =
        '${endTime.toInt()}:${((endTime - endTime.toInt()) * 60).toInt().toString().padLeft(2, '0')}';
    return '$start - $end';
  }
}

enum PostCategory { free, secret, question, market }

class Post {
  final String id;
  final PostCategory category;
  final String title;
  final String content;
  final String author;
  final String authorId;
  final String? authorAvatar;
  final int likes;
  final int comments;
  final int views;
  final DateTime timestamp;
  final bool isAnonymous;
  final List<String> tags;
  final String? university;
  final String? major;

  const Post({
    required this.id,
    required this.category,
    required this.title,
    required this.content,
    required this.author,
    required this.authorId,
    this.authorAvatar,
    required this.likes,
    required this.comments,
    required this.views,
    required this.timestamp,
    required this.isAnonymous,
    required this.tags,
    this.university,
    this.major,
  });

  String get categoryName {
    switch (category) {
      case PostCategory.free:
        return 'Erkin';
      case PostCategory.secret:
        return 'Sirli';
      case PostCategory.question:
        return 'Savol';
      case PostCategory.market:
        return 'Bozor';
    }
  }

  int get categoryColor {
    switch (category) {
      case PostCategory.free:
        return AppColors.boardFree.toARGB32();
      case PostCategory.secret:
        return AppColors.boardSecret.toARGB32();
      case PostCategory.question:
        return AppColors.boardQuestion.toARGB32();
      case PostCategory.market:
        return AppColors.boardMarket.toARGB32();
    }
  }

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  Post copyWith({
    String? id,
    PostCategory? category,
    String? title,
    String? content,
    String? author,
    String? authorId,
    String? authorAvatar,
    int? likes,
    int? comments,
    int? views,
    DateTime? timestamp,
    bool? isAnonymous,
    List<String>? tags,
    String? university,
    String? major,
  }) {
    return Post(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      authorId: authorId ?? this.authorId,
      authorAvatar: authorAvatar ?? this.authorAvatar,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      views: views ?? this.views,
      timestamp: timestamp ?? this.timestamp,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      tags: tags ?? this.tags,
      university: university ?? this.university,
      major: major ?? this.major,
    );
  }
}

class Message {
  final String id;
  final String senderId;
  final String recipientId;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  const Message({
    required this.id,
    required this.senderId,
    required this.recipientId,
    required this.content,
    required this.timestamp,
    required this.isRead,
  });

  User get sender => MockData.getUserById(senderId);
  User get recipient => MockData.getUserById(recipientId);

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class Conversation {
  final String id;
  final List<User> participants;
  final Message lastMessage;
  final int unreadCount;
  final DateTime updatedAt;

  const Conversation({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.unreadCount,
    required this.updatedAt,
  });

  User get otherParticipant {
    // Assuming current user is the first one for demo
    return participants.last;
  }

  String get conversationName {
    return otherParticipant.name;
  }

  String get conversationAvatar {
    return otherParticipant.avatarUrl ??
        'https://picsum.photos/seed/default/40/40';
  }
}

enum CafeteriaCategory { food, drink }

class CafeteriaItem {
  final String id;
  final String name;
  final String price;
  final CafeteriaCategory category;
  final String? imageUrl;
  final String? description;

  const CafeteriaItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.imageUrl,
    this.description,
  });

  String get categoryName {
    switch (category) {
      case CafeteriaCategory.food:
        return 'Taom';
      case CafeteriaCategory.drink:
        return 'Ichimlik';
    }
  }
}
