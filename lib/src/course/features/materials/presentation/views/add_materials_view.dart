import 'package:education/core/commons/widgets/course_picker.dart';
import 'package:education/core/commons/widgets/info_field.dart';
import 'package:education/core/extensions/context_extension.dart';
import 'package:education/core/res/colours.dart';
import 'package:education/src/course/domain/entities/course.dart';
import 'package:education/src/course/features/materials/domain/entities/picked_resource.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AddMaterialsView extends StatefulWidget {
  const AddMaterialsView({super.key});

  static const routeName = '/add-material';

  @override
  State<AddMaterialsView> createState() => _AddMaterialsViewState();
}

class _AddMaterialsViewState extends State<AddMaterialsView> {
  List<PickedResource> resources = <PickedResource>[];
  final formKey = GlobalKey<FormState>();
  final courseController = TextEditingController();
  final courseNotifier = ValueNotifier<Course?>(null);
  final authorController = TextEditingController();

  bool authorSet = false;

  Future<void> pickResources() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        resources.addAll(
          result.paths.map(
            (path) => PickedResource(
              path: path!,
              author: authorController.text.trim(),
              title: path.split('/').last,
            ),
          ),
        );
      });
    }
  }

  Future<void> editResource(int resourceIndex) async {
    final resource = resources[resourceIndex];
    final newResource = await showDialog<PickedResource>(
      context: context,
      builder: (_) => EditResourceDialog(resource),
    );

    if (newResource != null) {
      setState(() {
        resources[resourceIndex] = newResource;
      });
    }
  }

  void setAuthor() {
    if (authorSet) {
      return;
    }

    final text = authorController.text.trim();
    FocusManager.instance.primaryFocus?.unfocus();

    final newResources = <PickedResource>[];
    for (final resource in resources) {
      if (resource.authorManuallySet) {
        newResources.add(resource);
        continue;
      }

      newResources.add(resource.copyWith(author: text));

      setState(() {
        resources = newResources;
        authorSet = true;
      });
    }
  }

  @override
  void dispose() {
    courseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add Materials',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: CoursePicker(
                    controller: courseController,
                    notifier: courseNotifier,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InfoField(
                  controller: authorController,
                  border: true,
                  hintText: 'General Author',
                  onChanged: (_) {
                    if (authorSet) {
                      setState(() {
                        authorSet = false;
                      });
                    }
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      authorSet
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: authorSet ? Colors.green : Colors.grey,
                    ),
                    onPressed: setAuthor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'You can upload multiple materials at once.',
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    color: Colours.neutralTextColour,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: pickMaterial,
                      child: const Text('Add Material'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
