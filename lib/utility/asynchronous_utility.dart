import 'dart:isolate';

class AsynchronousUtility {
  static Future<Response?> onCompute<Data, Response>({
    final Data? data,
    required final Future<Response?> Function(Data?) onCompute,
  }) async {
    final receiverPort = ReceivePort();

    await Isolate.spawn<_AsynchronousModel<Data, Response>>((model) async {
      Isolate.exit(model.sendPort, await onCompute(model.data));
    }, _AsynchronousModel(
      data: data,
      sendPort: receiverPort.sendPort,
    ));

    final result = await receiverPort.first;

    receiverPort.close();

    if (result is Response) return result;

    return null;
  }

  const AsynchronousUtility._();
}

class _AsynchronousModel<Data, Response> {
  final Data? data;
  final Response? response;
  final SendPort sendPort;

  const _AsynchronousModel({
    required this.sendPort,
    required this.data,
    this.response,
  });
}
