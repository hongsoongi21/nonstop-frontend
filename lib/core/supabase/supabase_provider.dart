import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';

/// Provider for the Supabase client instance
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return SupabaseConfig.client;
});

/// Provider for Supabase Auth
final supabaseAuthProvider = Provider<GoTrueClient>((ref) {
  return ref.watch(supabaseClientProvider).auth;
});

/// Provider for current Supabase auth state changes
final authStateChangesProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(supabaseClientProvider).auth.onAuthStateChange;
});

/// Provider for current Supabase user
final supabaseUserProvider = Provider<User?>((ref) {
  return ref.watch(supabaseClientProvider).auth.currentUser;
});
