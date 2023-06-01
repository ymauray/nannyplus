import 'package:nannyplus/data/invoices_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invoices_repository_provider.g.dart';

@riverpod
InvoicesRepository invoicesRepository(
  InvoicesRepositoryRef ref,
) {
  return const InvoicesRepository();
}
