import 'package:get/get.dart';

import 'package:airportshuttle4less/core/widgets/feedback/app_toast.dart';
import 'package:airportshuttle4less/domain/entities/comment.dart';
import 'package:airportshuttle4less/domain/use_cases/support_use_case.dart';
import 'package:airportshuttle4less/core/utils/app_texts/app_texts.dart';
import 'package:airportshuttle4less/presentation/routes/app_routes.dart';

/// Controller for Reviews screen: load comments, navigate to leave review, delete.
class ReviewsController extends GetxController {
  final SupportUseCase _supportUseCase = Get.find<SupportUseCase>();

  final RxList<Comment> comments = <Comment>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isDeleting = false.obs;

  @override
  void onReady() {
    super.onReady();
    loadComments();
  }

  Future<void> loadComments() async {
    isLoading.value = true;
    try {
      final list = await _supportUseCase.loadAllComments();
      comments.assignAll(list);
    } catch (_) {
      comments.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToLeaveReview() {
    Get.toNamed(AppRoutes.leaveReview)?.then((_) {
      loadComments();
    });
  }

  Future<void> deleteComment(int sid) async {
    isDeleting.value = true;
    try {
      final success = await _supportUseCase.deleteComment(sid);
      if (success) {
        comments.removeWhere((c) => c.sid == sid);
        AppToast.showSuccess(AppTexts.success, AppTexts.reviewDeleted);
      }
    } finally {
      isDeleting.value = false;
    }
  }
}
