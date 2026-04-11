import 'package:nonstop/core/l10n/app_localizations.dart';

import '../../domain/entities/board.entity.dart';

extension BoardDisplay on Board {
  /// Returns the localized display name for system boards (identified by slug),
  /// or the raw [name] for user-created boards (slug == null).
  String displayName(AppLocalizations l10n) {
    switch (slug) {
      case 'free':
        return l10n.boardFree;
      case 'anonymous':
        return l10n.boardAnonymous;
      case 'info':
        return l10n.boardInfo;
      case 'qna':
        return l10n.boardQna;
      case 'notice':
        return l10n.boardNotice;
      default:
        return name;
    }
  }
}
