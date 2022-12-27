import 'dart:isolate';

class AsynchronousUtility {
  static Future<Response?> onCompute<Data, Response>({
    final Data? data,
    required final Future<Response?> Function(Data?) onCompute,
  }) async {
    final receiverPort = ReceivePort();

    await Isolate.spawn<List<dynamic>>((dataList) async {
      Isolate.exit(dataList.first, await onCompute(dataList[1]));
    }, [
      receiverPort.sendPort,
      data,
    ]);

    final result = await receiverPort.first;

    receiverPort.close();

    if (result is Response) return result;

    return null;
  }

  const AsynchronousUtility._();
}
