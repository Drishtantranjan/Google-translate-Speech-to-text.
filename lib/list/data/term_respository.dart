import 'package:flutter_assignment/list/domain/entities/term_entity.dart';

class TermRepository {
  List<TermEntity> getAllTerms() {
    return [
      TermEntity("1 year service warranty & 5 years plywood warranty"),
      TermEntity(
          "Custom requirement of colour, design, and size also available on demand"),
      TermEntity(
          "All changes (if any in Design & colour) to be informed before production starts otherwise same will be done on chargeable basis"),
      TermEntity(
          "Custom handles will be charged extra. Handle price may vary based on the design."),
      TermEntity(
          "Once the project is confirmed, the amount cannot be refunded"),
      TermEntity(
          "The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural"),
      TermEntity(
          "“Account” means a unique account created for You to access our Service or parts of our Service.")
    ];
  }
}
