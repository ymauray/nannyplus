import 'package:nannyplus/data/services_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'services_repository_provider.g.dart';

@riverpod
ServicesRepository servicesRepository(
  ServicesRepositoryRef ref,
) {
  return const ServicesRepository();
}
