import 'package:flutter/material.dart';
import 'package:lu_master/config/constant.dart';
import 'package:lu_master/util/dio_util.dart';
import 'package:lu_master/util/util.dart';

class PasswordPage extends StatefulWidget {
  PasswordPage({Key key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController _controller = new TextEditingController();
  TextEditingController _formFieldController = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  var passKey = GlobalKey<FormFieldState>();

  String _name;
  String _password;
  String _conformPass;
  var futureUtils;

  @override
  void initState() {
    _controller.value = new TextEditingValue(text: 'Hello');
    _formFieldController.addListener(() {
      print('listener');
    });
    futureUtils = Util.getSharedPreferences();
    super.initState();
  }

  void _forSubmitted() async {
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      print(_name);
      print(_password);
      print(_conformPass);
      await _updatePassword(_name, _password);
    }
  }

  String _conformPassword(String value) {
    var password = passKey.currentState.value;
    if (value.length == 0) {
      return "Password is Required";
    } else if (value != password) {
      return 'Password is not matching';
    }
    return null;
  }

  void _updatePassword(String name, String password) async {
    var params = {"open_id": name, "pwd": password};
    var response = await DioUtil.post(
        Constant.UPDATE_PASSWORD_URL, Constant.CONTENT_TYPE_FORM,
        data: params);
    if (response['status'] == '200') {
      Util.showShortLoading(response['data']);
    } else {
      Util.showShortLoading(response['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureUtils,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text(Constant.PASSWORD_PAGE_NAME),
              ),
              floatingActionButton: new FloatingActionButton(
                onPressed: () {
                  _forSubmitted();
                  Navigator.of(context).pop();
                },
                child: new Text('Submit'),
                heroTag: "password",
              ),
              body: new Container(
                padding: const EdgeInsets.all(16.0),
                child: new Form(
                  key: _formKey,
                  child: new Column(
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Your Name',
                        ),
                        onSaved: (val) {
                          this._name = val;
                        },
                      ),
                      new TextFormField(
                        key: passKey,
                        decoration: new InputDecoration(
                          labelText: 'Password',
                        ),
                        obscureText: true,
                        onSaved: (val) {
                          this._password = val;
                        },
                      ),
                      new TextFormField(
                        decoration: new InputDecoration(
                          labelText: 'Comform Password',
                        ),
                        obscureText: true,
                        validator: _conformPassword,
                        onSaved: (val) {
                          this._conformPass = val;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: Text("数据加载中……",
                    style: TextStyle(fontSize: 20, color: Colors.orange)),
              ),
            );
          }
        });
  }
}
