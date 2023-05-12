import 'package:bayapar_retailer/consts/consts.dart';
import 'package:bayapar_retailer/models/customer_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import '../../controller/retailer_detail_controller.dart';
import 'add_amount.dart';
import 'component/custom_card.dart';





class Account_details extends StatefulWidget {
  final Customer customer;
  final void Function() onCustomerAdded;


  const Account_details({Key? key, required this.customer,required this.onCustomerAdded}) : super(key: key);

  @override
  State<Account_details> createState() => _Account_detailsState();
}

class _Account_detailsState extends State<Account_details> {
  final CustomersService _customerService = CustomersService();
  int totaludaro = 0;
  int totalCash = 0;
  int udaropending =0;
  bool _dataUpdated = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _customerService.getTransactions(widget.customer.name,widget.customer.retailerPhoneNumber);



    _scrollController.addListener(() {
      if (_dataUpdated) {
        setState(() {
          totaludaro = 0;
          totalCash = 0;
          udaropending = 0;
          _dataUpdated = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _customerService.getTransactions(widget.customer.name,widget.customer.retailerPhoneNumber);
      int newTotaludaro = 0;
      int newTotalCash = 0;
      for (var transaction in _customerService.transactions) {
        if (transaction.type == 'udaro' && transaction.amount != 0) {
          newTotaludaro += transaction.amount;
        } else if (transaction.type == 'cash') {
          newTotalCash += transaction.amount;
        }
      }
      int newUdaropending = newTotaludaro - newTotalCash;
      if (newTotaludaro != totaludaro || newTotalCash != totalCash || newUdaropending != udaropending) {
        totaludaro = newTotaludaro;
        totalCash = newTotalCash;
        udaropending = newUdaropending;
        _dataUpdated = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: Text(
          'Account Details',
          style: TextStyle(
            fontFamily: 'semibold',
            color: Colors.red,
          ),
        ),
      ),

      body:  RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCard(
                  text: 'उधारो',
                  amount: 'Rs. ${totaludaro}',
                  color: Colors.green.shade50,
                ),
                _buildInfoCard(
                  text: 'बाकी ',
                  amount: 'Rs. ${udaropending}',
                  color: Colors.yellow.shade50,
                ),
                _buildInfoCard(
                  text: 'नगद',
                  amount: 'Rs. ${totalCash}',
                  color: Colors.blue.shade50,
                ),
              ],
            ),
          ),
            Expanded(
              child: Obx(() {
                final transction = _customerService.transactions;
                final isLoading = _customerService.isLoading;

                if (transction.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.arrow_drop_up, size: 40.0),
                      SizedBox(height: 10.0),
                      Text("No Transaction", style: TextStyle(fontSize: 20.0)),
                      SizedBox(height: 10.0),
                      Icon(Icons.arrow_drop_down, size: 40.0),
                    ],
                  );
                } else {

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isLoading) // Show the circular loader if isLoading is true
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Card(
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'History: ${widget.customer.name} | ${widget.customer.phoneNumber}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'regular',
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: widget.customer.transactions.isEmpty
                                        ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.arrow_upward, size: 64),
                                        SizedBox(height: 16),
                                        Text(
                                          'No transactions yet',
                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 16),
                                        Icon(Icons.arrow_downward, size: 64),
                                      ],
                                    ): ListView.builder(
                                      itemCount: transction.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final transaction = transction.reversed.toList()[index];


                                        final transactionType = transaction.type == 'udaro' ? 'उधारो' : 'नगद';
                                        final transactionAmount =
                                        transaction.type == 'udaro' ? -transaction.amount : transaction.amount;
                                        final date = NepaliDateTime.parse(transaction.date);
                                        final formattedDate = NepaliDateFormat('yyyy-MM-dd').format(date);
                                        final color = transactionType == 'उधारो'
                                            ? Colors.redAccent[100]
                                            : Colors.lightGreen[100]; // Change the colors as per your preference

                                        // calculate the days difference between the transaction date and today's date
                                        final daysDiff = DateTime.now().difference(date.toDateTime()).inDays;
                                        String trailingText = '';
                                        if (daysDiff == 0) {
                                          trailingText = 'Today';
                                        } else if (daysDiff == 1) {
                                          trailingText = 'Yesterday';
                                        } else {
                                          trailingText = '$daysDiff days ago';
                                        }

                                        return ListTile(
                                          leading: CircleAvatar(
                                            backgroundColor: color,
                                            child: Icon(
                                              transactionType == 'उधारो'
                                                  ? Icons.arrow_downward
                                                  : Icons.arrow_upward,
                                              color: Colors.white,
                                            ),
                                          ),
                                          title: Text(
                                            transactionType,
                                            style: TextStyle(
                                              fontFamily: 'regular',
                                              fontSize: 16,
                                            ),
                                          ),
                                          subtitle: Text(
                                            formattedDate,
                                            style: TextStyle(
                                              fontFamily: 'regular',
                                              fontSize: 12,
                                            ),
                                          ),
                                          trailing: Text(
                                            '${trailingText} \nRs. ${transactionAmount}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'regular',
                                              fontSize: 12,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )

                  ;}}),
            ),
          ],
        ),
      ),



      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => AddTransactionPage(

                      onTransctionAdd: () {
                        setState(() {
                          _customerService.getTransactions(widget.customer.name,widget.customer.retailerPhoneNumber);
                        });
                      },
                      customername: widget.customer.name,
                      type: "udaro",
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        "उधारो ",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'semibold',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => AddTransactionPage(
                      onTransctionAdd: () {
                        setState(() {
                          _customerService.getTransactions(widget.customer.name,widget.customer.retailerPhoneNumber);
                        });
                      },
                      customername: widget.customer.name,
                      type: 'cash',
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        "नगद",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'semibold',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),



    );
  }

  Widget _buildInfoCard({required String text, required String amount, required Color color}) {
    return Expanded(
      child: Card(
        elevation: 0.5,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontFamily: 'regular',
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                amount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'bold',
                  fontSize: 20,
                  color: color == Colors.yellow.shade50 ? Colors.black : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}