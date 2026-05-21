// import 'package:flutter/material.dart';

// import '../../../core/theme/app_colors.dart';
// import '../../../core/utils/l10n_extension.dart';
// import 'chatbot_chat_screen.dart';

// class DocumentReadySummaryScreen extends StatelessWidget {
//   const DocumentReadySummaryScreen({
//     super.key,
//     required this.sessionId,
//     required this.displayName,
//     required this.summary,
//   });

//   final String sessionId;
//   final String displayName;
//   final String summary;

//   static Future<void> open(
//     BuildContext context, {
//     required String sessionId,
//     required String displayName,
//     required String summary,
//   }) {
//     return Navigator.of(context).push(
//       MaterialPageRoute<void>(
//         builder: (_) => DocumentReadySummaryScreen(
//           sessionId: sessionId,
//           displayName: displayName,
//           summary: summary,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;

//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBackground, 
//       appBar: AppBar(
//         backgroundColor: AppColors.scaffoldBackground,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         titleSpacing: 0,
//         title: Text(
//           displayName,
//           style: const TextStyle(
//             fontSize: 18, // Decreased from 20
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimary,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Slightly reduced vertical padding
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // 1. Success Message Box (Light Green Banner)
//               Container(
//                 padding: const EdgeInsets.all(12), // Reduced padding from 16
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF4FBF7), 
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: const Color(0xEFE2F3EB)),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Icon(
//                       Icons.check_circle_rounded,
//                       color: Color(0xFF2ECC71), 
//                       size: 24, // Decreased from 30
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             l10n.chatbotDocumentReadyTitle, 
//                             style: const TextStyle(
//                               fontSize: 15, // Decreased from 18
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFF27AE60),
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             l10n.chatbotDocumentReadySubtitle, 
//                             style: const TextStyle(
//                               fontSize: 13, // Decreased from 14
//                               fontWeight: FontWeight.w500,
//                               color: Color(0xFF27AE60),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 16), // Decreased from 20

//               // 2. Document Summary Card
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(16), // Reduced from 20
//                   decoration: BoxDecoration(
//                     color: AppColors.white,
//                     borderRadius: BorderRadius.circular(12), // Slightly tighter corners
//                     border: Border.all(color: Colors.grey.shade100),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.02),
//                         blurRadius: 8,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         l10n.chatbotCurrentSummary, 
//                         style: const TextStyle(
//                           fontSize: 16, // Decreased from 20 (Much cleaner/smaller)
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       const SizedBox(height: 12), // Decreased from 16
//                       Expanded(
//                         child: Scrollbar( // Added a scrollbar so users know it's scrollable
//                           thumbVisibility: true,
//                           child: SingleChildScrollView(
//                             physics: const BouncingScrollPhysics(),
//                             padding: const EdgeInsets.only(right: 8), // Padding for scrollbar
//                             child: Text(
//                               summary,
//                               style: TextStyle(
//                                 fontSize: 13.5, // Decreased from 15 (Perfect readable small text)
//                                 height: 1.5, // Adjusted line height for smaller font
//                                 color: AppColors.textPrimary.withOpacity(0.85),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16), // Decreased from 24

//               // 3. Start Chatting Button
//               SizedBox(
//                 height: 50, // Decreased from 54 for a sleeker look
//                 child: ElevatedButton(
//                   onPressed: () {
//                     ChatbotChatScreen.open(
//                       context,
//                       sessionId: sessionId,
//                       displayName: displayName,
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.chatbotAccent, 
//                     foregroundColor: AppColors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: Text(
//                     l10n.chatbotStartChatting,
//                     style: const TextStyle(
//                       fontSize: 15, // Decreased from 16
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }