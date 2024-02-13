import 'package:flutter_assignment/list/domain/entities/term_entity.dart';

class AddTermUseCase {
  TermEntity execute(List<TermEntity> terms, String newTerm) {
    final term = TermEntity(newTerm);
    terms.add(term);
    return term;
  }
}
