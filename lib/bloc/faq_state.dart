part of 'faq_bloc.dart';

class ExpansionItem {
  ExpansionItem({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

class FaqState extends Equatable {
  final List<ExpansionItem> items;

  FaqState(this.items);

  @override
  List<Object> get props => [items];
}
