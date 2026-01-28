// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get helloWorld => '안녕하세요!';

  @override
  String get editPost => '게시물 수정';

  @override
  String get cancel => '취소';

  @override
  String get save => '저장';

  @override
  String get deletePost => '게시물 삭제';

  @override
  String get confirmDeletePost => '이 게시물을 삭제하시겠습니까?';

  @override
  String get editComment => '댓글 수정';

  @override
  String get deleteComment => '댓글 삭제';

  @override
  String get confirmDeleteComment => '이 댓글을 삭제하시겠습니까?';

  @override
  String get universityVerificationRequired => '대학교 인증이 필요합니다';

  @override
  String get universityVerificationRequiredAccess =>
      '이 커뮤니티에 접근하려면 대학교 인증이 필요합니다';

  @override
  String get title => '제목';

  @override
  String get content => '내용';

  @override
  String get selectCommunity => '커뮤니티 선택';

  @override
  String get chat => '채팅';

  @override
  String get chatListEmpty => '채팅이 없습니다';

  @override
  String get chatListEmptyHint => '+ 버튼을 눌러 대화를 시작하세요';

  @override
  String get chatLoadError => '채팅 목록을 불러오지 못했습니다';

  @override
  String get newChat => '새 채팅';

  @override
  String get searchUsers => '사용자 검색...';

  @override
  String selectedCount(int count) {
    return '$count명 선택됨';
  }

  @override
  String get startChat => '채팅 시작';

  @override
  String get createGroup => '그룹 만들기';

  @override
  String get groupName => '그룹 이름';

  @override
  String get groupNameHint => '그룹 이름을 입력하세요';

  @override
  String get camera => '카메라';

  @override
  String get gallery => '갤러리';

  @override
  String get connectionConnected => '연결됨';

  @override
  String get connectionConnecting => '연결 중...';

  @override
  String get connectionDisconnected => '연결 끊김 - 탭하여 재연결';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String get messageHint => '메시지를 입력하세요...';
}
