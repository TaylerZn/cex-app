//import 'dart:typed_data';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';

// import 'package:isolate/load_balancer.dart';
// import 'package:isolate/isolate_runner.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
// ignore: implementation_imports
import 'package:image/image.dart';
import 'package:image_editor/image_editor.dart';

Future<Uint8List?> cropImageDataWithNativeLibrary(
    {required ExtendedImageEditorState state}) async {
  print('native library start cropping');
  Rect cropRect = state.getCropRect()!;
  if (state.widget.extendedImageState.imageProvider is ExtendedResizeImage) {
    final ImmutableBuffer buffer =
        await ImmutableBuffer.fromUint8List(state.rawImageData);
    final ImageDescriptor descriptor = await ImageDescriptor.encoded(buffer);

    final double widthRatio = descriptor.width / state.image!.width;
    final double heightRatio = descriptor.height / state.image!.height;
    cropRect = Rect.fromLTRB(
      cropRect.left * widthRatio,
      cropRect.top * heightRatio,
      cropRect.right * widthRatio,
      cropRect.bottom * heightRatio,
    );
  }

  final EditActionDetails action = state.editAction!;

  final int rotateAngle = action.rotateAngle.toInt();
  final bool flipHorizontal = action.flipY;
  final bool flipVertical = action.flipX;
  final Uint8List img = state.rawImageData;

  final ImageEditorOption option = ImageEditorOption();

  if (action.needCrop) {
    option.addOption(ClipOption.fromRect(cropRect));
  }

  if (action.needFlip) {
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
  }

  if (action.hasRotateAngle) {
    option.addOption(RotateOption(rotateAngle));
  }

  final DateTime start = DateTime.now();
  final Uint8List? result = await ImageEditor.editImage(
    image: img,
    imageEditorOption: option,
  );

  print('${DateTime.now().difference(start)} ：total time');
  return result;
}

Future<dynamic> isolateDecodeImage(List<int> data) async {
  final ReceivePort response = ReceivePort();
  await Isolate.spawn(_isolateDecodeImage, response.sendPort);
  final dynamic sendPort = await response.first;
  final ReceivePort answer = ReceivePort();
  // ignore: always_specify_types
  sendPort.send([answer.sendPort, data]);
  return answer.first;
}

Future<dynamic> isolateEncodeImage(Image src) async {
  final ReceivePort response = ReceivePort();
  await Isolate.spawn(_isolateEncodeImage, response.sendPort);
  final dynamic sendPort = await response.first;
  final ReceivePort answer = ReceivePort();
  // ignore: always_specify_types
  sendPort.send([answer.sendPort, src]);
  return answer.first;
}

void _isolateDecodeImage(SendPort port) {
  final ReceivePort rPort = ReceivePort();
  port.send(rPort.sendPort);
  rPort.listen((dynamic message) {
    final SendPort send = message[0] as SendPort;
    final List<int> data = message[1] as List<int>;
    send.send(decodeImage(Uint8List.fromList(data)));
  });
}

void _isolateEncodeImage(SendPort port) {
  final ReceivePort rPort = ReceivePort();
  port.send(rPort.sendPort);
  rPort.listen((dynamic message) {
    final SendPort send = message[0] as SendPort;
    final Image src = message[1] as Image;
    send.send(encodeJpg(src));
  });
}

/// it may be failed, due to Cross-domain
Future<Uint8List> _loadNetwork(ExtendedNetworkImageProvider key) async {
  try {
    var response = await HttpClientHelper.get(Uri.parse(key.url),
        headers: key.headers,
        timeLimit: key.timeLimit,
        timeRetry: key.timeRetry,
        retries: key.retries,
        cancelToken: key.cancelToken);
    return response!.bodyBytes;
  } on OperationCanceledError catch (_) {
    print('User cancel request ${key.url}.');
    return Future<Uint8List>.error(
        StateError('User cancel request ${key.url}.'));
  } catch (e) {
    return Future<Uint8List>.error(StateError('failed load ${key.url}. \n $e'));
  }
}
