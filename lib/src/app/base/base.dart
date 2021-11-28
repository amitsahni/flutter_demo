import 'package:f_d/src/data/model/data_result.dart';
import 'package:flutter/widgets.dart';

class ResultStreamBuilder<T> extends StreamBuilder<DataResult<T>>{

  const ResultStreamBuilder({
    Key? key,
    this.initialData,
    Stream<DataResult<T>>? stream,
    required this.loadingBuilder,
    required this.successBuilder,
    required this.errorBuilder,
  }) : assert(successBuilder != null),
        super(key: key, stream: stream, builder: successBuilder);

  final AsyncWidgetBuilder<DataResult<T>> successBuilder;
  final AsyncWidgetBuilder<DataResult<T>> loadingBuilder;
  final AsyncWidgetBuilder<DataResult<T>> errorBuilder;

  final DataResult<T>? initialData;

  @override
  Widget build(BuildContext context, AsyncSnapshot<DataResult<T>> currentSummary) {
    if (currentSummary.hasData) {
      if(currentSummary.data!.isSuccess){
        return successBuilder(context, currentSummary);
      }else{
        return errorBuilder(context, currentSummary);
      }
    } else {
      return loadingBuilder(context, currentSummary);
    }
  }

}