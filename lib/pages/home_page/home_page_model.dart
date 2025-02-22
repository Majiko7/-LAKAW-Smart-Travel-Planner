import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'dart:async';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  int? limit = 10;

  List<DestinationsRow> destinations = [];
  void addToDestinations(DestinationsRow item) => destinations.add(item);
  void removeFromDestinations(DestinationsRow item) =>
      destinations.remove(item);
  void removeAtIndexFromDestinations(int index) => destinations.removeAt(index);
  void insertAtIndexInDestinations(int index, DestinationsRow item) =>
      destinations.insert(index, item);
  void updateDestinationsAtIndex(
          int index, Function(DestinationsRow) updateFn) =>
      destinations[index] = updateFn(destinations[index]);

  List<DestinationsRow> searchedDestinations = [];
  void addToSearchedDestinations(DestinationsRow item) =>
      searchedDestinations.add(item);
  void removeFromSearchedDestinations(DestinationsRow item) =>
      searchedDestinations.remove(item);
  void removeAtIndexFromSearchedDestinations(int index) =>
      searchedDestinations.removeAt(index);
  void insertAtIndexInSearchedDestinations(int index, DestinationsRow item) =>
      searchedDestinations.insert(index, item);
  void updateSearchedDestinationsAtIndex(
          int index, Function(DestinationsRow) updateFn) =>
      searchedDestinations[index] = updateFn(searchedDestinations[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in HomePage widget.
  List<DestinationsRow>? allDestinations;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<String> simpleSearchResults = [];
  // State field(s) for ListView widget.

  PagingController<ApiPagingParams, dynamic>? listViewPagingController2;
  Function(ApiPagingParams nextPageMarker)? listViewApiCall2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    listViewPagingController2?.dispose();
  }

  /// Additional helper methods.
  PagingController<ApiPagingParams, dynamic> setListViewController2(
    Function(ApiPagingParams) apiCall,
  ) {
    listViewApiCall2 = apiCall;
    return listViewPagingController2 ??= _createListViewController2(apiCall);
  }

  PagingController<ApiPagingParams, dynamic> _createListViewController2(
    Function(ApiPagingParams) query,
  ) {
    final controller = PagingController<ApiPagingParams, dynamic>(
      firstPageKey: ApiPagingParams(
        nextPageNumber: 0,
        numItems: 0,
        lastResponse: null,
      ),
    );
    return controller..addPageRequestListener(listViewGetDestinationNamePage2);
  }

  void listViewGetDestinationNamePage2(ApiPagingParams nextPageMarker) =>
      listViewApiCall2!(nextPageMarker)
          .then((listViewGetDestinationNameResponse) {
        final pageItems = ((listViewGetDestinationNameResponse.jsonBody
                        .toList()
                        .map<DestinationsStruct?>(
                            DestinationsStruct.maybeFromMap)
                        .toList() as Iterable<DestinationsStruct?>)
                    .withoutNulls ??
                [])
            .toList() as List;
        final newNumItems = nextPageMarker.numItems + pageItems.length;
        listViewPagingController2?.appendPage(
          pageItems,
          (pageItems.length > 0)
              ? ApiPagingParams(
                  nextPageNumber: nextPageMarker.nextPageNumber + 1,
                  numItems: newNumItems,
                  lastResponse: listViewGetDestinationNameResponse,
                )
              : null,
        );
      });

  Future waitForOnePageForListView2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete =
          (listViewPagingController2?.nextPageKey?.nextPageNumber ?? 0) > 0;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
