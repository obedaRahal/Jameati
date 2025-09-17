import 'package:flutter/material.dart';
import 'package:project_manag_ite/core/class/status_request.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView({
    super.key,
    required this.statusRequest,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(child: Text("Loading"))
        : statusRequest == StatusRequest.offlinefailure
            ? const Center(child: Text("offlinefailure"))
            : statusRequest == StatusRequest.serverfaliure
                ? const Center(child: Text("serverfaliure"))
                : statusRequest == StatusRequest.failure
                    ? const Center(child: Text("no data or validdation"))
                    : widget;
  }
}
