// ignore_for_file: must_be_immutable, file_names, use_build_context_synchronously, avoid_print, non_constant_identifier_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../bloc/BlocEvent/07-01-P07CHANGEPASSWORDGETDATA.dart';
import '../../data/global.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/SuccessPopup.dart';

late BuildContext P07CHANGEPASSWORDMAINcontext;

class P07CHANGEPASSWORDMAIN extends StatefulWidget {
  P07CHANGEPASSWORDMAIN({
    super.key,
    this.data,
  });
  List<P07CHANGEPASSWORDGETDATAclass>? data;

  @override
  State<P07CHANGEPASSWORDMAIN> createState() => _P07CHANGEPASSWORDMAINState();
}

class _P07CHANGEPASSWORDMAINState extends State<P07CHANGEPASSWORDMAIN> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    PageName = 'CHANGE PASSWORD';
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<bool> _checkOldPassword(String oldPassword) async {
    try {
      final response = await Dio().post(
        "$ToServer/02EXPORTALERT/CheckOldPassword",
        data: {
          'UserName': USERDATA.ID,
          'OldPassword': oldPassword,
        },
        options: Options(
          validateStatus: (status) {
            return true;
          },
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Navigator.pop(P07CHANGEPASSWORDMAINcontext);
      if (e.type == DioExceptionType.sendTimeout) {
        showErrorPopup(P07CHANGEPASSWORDMAINcontext, "Send timeout");
        return false;
      } else if (e.type == DioExceptionType.receiveTimeout) {
        showErrorPopup(P07CHANGEPASSWORDMAINcontext, "Receive timeout");
        return false;
      } else {
        showErrorPopup(P07CHANGEPASSWORDMAINcontext, e.message ?? "Unknown Dio error");
        return false;
      }
    } catch (e) {
      print("Error: $e");
      showErrorPopup(P07CHANGEPASSWORDMAINcontext, e.toString());
      return false;
    }
  }

  Future<bool> _updatePassword(String newPassword) async {
    try {
      final response = await Dio().post(
        "$ToServer/02EXPORTALERT/UpdatePassword",
        data: {
          'UserName': USERDATA.ID,
          'NewPassword': newPassword,
        },
        options: Options(
          validateStatus: (status) {
            return true;
          },
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      showErrorPopup(P07CHANGEPASSWORDMAINcontext, e.toString());
      return false;
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 10),
              Text(
                'ยืนยันการเปลี่ยนรหัสผ่าน',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'คุณแน่ใจหรือไม่ที่จะเปลี่ยนรหัสผ่าน?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ยกเลิก',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleChangePassword();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('ยืนยัน'),
            ),
          ],
        );
      },
    );
  }

  void _handleChangePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      bool isOldPasswordValid = await _checkOldPassword(_oldPasswordController.text);

      if (!isOldPasswordValid) {
        showErrorPopup(P07CHANGEPASSWORDMAINcontext, 'รหัสผ่านเดิมไม่ถูกต้อง');
        setState(() {
          _isLoading = false;
        });
        return;
      }

      bool isUpdateSuccess = await _updatePassword(_newPasswordController.text);

      if (isUpdateSuccess) {
        showSuccessPopup(P07CHANGEPASSWORDMAINcontext, 'เปลี่ยนรหัสผ่านสำเร็จแล้ว');
        _oldPasswordController.clear();
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } else {
        showErrorPopup(P07CHANGEPASSWORDMAINcontext, 'เกิดข้อผิดพลาดในการเปลี่ยนรหัสผ่าน');
      }
    } catch (e) {
      showErrorPopup(P07CHANGEPASSWORDMAINcontext, 'เกิดข้อผิดพลาดในการเชื่อมต่อ');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    P07CHANGEPASSWORDMAINcontext = context;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: SizedBox(
              height: 675,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.security,
                            size: 50,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'ความปลอดภัย',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'เปลี่ยนรหัสผ่านของคุณเพื่อความปลอดภัย',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _oldPasswordController,
                            obscureText: !_isOldPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'รหัสผ่านเดิม',
                              prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isOldPasswordVisible = !_isOldPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.blue, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาใส่รหัสผ่านเดิม';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: !_isNewPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'รหัสผ่านใหม่',
                              prefixIcon: const Icon(Icons.lock, color: Colors.green),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isNewPasswordVisible = !_isNewPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.green, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณาใส่รหัสผ่านใหม่';
                              }
                              if (value.length < 6) {
                                return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_isConfirmPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'ยืนยันรหัสผ่านใหม่',
                              prefixIcon: const Icon(Icons.lock_reset, color: Colors.orange),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.orange, width: 2),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'กรุณายืนยันรหัสผ่านใหม่';
                              }
                              if (value != _newPasswordController.text) {
                                return 'รหัสผ่านไม่ตรงกัน';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _showConfirmationDialog,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                              ),
                              child: _isLoading
                                  ? const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text('กำลังดำเนินการ...', style: TextStyle(fontSize: 16)),
                                      ],
                                    )
                                  : const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.save, size: 20),
                                        SizedBox(width: 8),
                                        Text(
                                          'เปลี่ยนรหัสผ่าน',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.tips_and_updates, color: Colors.amber),
                              const SizedBox(width: 8),
                              Text(
                                'เคล็ดลับความปลอดภัย',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[800],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '• ใช้รหัสผ่านที่มีความยาวอย่างน้อย 6 ตัวอักษร\n'
                            '• ผสมตัวอักษรพิมพ์ใหญ่ พิมพ์เล็ก ตัวเลข\n'
                            '• หลีกเลี่ยงการใช้ข้อมูลส่วนตัว เช่น ชื่อ วันเกิด\n'
                            '• เปลี่ยนรหัสผ่านเป็นระยะๆ เพื่อความปลอดภัย',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
