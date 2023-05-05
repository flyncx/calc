import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

class MatematikFFI {
  static bool initialize() {
    nativeApiLib = Platform.isMacOS || Platform.isIOS
        ? DynamicLibrary.process() // macos and ios
        : (DynamicLibrary.open(Platform.isWindows // windows
            ? 'matematik.dll'
            : 'libmatematik.so')); // android and linux
    final fnevaluateString =
        nativeApiLib.lookup<NativeFunction<Double Function(Pointer<Utf8>)>>(
            'evaluateString');
    evaluateString =
        fnevaluateString.asFunction<double Function(Pointer<Utf8>)>();

    ///final _cap = nativeApiLib.lookup<
    ///    NativeFunction<Pointer<Utf8> Function(Pointer<Utf8>)>>('capitalize');
    ///_capitalize = _cap.asFunction<Pointer<Utf8> Function(Pointer<Utf8>)>();
    return true;
  }

  static late DynamicLibrary nativeApiLib;
  static late Function(Pointer<Utf8>) evaluateString;

  ///static late Function _capitalize;
  ///static String capitalize(String str) {
  ///  final _str = str.toNativeUtf8();
  ///  Pointer<Utf8> res = _capitalize(_str);
  ///  calloc.free(_str);
  ///  return res.toDartString();
  ///}
}
