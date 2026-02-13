import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../auth/domain/entities/university.dart';
import '../../../auth/presentation/providers/university_provider.dart';
import '../../domain/entities/user_profile.dart';
import '../providers/profile_provider.dart';

/// Edit Profile screen - allows users to update their profile information
class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _introductionController = TextEditingController();
  final _majorController = TextEditingController();

  int? _selectedUniversityId;
  bool _isSaving = false;
  bool _isUploadingAvatar = false;

  @override
  void initState() {
    super.initState();
    // Initialize form fields from current profile after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFields();
    });
  }

  void _initializeFields() {
    final profile = ref.read(profileProvider).profile;
    if (profile != null) {
      _nicknameController.text = profile.fullName;
      _introductionController.text = profile.bio ?? '';
      _majorController.text = profile.major ?? '';
      setState(() {
        _selectedUniversityId = profile.universityId != null
            ? int.tryParse(profile.universityId!)
            : null;
      });
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _introductionController.dispose();
    _majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(userProfileProvider);
    final universitiesAsync = ref.watch(universitiesProvider);

    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textPrimaryColor),
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          l10n.editProfile,
          style: AppTypography.headlineSmall.copyWith(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveProfile,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    l10n.save,
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ],
      ),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar Section
                    _buildAvatarSection(profile),

                    SizedBox(height: AppSpacing.xl),

                    // Nickname Field
                    _buildSectionLabel(l10n.nickname),
                    SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _nicknameController,
                      decoration: _inputDecoration(
                        hintText: l10n.nickname,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.validationNicknameRequired;
                        }
                        if (value.trim().length < 2 ||
                            value.trim().length > 20) {
                          return l10n.validationNickname2to20;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Introduction Field
                    _buildSectionLabel(l10n.introduction),
                    SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _introductionController,
                      decoration: _inputDecoration(
                        hintText: l10n.introductionHint,
                      ),
                      maxLines: 3,
                      maxLength: 200,
                      validator: (value) {
                        if (value != null && value.length > 200) {
                          return l10n.introductionMaxLength;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // University Field
                    _buildSectionLabel(l10n.selectUniversity),
                    SizedBox(height: AppSpacing.sm),
                    universitiesAsync.when(
                      loading: () => const LinearProgressIndicator(),
                      error: (_, __) => Text(
                        l10n.errorOccurred,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                      data: (universities) =>
                          _buildUniversityDropdown(universities, l10n),
                    ),

                    SizedBox(height: AppSpacing.lg),

                    // Major Field
                    _buildSectionLabel(l10n.major),
                    SizedBox(height: AppSpacing.sm),
                    TextFormField(
                      controller: _majorController,
                      decoration: _inputDecoration(
                        hintText: l10n.majorHint,
                      ),
                    ),

                    SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAvatarSection(UserProfile profile) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Column(
        children: [
          SizedBox(height: AppSpacing.md),
          GestureDetector(
            onTap: _isUploadingAvatar ? null : _pickImage,
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.borderColor,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: _isUploadingAvatar
                        ? Container(
                            color: context.surfaceVariantColor,
                            child: const Center(
                              child:
                                  CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : profile.avatarUrl != null
                            ? CachedNetworkImage(
                                imageUrl: profile.avatarUrl!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                                placeholder: (context, url) => Container(
                                  color: context.surfaceVariantColor,
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    _buildDefaultAvatar(profile),
                              )
                            : _buildDefaultAvatar(profile),
                  ),
                ),
                // Camera icon overlay
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.surfaceColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            l10n.changePhoto,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(UserProfile profile) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary,
            AppColors.secondaryDark,
          ],
        ),
      ),
      child: Center(
        child: Text(
          profile.displayNameOrFullName.isNotEmpty
              ? profile.displayNameOrFullName[0].toUpperCase()
              : '?',
          style: AppTypography.displayMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: AppTypography.bodyMedium.copyWith(
        color: context.textSecondaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildUniversityDropdown(
    List<University> universities,
    AppLocalizations l10n,
  ) {
    return DropdownButtonFormField<int>(
      value: _selectedUniversityId,
      decoration: _inputDecoration(
        hintText: l10n.pleaseSelectUniversity,
      ),
      isExpanded: true,
      items: universities.map((uni) {
        return DropdownMenuItem<int>(
          value: uni.id,
          child: Text(
            uni.name,
            style: AppTypography.bodyLarge.copyWith(
              color: context.textPrimaryColor,
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedUniversityId = value;
        });
      },
    );
  }

  InputDecoration _inputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: AppTypography.bodyLarge.copyWith(
        color: context.textHintColor,
      ),
      filled: true,
      fillColor: context.surfaceVariantColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        borderSide: BorderSide(
          color: context.borderColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        borderSide: BorderSide(
          color: AppColors.error,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        borderSide: BorderSide(
          color: AppColors.error,
          width: 2,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
    );
  }

  Future<void> _pickImage() async {
    final l10n = AppLocalizations.of(context)!;

    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.selectImageSource,
                style: AppTypography.headlineSmall.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: AppSpacing.md),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.camera_alt, color: AppColors.primary),
                ),
                title: Text(l10n.camera),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.tertiary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:
                      const Icon(Icons.photo_library, color: AppColors.tertiary),
                ),
                title: Text(l10n.gallery),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              SizedBox(height: AppSpacing.sm),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    setState(() => _isUploadingAvatar = true);

    final success = await ref
        .read(profileProvider.notifier)
        .uploadAvatar(pickedFile.path);

    setState(() => _isUploadingAvatar = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? l10n.profileUpdated : l10n.avatarUploadFailed,
          ),
        ),
      );
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context)!;

    setState(() => _isSaving = true);

    final success =
        await ref.read(profileProvider.notifier).updateProfileFields(
              fullName: _nicknameController.text.trim(),
              bio: _introductionController.text.trim(),
              major: _majorController.text.trim().isNotEmpty
                  ? _majorController.text.trim()
                  : null,
            );

    // Update university separately if changed
    final currentProfile = ref.read(profileProvider).profile;
    if (success && _selectedUniversityId != null) {
      final currentUniId = currentProfile?.universityId != null
          ? int.tryParse(currentProfile!.universityId!)
          : null;
      if (_selectedUniversityId != currentUniId) {
        final updatedProfile = currentProfile!.copyWithProfile(
          universityId: _selectedUniversityId.toString(),
        );
        await ref.read(profileProvider.notifier).updateProfile(updatedProfile);
      }
    }

    setState(() => _isSaving = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? l10n.profileUpdated : l10n.profileUpdateFailed,
          ),
        ),
      );
      if (success) {
        GoRouter.of(context).pop();
      }
    }
  }
}
