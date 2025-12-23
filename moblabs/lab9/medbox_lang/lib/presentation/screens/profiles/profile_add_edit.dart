import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medbox/data/models/Result.dart';
import 'package:medbox/logic/cubits/profiles_cubit.dart';
import 'package:medbox/presentation/widgets/confirmation_dialog.dart';

import '../../widgets/progress_button.dart';

class AddEditProfileScreen extends StatefulWidget {
  Map? instanceData;
  AddEditProfileScreen({super.key, this.instanceData});

  @override
  State<AddEditProfileScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleCtrl = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.instanceData != null) {
      titleCtrl.text = widget.instanceData!['name'];
      selectedDate = DateTime.parse(widget.instanceData!['dob']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.instanceData == null
              ? "Add Family Member"
              : "Edit Family Member",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title
              TextFormField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  labelText: "Full name",
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty) ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // Date Picker
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(),
                ),
                child: InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (date != null) {
                      setState(() => selectedDate = date);
                    }
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate == null
                              ? "Select Date"
                              : selectedDate!.toString().split(" ").first,
                        ),
                        const Icon(Icons.calendar_month),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Submit Button
              Row(
                children: [
                  Expanded(
                    child: MyProgressButton(
                      label: "Save",
                      onPressed: handleSaveButton,
                    ),
                  ),
                  if (widget.instanceData != null) SizedBox(width: 10),
                  if (widget.instanceData != null)
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed:
                            () => showDialog(
                              context: context,
                              builder:
                                  (context) => MyConfirmationDialog(
                                    dialogType: DialogBoxType.delete,
                                    title: "Really  want to delete ?",
                                    message: "If you delete .",
                                    onConfirm: () async {
                                      var result = await context
                                          .read<ProfilesCubit>()
                                          .deleteItem(
                                            widget.instanceData!['id'],
                                          );
                                      if (Navigator.of(context).canPop())
                                        Navigator.of(context).pop();
                                      return result;
                                    },
                                    onClose: () {},
                                  ),
                            ),
                        child: Text('Delete'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ReturnResult> handleSaveButton() async {
    var result = ReturnResult(state: false, message: '');
    if (!_formKey.currentState!.validate()) return result;

    Map<String, dynamic> payload = {
      "name": titleCtrl.text,
      "dob": (selectedDate ?? DateTime.now()).toString().split(" ").first,
    };

    if (widget.instanceData == null) {
      result = await context.read<ProfilesCubit>().insertItem(payload);
    } else {
      Map<String, dynamic> new_payload = {
        ...widget.instanceData ?? {},
        ...payload,
      };
      result = await context.read<ProfilesCubit>().updateItem(new_payload);
    }
    if (result.state && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    return result;
  }
}
