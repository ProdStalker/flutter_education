import 'package:education/core/usecases/usecases.dart';
import 'package:education/core/utils/typedefs.dart';
import 'package:education/src/course/features/materials/domain/entities/resource.dart';
import 'package:education/src/course/features/materials/domain/repos/material_repo.dart';

class AddMaterial extends FutureUsecaseWithParams<void, Resource> {
  const AddMaterial(this._repo);

  final MaterialRepo _repo;

  @override
  ResultFuture<void> call(Resource params) => _repo.addMaterial(params);
}
