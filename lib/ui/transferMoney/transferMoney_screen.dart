import 'package:bank_todo/generated/l10n.dart';
import 'package:bank_todo/styles/colors.dart';
import 'package:bank_todo/ui/generateQr/generateQr.dart';
import 'package:bank_todo/utils/utils.dart';
import 'package:bank_todo/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../generated/l10n.dart';

class transferMoneyScreen extends StatefulWidget {
  @override
  _transferMoneyScreenState createState() => _transferMoneyScreenState();
}

class _transferMoneyScreenState extends State<transferMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  String _id;
  bool initial = true;
  bool _type;

  bool _typeProfile;
  int _size;
  String _comment;
  String _stringType;
  String _stringTypeProfile;
  TextEditingController _controllerCount = TextEditingController();
  TextEditingController _controllerComment = TextEditingController();
  Utils utils = Utils();

  refresh() {}

  @override
  Widget build(BuildContext context) {
    if (initial) {
      _stringType = AppLocalizations.of(context).americandollar;
      _stringTypeProfile = AppLocalizations.of(context).stream;
      initial = false;
    }
    return Scaffold(
      appBar: WidgetProyect()
          .widgetAppbar(context, AppLocalizations.of(context).generateQr),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: new DropdownButton<String>(
                      isExpanded: true,
                      value: _stringType,
                      items: <String>[
                        AppLocalizations.of(context).americandollar,
                        AppLocalizations.of(context).colombianpeso
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (data) {
                        setState(() {
                          _stringType = data;
                        });
                        if (data ==
                            AppLocalizations.of(context).americandollar) {
                          _type = true;
                        } else {
                          _type = false;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: TextFormField(
                          controller: _controllerComment,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).comment,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context).requiredfield;
                            } else {
                              return null;
                            }
                          },
                        )),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                            child: TextFormField(
                          controller: _controllerCount,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context).price,
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return AppLocalizations.of(context).requiredfield;
                            } else {
                              return null;
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    width: double.infinity,
                    child: new DropdownButton<String>(
                      value: _stringTypeProfile,
                      items: <String>[
                        AppLocalizations.of(context).stream,
                        AppLocalizations.of(context).ahorro
                      ].map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (data) {
                        setState(() {
                          _stringTypeProfile = data;
                        });
                        if (data == AppLocalizations.of(context).stream) {
                          _typeProfile = true;
                        } else {
                          _typeProfile = false;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _submitButtom(context)
                ],
              ),
            )),
      ),
    );
  }

  Widget _submitButtom(BuildContext context) {
    return RaisedButton(
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 85.0, vertical: 25.0),
          child: Text(AppLocalizations.of(context).generateQr,
              style: TextStyle(color: AppColors.fontColor, fontSize: 15.0)),
        ),
        color: AppColors.mainColor,
        onPressed: () {
          if (_type == null) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context).selectaccounttype);
          }
          if (_typeProfile == null) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context).currentAccount);
          }
          if (_formKey.currentState.validate() == true &&
              _type != null &&
              _typeProfile != null) {
            int count = int.parse(_controllerCount.text.toString());
            String comment = _controllerComment.text.toString();
            final FirebaseAuth auth = FirebaseAuth.instance;

            final User user = auth.currentUser;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => generateQrScreen(
                        id: user.uid,
                        size: count,
                        type: _type,
                        typeProfile: _typeProfile,
                        comment: comment,
                      )),
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    _type = true;
    _typeProfile = true;
  }
}
