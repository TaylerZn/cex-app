// import 'dart:math' as math;
// import 'package:extended_text_library/extended_text_library.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';

// ///
// ///  create by zmtzawqlp on 2019/8/3
// ///

// const double _kHandleSize = 22.0;

// // Padding between the toolbar and the anchor.
// const double _kToolbarContentDistanceBelow = _kHandleSize - 2.0;
// const double _kToolbarContentDistance = 8.0;

// // The label and callback for the available default text selection menu buttons.
// class _TextSelectionToolbarItemData {
//   const _TextSelectionToolbarItemData({
//     required this.label,
//     required this.onPressed,
//   });

//   final String label;
//   final VoidCallback? onPressed;
// }

// // The highest level toolbar widget, built directly by buildToolbar.
// class _TextSelectionControlsToolbar extends StatefulWidget {
//   const _TextSelectionControlsToolbar({
//     required this.clipboardStatus,
//     required this.delegate,
//     required this.endpoints,
//     required this.globalEditableRegion,
//     required this.handleCut,
//     required this.handleCopy,
//     required this.handlePaste,
//     required this.handleSelectAll,
//     required this.selectionMidpoint,
//     required this.textLineHeight,
//     required this.handleLike,
//   });

//   final ClipboardStatusNotifier? clipboardStatus;
//   final TextSelectionDelegate delegate;
//   final List<TextSelectionPoint> endpoints;
//   final Rect globalEditableRegion;
//   final VoidCallback? handleCut;
//   final VoidCallback? handleCopy;
//   final VoidCallback? handlePaste;
//   final VoidCallback? handleSelectAll;
//   final VoidCallback? handleLike;
//   final Offset selectionMidpoint;
//   final double textLineHeight;

//   @override
//   _TextSelectionControlsToolbarState createState() =>
//       _TextSelectionControlsToolbarState();
// }

// class _TextSelectionControlsToolbarState
//     extends State<_TextSelectionControlsToolbar> with TickerProviderStateMixin {
//   void _onChangedClipboardStatus() {
//     setState(() {
//       // Inform the widget that the value of clipboardStatus has changed.
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
//   }

//   @override
//   void didUpdateWidget(_TextSelectionControlsToolbar oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.clipboardStatus != oldWidget.clipboardStatus) {
//       widget.clipboardStatus?.addListener(_onChangedClipboardStatus);
//       oldWidget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     widget.clipboardStatus?.removeListener(_onChangedClipboardStatus);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // If there are no buttons to be shown, don't render anything.
//     if (widget.handleCut == null &&
//         widget.handleCopy == null &&
//         widget.handlePaste == null &&
//         widget.handleSelectAll == null) {
//       return const SizedBox.shrink();
//     }
//     // If the paste button is desired, don't render anything until the state of
//     // the clipboard is known, since it's used to determine if paste is shown.
//     if (widget.handlePaste != null &&
//         widget.clipboardStatus?.value == ClipboardStatus.unknown) {
//       return const SizedBox.shrink();
//     }

//     // Calculate the positioning of the menu. It is placed above the selection
//     // if there is enough room, or otherwise below.
//     final TextSelectionPoint startTextSelectionPoint = widget.endpoints[0];
//     final TextSelectionPoint endTextSelectionPoint =
//         widget.endpoints.length > 1 ? widget.endpoints[1] : widget.endpoints[0];
//     final Offset anchorAbove = Offset(
//       widget.globalEditableRegion.left + widget.selectionMidpoint.dx,
//       widget.globalEditableRegion.top +
//           startTextSelectionPoint.point.dy -
//           widget.textLineHeight -
//           _kToolbarContentDistance,
//     );
//     final Offset anchorBelow = Offset(
//       widget.globalEditableRegion.left + widget.selectionMidpoint.dx,
//       widget.globalEditableRegion.top +
//           endTextSelectionPoint.point.dy +
//           _kToolbarContentDistanceBelow,
//     );

//     // Determine which buttons will appear so that the order and total number is
//     // known. A button's position in the menu can slightly affect its
//     // appearance.
//     assert(debugCheckHasMaterialLocalizations(context));
//     final MaterialLocalizations localizations =
//         MaterialLocalizations.of(context);
//     final List<_TextSelectionToolbarItemData> itemDatas =
//         <_TextSelectionToolbarItemData>[
//       if (widget.handleCut != null)
//         _TextSelectionToolbarItemData(
//           label: localizations.cutButtonLabel,
//           onPressed: widget.handleCut!,
//         ),
//       if (widget.handleCopy != null)
//         _TextSelectionToolbarItemData(
//           label: localizations.copyButtonLabel,
//           onPressed: widget.handleCopy!,
//         ),
//       if (widget.handlePaste != null &&
//           widget.clipboardStatus?.value == ClipboardStatus.pasteable)
//         _TextSelectionToolbarItemData(
//           label: localizations.pasteButtonLabel,
//           onPressed: widget.handlePaste!,
//         ),
//       if (widget.handleSelectAll != null)
//         _TextSelectionToolbarItemData(
//           label: localizations.selectAllButtonLabel,
//           onPressed: widget.handleSelectAll!,
//         ),
//       _TextSelectionToolbarItemData(
//         label: 'like',
//         onPressed: widget.handleLike,
//       ),
//     ];

//     // If there is no option available, build an empty widget.
//     if (itemDatas.isEmpty) {
//       return const SizedBox(width: 0.0, height: 0.0);
//     }

//     return TextSelectionToolbar(
//       anchorAbove: anchorAbove,
//       anchorBelow: anchorBelow,
//       children: itemDatas
//           .asMap()
//           .entries
//           .map((MapEntry<int, _TextSelectionToolbarItemData> entry) {
//         return TextSelectionToolbarTextButton(
//           padding: TextSelectionToolbarTextButton.getPadding(
//               entry.key, itemDatas.length),
//           onPressed: entry.value.onPressed,
//           child: Text(entry.value.label),
//         );
//       }).toList(),
//     );
//   }
// }
