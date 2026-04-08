import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nonstop/core/utils/date_utils.dart';
import 'package:nonstop/features/chat/domain/entities/chat_room.dart';
import 'package:nonstop/features/chat/domain/entities/chat_message.dart';

abstract class ChatApi {
  Future<List<ChatRoom>> getMyChatRooms();
  Future<List<ChatMessage>> getMessages(int roomId, int limit, int offset);
  Future<ChatRoom> createOneToOneRoom(int targetUserId, {String? roomName});
  Future<ChatRoom> createGroupRoom(String name, List<int> userIds);

  Future<void> leaveRoom(int roomId);
  Future<void> inviteToGroup(int roomId, List<int> userIds);
  Future<void> kickFromGroup(int roomId, int userId);
  Future<List<int>> getGroupMembers(int roomId);
  Future<void> markAsRead(int roomId, int messageId);
  Future<Map<int, int>> getReadStatuses(int roomId);
  Future<String> uploadChatImage(int roomId, String localFilePath);

  /// Send a message and return the created ChatMessage
  Future<ChatMessage> sendMessage({
    required int roomId,
    required String content,
    required String type,
    required int clientMessageId,
  });
}

class ChatApiImpl implements ChatApi {
  final SupabaseClient _supabase;

  ChatApiImpl(this._supabase);

  Future<int> _getCurrentUserId() async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw Exception('Not authenticated');
    final data = await _supabase
        .from('users')
        .select('id')
        .eq('auth_id', authUser.id)
        .single();
    return data['id'] as int;
  }

  @override
  Future<List<ChatRoom>> getMyChatRooms() async {
    final currentUserId = await _getCurrentUserId();

    // Get user's active room memberships
    final memberships = await _supabase
        .from('chat_room_members')
        .select('room_id, last_read_message_id')
        .eq('user_id', currentUserId)
        .isFilter('left_at', null);

    final memberList = memberships as List;
    if (memberList.isEmpty) return [];

    final roomIds = memberList.map((m) => m['room_id'] as int).toList();
    final lastReadMap = <int, int?>{};
    for (final m in memberList) {
      lastReadMap[m['room_id'] as int] = m['last_read_message_id'] as int?;
    }

    // Get room details
    final rooms = await _supabase
        .from('chat_rooms')
        .select()
        .inFilter('id', roomIds);

    // Get last message per room + unread counts in parallel
    final lastMessages = <int, Map<String, dynamic>>{};
    final unreadCounts = <int, int>{};

    await Future.wait(roomIds.map((roomId) async {
      // Last message
      final msgs = await _supabase
          .from('messages')
          .select()
          .eq('chat_room_id', roomId)
          .order('sent_at', ascending: false)
          .limit(1);
      if ((msgs as List).isNotEmpty) {
        lastMessages[roomId] = msgs.first;
      }

      // Unread count (본인이 보낸 메시지는 제외)
      final lastReadId = lastReadMap[roomId];
      if (lastReadId != null) {
        final unread = await _supabase
            .from('messages')
            .select('id')
            .eq('chat_room_id', roomId)
            .neq('sender_id', currentUserId)
            .gt('id', lastReadId);
        unreadCounts[roomId] = (unread as List).length;
      } else {
        final all = await _supabase
            .from('messages')
            .select('id')
            .eq('chat_room_id', roomId)
            .neq('sender_id', currentUserId);
        unreadCounts[roomId] = (all as List).length;
      }
    }));

    // Get member IDs per room
    final allMembers = await _supabase
        .from('chat_room_members')
        .select('room_id, user_id')
        .inFilter('room_id', roomIds)
        .isFilter('left_at', null);

    final membersByRoom = <int, List<int>>{};
    for (final m in allMembers as List) {
      final roomId = m['room_id'] as int;
      membersByRoom.putIfAbsent(roomId, () => []);
      membersByRoom[roomId]!.add(m['user_id'] as int);
    }

    // Resolve nicknames for 1:1 rooms
    final oneToOneRooms = (rooms as List).where((r) => r['type'] == 'ONE_TO_ONE').toList();
    final otherUserIds = <int>{};
    for (final room in oneToOneRooms) {
      final roomId = room['id'] as int;
      final members = membersByRoom[roomId] ?? [];
      for (final memberId in members) {
        if (memberId != currentUserId) {
          otherUserIds.add(memberId);
        }
      }
    }

    final nicknameMap = <int, String>{};
    if (otherUserIds.isNotEmpty) {
      final users = await _supabase
          .from('users')
          .select('id, nickname')
          .inFilter('id', otherUserIds.toList());
      for (final u in users as List) {
        nicknameMap[u['id'] as int] = u['nickname'] as String? ?? '';
      }
    }

    // Build ChatRoom entities
    return (rooms as List).map((room) {
      final roomId = room['id'] as int;
      final lastMsg = lastMessages[roomId];
      ChatMessage? lastMessage;
      if (lastMsg != null) {
        lastMessage = _mapToMessage(lastMsg);
      }

      final isAnonymous = (room['is_anonymous'] as bool?) ?? false;
      return ChatRoom(
        id: roomId,
        type: room['type'] == 'GROUP'
            ? ChatRoomType.group
            : ChatRoomType.oneToOne,
        name: isAnonymous
            ? (room['name'] as String?)
            : (room['name'] as String? ??
                _resolveOneToOneName(
                    room, membersByRoom, nicknameMap, currentUserId)),
        unreadCount: unreadCounts[roomId] ?? 0,
        lastMessage: lastMessage,
        memberIds: membersByRoom[roomId],
        updatedAt: room['updated_at'] != null
            ? parseUtcDateTime(room['updated_at'] as String)
            : null,
        isAnonymous: isAnonymous,
      );
    }).toList()
      ..sort((a, b) {
        final aTime =
            a.lastMessage?.sentAt ?? a.updatedAt ?? DateTime(2000);
        final bTime =
            b.lastMessage?.sentAt ?? b.updatedAt ?? DateTime(2000);
        return bTime.compareTo(aTime);
      });
  }

  String? _resolveOneToOneName(
    Map<String, dynamic> room,
    Map<int, List<int>> membersByRoom,
    Map<int, String> nicknameMap,
    int currentUserId,
  ) {
    if (room['type'] != 'ONE_TO_ONE') return null;
    final roomId = room['id'] as int;
    final members = membersByRoom[roomId] ?? [];
    for (final memberId in members) {
      if (memberId != currentUserId) {
        return nicknameMap[memberId];
      }
    }
    return null;
  }

  ChatMessage _mapToMessage(Map<String, dynamic> data) {
    final typeStr = (data['type'] as String? ?? 'TEXT').toLowerCase();
    MessageType type;
    switch (typeStr) {
      case 'image':
        type = MessageType.image;
        break;
      case 'system_invite':
        type = MessageType.systemInvite;
        break;
      case 'system_leave':
        type = MessageType.systemLeave;
        break;
      case 'system_kick':
        type = MessageType.systemKick;
        break;
      default:
        type = MessageType.text;
    }

    return ChatMessage(
      id: data['id'] as int,
      roomId: data['chat_room_id'] as int? ?? 0,
      senderId: data['sender_id'] as int? ?? 0,
      content: data['content'] as String? ?? '',
      type: type,
      sentAt: data['sent_at'] != null
          ? parseUtcDateTime(data['sent_at'] as String)
          : DateTime.now(),
      clientMessageId: data['client_message_id']?.toString(),
    );
  }

  @override
  Future<List<ChatMessage>> getMessages(
      int roomId, int limit, int offset) async {
    final data = await _supabase
        .from('messages')
        .select()
        .eq('chat_room_id', roomId)
        .order('sent_at', ascending: false)
        .range(offset, offset + limit - 1);

    return (data as List).map((msg) => _mapToMessage(msg)).toList();
  }

  @override
  Future<ChatRoom> createOneToOneRoom(int targetUserId, {String? roomName}) async {
    final currentUserId = await _getCurrentUserId();

    // Fetch target user's nickname for room display
    final targetUser = await _supabase
        .from('users')
        .select('nickname')
        .eq('id', targetUserId)
        .maybeSingle();
    final targetNickname = targetUser?['nickname'] as String?;

    // Check if 1:1 room already exists (LEAST/GREATEST ensures order)
    final userA =
        currentUserId < targetUserId ? currentUserId : targetUserId;
    final userB =
        currentUserId < targetUserId ? targetUserId : currentUserId;

    final existing = await _supabase
        .from('one_to_one_chat_rooms')
        .select('room_id')
        .eq('user_a_id', userA)
        .eq('user_b_id', userB)
        .maybeSingle();

    if (existing != null) {
      final roomId = existing['room_id'] as int;

      // Re-join if previously left
      final member = await _supabase
          .from('chat_room_members')
          .select()
          .eq('room_id', roomId)
          .eq('user_id', currentUserId)
          .maybeSingle();

      if (member != null && member['left_at'] != null) {
        await _supabase
            .from('chat_room_members')
            .update({'left_at': null})
            .eq('room_id', roomId)
            .eq('user_id', currentUserId);
      }

      final room = await _supabase
          .from('chat_rooms')
          .select()
          .eq('id', roomId)
          .single();

      final isAnonymous = (room['is_anonymous'] as bool?) ?? false;
      return ChatRoom(
        id: roomId,
        type: ChatRoomType.oneToOne,
        name: isAnonymous
            ? (room['name'] as String?)
            : (targetNickname ?? room['name'] as String?),
        unreadCount: 0,
        memberIds: [currentUserId, targetUserId],
        updatedAt: parseUtcDateTime(room['updated_at'] as String),
        isAnonymous: isAnonymous,
      );
    }

    // Create new room
    final roomData = await _supabase
        .from('chat_rooms')
        .insert({
          'type': 'ONE_TO_ONE',
          'creator_id': currentUserId,
          if (roomName != null) 'name': roomName,
        })
        .select()
        .single();

    final roomId = roomData['id'] as int;

    // Create one_to_one record
    await _supabase.from('one_to_one_chat_rooms').insert({
      'room_id': roomId,
      'user_a_id': userA,
      'user_b_id': userB,
    });

    // Add both users as members (separate inserts for RLS compatibility)
    await _supabase.from('chat_room_members').insert(
      {'room_id': roomId, 'user_id': currentUserId},
    );
    await _supabase.from('chat_room_members').insert(
      {'room_id': roomId, 'user_id': targetUserId},
    );

    return ChatRoom(
      id: roomId,
      type: ChatRoomType.oneToOne,
      name: roomName ?? targetNickname,
      unreadCount: 0,
      memberIds: [currentUserId, targetUserId],
      updatedAt: parseUtcDateTime(roomData['updated_at'] as String),
      isAnonymous: (roomData['is_anonymous'] as bool?) ?? false,
    );
  }

  @override
  Future<ChatRoom> createGroupRoom(String name, List<int> userIds) async {
    final currentUserId = await _getCurrentUserId();

    final roomData = await _supabase
        .from('chat_rooms')
        .insert({
          'type': 'GROUP',
          'name': name,
          'creator_id': currentUserId,
        })
        .select()
        .single();

    final roomId = roomData['id'] as int;

    // Insert creator first (RLS: user_id = me), then others (RLS: EXISTS check)
    await _supabase.from('chat_room_members').insert(
      {'room_id': roomId, 'user_id': currentUserId},
    );
    for (final uid in userIds) {
      if (uid != currentUserId) {
        await _supabase.from('chat_room_members').insert(
          {'room_id': roomId, 'user_id': uid},
        );
      }
    }

    return ChatRoom(
      id: roomId,
      type: ChatRoomType.group,
      name: name,
      unreadCount: 0,
      memberIds: [currentUserId, ...userIds.where((uid) => uid != currentUserId)],
      updatedAt: parseUtcDateTime(roomData['updated_at'] as String),
      isAnonymous: (roomData['is_anonymous'] as bool?) ?? false,
    );
  }

  @override
  Future<void> leaveRoom(int roomId) async {
    final currentUserId = await _getCurrentUserId();
    await _supabase
        .from('chat_room_members')
        .update({'left_at': DateTime.now().toIso8601String()})
        .eq('room_id', roomId)
        .eq('user_id', currentUserId);
  }

  @override
  Future<void> inviteToGroup(int roomId, List<int> userIds) async {
    await _supabase.from('chat_room_members').insert(
      userIds
          .map((uid) => {'room_id': roomId, 'user_id': uid})
          .toList(),
    );
  }

  @override
  Future<void> kickFromGroup(int roomId, int userId) async {
    await _supabase
        .from('chat_room_members')
        .update({'left_at': DateTime.now().toIso8601String()})
        .eq('room_id', roomId)
        .eq('user_id', userId);
  }

  @override
  Future<List<int>> getGroupMembers(int roomId) async {
    final data = await _supabase
        .from('chat_room_members')
        .select('user_id')
        .eq('room_id', roomId)
        .isFilter('left_at', null);

    return (data as List).map((m) => m['user_id'] as int).toList();
  }

  @override
  Future<void> markAsRead(int roomId, int messageId) async {
    final currentUserId = await _getCurrentUserId();
    await _supabase
        .from('chat_room_members')
        .update({'last_read_message_id': messageId})
        .eq('room_id', roomId)
        .eq('user_id', currentUserId);
  }

  @override
  Future<Map<int, int>> getReadStatuses(int roomId) async {
    final currentUserId = await _getCurrentUserId();
    final data = await _supabase
        .from('chat_room_members')
        .select('user_id, last_read_message_id')
        .eq('room_id', roomId)
        .neq('user_id', currentUserId);

    final map = <int, int>{};
    for (final row in data as List) {
      final lastRead = row['last_read_message_id'];
      if (lastRead != null) {
        map[row['user_id'] as int] = lastRead as int;
      }
    }
    return map;
  }

  @override
  Future<String> uploadChatImage(int roomId, String localFilePath) async {
    final authUser = _supabase.auth.currentUser;
    if (authUser == null) throw Exception('Not authenticated');

    final file = File(localFilePath);
    final fileName =
        '${authUser.id}/${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

    await _supabase.storage.from('chat-images').upload(fileName, file);
    return _supabase.storage.from('chat-images').getPublicUrl(fileName);
  }

  @override
  Future<ChatMessage> sendMessage({
    required int roomId,
    required String content,
    required String type,
    required int clientMessageId,
  }) async {
    final currentUserId = await _getCurrentUserId();

    final data = await _supabase
        .from('messages')
        .insert({
          'chat_room_id': roomId,
          'sender_id': currentUserId,
          'content': content,
          'type': type,
          'client_message_id': clientMessageId,
        })
        .select()
        .single();

    // Update room's updated_at and mark sender's read position
    await Future.wait([
      _supabase
          .from('chat_rooms')
          .update({'updated_at': DateTime.now().toIso8601String()})
          .eq('id', roomId),
      _supabase
          .from('chat_room_members')
          .update({'last_read_message_id': data['id']})
          .eq('room_id', roomId)
          .eq('user_id', currentUserId),
    ]);

    return _mapToMessage(data);
  }
}
