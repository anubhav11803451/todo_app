import 'package:get/state_manager.dart';
import 'package:todo_app/models/quotemodel.dart';
import 'package:todo_app/services/remoteServices.dart';

class QuotesController extends GetxController {
  var quotemodel = QuoteModel().obs.value;

  @override
  void onInit() {
    fetchQuotes();
    super.onInit();
  }

  void fetchQuotes() async {
    final quotes = await RemoteServices.fetchQuotes();
    if (quotes != null) {
      quotemodel = quotes;
    }
  }
}
