import 'package:flutter/material.dart';
import 'package:mukabbir_schools/components/back_widget.dart';
import 'package:mukabbir_schools/components/custom_button.dart';
import 'package:mukabbir_schools/model/fee_model.dart';
import 'package:mukabbir_schools/utils/app_strings.dart';
import 'package:mukabbir_schools/utils/color_constants.dart';
import 'package:mukabbir_schools/utils/styles.dart';
import 'package:mukabbir_schools/utils/utils.dart';

class FeeScreen extends StatefulWidget {
  @override
  _FeeScreenState createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  List<FeeModel> _feeList = [];

  @override
  void initState() {
    _getFeeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            //BgImageContainer(image: AppConstants.defaultBg),

            Positioned(
              top: -10,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/top_circle.png',
                  width: MediaQuery.of(context).size.width * 0.8, height: 70),
            ),

            Positioned(
              top: 16,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/mukabbir_logo.png', width: 90, height: 90),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/pencils.jpg',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(
                16.0,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //back
                    BackWidget(),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),

                    Expanded(
                      child: ListView(
                        primary: true,
                        shrinkWrap: true,
                        children: [
                          Center(child: Text(AppStrings.feeStructure, style: headingTextStyle)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          if (_feeList.length != 0)
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: _feeList.length,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: ColorConstants.blackColor),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(_feeList[index].schoolName, style: normalBoldTextStyle),
                                      Divider(
                                        color: ColorConstants.blackColor,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(_feeList[index].campus, style: normalBoldTextStyle),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(_feeList[index].accountNo, style: normalTextStyle),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(_feeList[index].bankName, style: normalTextStyle),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text('Issue Date: ', style: normalBoldTextStyle),
                                          ),
                                          SizedBox(width: 16.0),
                                          Expanded(
                                            flex: 2,
                                            child: Text(_feeList[index].issueDate, style: normalTextStyle),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text('Due Date: ', style: normalBoldTextStyle),
                                          ),
                                          SizedBox(width: 16.0),
                                          Expanded(
                                            flex: 2,
                                            child: Text(_feeList[index].dueDate, style: normalTextStyle),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text('Name: ', style: normalBoldTextStyle),
                                          ),
                                          SizedBox(width: 16.0),
                                          Expanded(
                                            flex: 2,
                                            child: Text(_feeList[index].studentName, style: normalTextStyle),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text('Class: ', style: normalBoldTextStyle),
                                          ),
                                          SizedBox(width: 16.0),
                                          Expanded(
                                            flex: 2,
                                            child: Text(_feeList[index].className, style: normalTextStyle),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.blackColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text('Invoice',
                                                  style: TextStyle(
                                                      color: ColorConstants.whiteColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Expanded(
                                              child: Text('Description',
                                                  style: TextStyle(
                                                      color: ColorConstants.whiteColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                            Expanded(
                                              child: Text('Amount',
                                                  style: TextStyle(
                                                      color: ColorConstants.whiteColor,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: _feeList[index].invoicesList.length,
                                        shrinkWrap: true,
                                        primary: false,
                                        itemBuilder: (BuildContext context, int invoiceIndex) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    _feeList[index].invoicesList[invoiceIndex].invoiceId,
                                                    style: TextStyle(
                                                      color: ColorConstants.blackColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(_feeList[index].invoicesList[invoiceIndex].description,
                                                      style: TextStyle(
                                                        color: ColorConstants.blackColor,
                                                        fontSize: 14,
                                                      )),
                                                ),
                                                Expanded(
                                                  child: Text(_feeList[index].invoicesList[invoiceIndex].amount,
                                                      style: TextStyle(
                                                        color: ColorConstants.blackColor,
                                                        fontSize: 14,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          else
                            Utils.noDataWidget(context, AppStrings.noDataUploaded),
                          SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          text: AppStrings.downloadPDFButtonText.toUpperCase(),
          callback: () {},
        ),
      ),
    );
  }

  _getFeeData() {
    List<InvoiceData> invoicesList = [];

    invoicesList.add(InvoiceData(invoiceId: '1', description: 'Monthly Fee', amount: '200 PKR'));
    invoicesList.add(InvoiceData(invoiceId: '2', description: 'Monthly Fee', amount: '300 PKR'));
    invoicesList.add(InvoiceData(invoiceId: '3', description: 'Monthly Fee', amount: '400 PKR'));

    _feeList.add(FeeModel(
        schoolName: 'Mukabbir School',
        campus: 'Sahiwal Campus',
        accountNo: '2343453453',
        bankName: 'Al Habib Bank',
        issueDate: '2021-06-24',
        dueDate: '2021-07-10',
        studentName: 'ABC s/o XYZ',
        className: 'Play Group',
        invoicesList: invoicesList));
  }
}
