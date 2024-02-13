import 'package:flutter_assignment/list/data/term_respository.dart';
import 'package:flutter_assignment/list/domain/entities/term_entity.dart';

class GetAllTermsUseCase {
  final TermRepository repository;

  GetAllTermsUseCase({required this.repository});

  Future<List<TermEntity>> execute() async {
    return repository.getAllTerms();
  }
}
