import 'package:flutter/material.dart';
import 'package:todo_mobile_app/models/models.dart';
import 'package:todo_mobile_app/ui_kit/ui_kit.dart';

class EditTaskBottomSheet extends StatefulWidget {
  const EditTaskBottomSheet({
    required this.onSubmit,
    this.onDelete,
    this.initialName,
    this.initialDescription,
    super.key,
  });

  final Function(TaskDto) onSubmit;
  final VoidCallback? onDelete;
  final String? initialName;
  final String? initialDescription;

  @override
  State<StatefulWidget> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  final _taskNameTextController = TextEditingController();
  final _taskDescriptionTextController = TextEditingController();

  bool _submitButtonDisable = true;

  @override
  void initState() {
    _taskNameTextController.text = widget.initialName ?? '';
    _taskDescriptionTextController.text = widget.initialDescription ?? '';

    _submitButtonDisable = _taskNameTextController.text.isEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        right: 16,
        left: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _taskNameTextController,
            decoration: const InputDecoration(
              hintText: 'Task name',
            ),
            onChanged: (text) => setState(
              () => _submitButtonDisable = text.isEmpty,
            ),
            autofocus: true,
          ),
          TextField(
            controller: _taskDescriptionTextController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppElevatedButton(
                    icon: const Icon(Icons.check),
                    color: Colors.green,
                    disabled: _submitButtonDisable,
                    onPressed: () {
                      widget.onSubmit(
                        TaskDto(
                          name: _taskNameTextController.text,
                          description: _taskDescriptionTextController.text,
                          isCompleted: false,
                          isDeleted: false,
                        ),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ),
                if (widget.onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      widget.onDelete!.call();
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
