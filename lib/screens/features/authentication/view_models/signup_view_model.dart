import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';

/// 이 VM은 계정을 만들 때 로딩화면을 보여주고 계정 생성을 트리거
/// 그래서 로딩여부 말고는 필요한 value가 없음
class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);

    state = await AsyncValue.guard(
        () async => await _authRepo.signUp(form["email"], form["password"]));
  }
}

/// StateProvider
/// 바깥에서 value를 수정할 수 있게 보여줌
final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
