import 'package:get/get.dart';

import 'package:airportshuttle4less/presentation/controllers/profile/leave_review_controller.dart';
import 'package:airportshuttle4less/presentation/controllers/profile/reviews_controller.dart';

/// Binding for Reviews and Leave Review screens.
class ReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewsController>(() => ReviewsController());
    Get.lazyPut<LeaveReviewController>(() => LeaveReviewController());
  }
}
