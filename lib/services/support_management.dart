import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:criber/models/support_item.dart';
import 'package:criber/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class SupportManagement {
  SupportManagement();

  final Dio dio = new Dio();
  final Auth auth = new Auth();
  final String freshDeskApiKey = "14tryLMbVBiM8bcHAjee";
  final String freshDeskDomain = "criber.freshdesk.com";
  final String freshDeskPassword = "UncleJamesSuria";

  Future<String> fetchTickets() async {
    FirebaseUser firebaseUser = await auth.getCurrentUser();
    String email = firebaseUser.email;
    String url = "https://$freshDeskDomain/api/v2/tickets?email=$email";
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$freshDeskApiKey:$freshDeskPassword'));
    final response = await http.get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "authorization": basicAuth});

    return response.body;
  }

  Future<String> fetchTicketDetails(ticketId) async {
    String url = "https://$freshDeskDomain/api/v2/tickets/$ticketId";
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$freshDeskApiKey:$freshDeskPassword'));
    final response = await http.get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "authorization": basicAuth});

    return response.body;
  }

  Future<String> fetchTicketConversations(ticketId) async {
    String url = "https://$freshDeskDomain/api/v2/tickets/$ticketId/conversations";
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$freshDeskApiKey:$freshDeskPassword'));
    final response = await http.get(Uri.encodeFull(url), headers: {"Content-Type": "application/json", "authorization": basicAuth});

    return response.body;
  }

  Future<String> addTicket(body, images) async {
    String url = Uri.parse("https://$freshDeskDomain/api/v2/tickets").toString();
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$freshDeskApiKey:$freshDeskPassword'));
    FormData formData = new FormData.from(body);

    if (images != null) {
      List<UploadFileInfo> files = new List();

      for (File file in images) {
        String fileName = basename(file.path) + "_" + new DateTime.now().millisecondsSinceEpoch.toString();
        UploadFileInfo fileInfo = new UploadFileInfo(file, fileName);
        files.add(fileInfo);
      }

      formData.add('attachments[]', files);
    }

    Response response = await dio.post(url, data: formData, options: Options(headers: {"Content-Type": "multipart/form-data", "authorization": basicAuth}));

    return response.toString();
  }

  List formatSupportItemJsonData(data) {
    return (data as List)
        .map<SupportItem>(
            (data) => new SupportItem.fromJson(data))
        .toList();
  }

  List formatSupportConvoJsonData(data) {
    return (data as List)
        .map<SupportConvo>(
            (data) => new SupportConvo.fromJson(data))
        .toList();
  }

  List formatSupportItemAttachmentsJsonData(data) {
    return (data as List)
        .map<SupportItemAttachments>(
            (data) => new SupportItemAttachments.fromJson(data))
        .toList();
  }
}