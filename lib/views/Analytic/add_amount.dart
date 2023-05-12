import 'package:bayapar_retailer/consts/consts.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/retailer_detail_controller.dart';

class AddTransactionPage extends StatefulWidget {
  final String customername;
  final type;
  final void Function() onTransctionAdd;
  const AddTransactionPage({required this.customername, required this.type,required this.onTransctionAdd});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final CustomersService _controller = Get.put(CustomersService());

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  NepaliDateTime _nepaliDate = NepaliDateTime.now();

  String phoneNumber='';
  Future<String?> _getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  @override
  void initState() {
    super.initState();
    _getPhoneNumber().then((value) {
      setState(() {

        phoneNumber = value!.substring(4);

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          color: darkFontGrey,
        ),
        title: Text(
          'Add Transactions',
          style: TextStyle(fontFamily: semibold, color: redColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Date', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: <Widget>[
                      const Icon(Icons.calendar_today),
                      SizedBox(width: 8),
                      Text(
                        '${_nepaliDate.year}-${_nepaliDate.month}-${_nepaliDate.day}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _controller.addTransaction(phoneNumber,widget.customername, int.parse(_amountController.text), '${_nepaliDate}', widget.type);
                      widget.onTransctionAdd();
                      Navigator.pop(context);                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                    child: Text(
                      'Add Transaction${widget.customername}',
                      style: TextStyle(fontSize: 20, fontFamily: semibold, color: whiteColor),
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

  Future<void> _selectDate(BuildContext context) async {
    NepaliDateTime? picked = await showMaterialDatePicker(
      context: context,
      initialDate: _nepaliDate,
      firstDate: NepaliDateTime.parse("2000-01-01"),
      lastDate: NepaliDateTime.parse("2099-12-31"),
    );
    if (picked != null) {
      setState(() {
        _nepaliDate = picked;
      });
    }
  }

}
