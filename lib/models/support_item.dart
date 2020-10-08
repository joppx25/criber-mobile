import 'package:intl/intl.dart';

final DateFormat formatter = new DateFormat('MMMM d y').add_jm();

class SupportItem {
  final String date;
  final String reportId;
  final String location;
  final String details;
  final int status;
  final String statusText;
  final attachments;

  SupportItem({this.date, this.reportId, this.location, this.details, this.status, this.statusText, this.attachments});

  factory SupportItem.fromJson(Map json) {
    final List<String> statusList = ["Open", "Pending", "Resolved", "Closed"]; // Status from Freshdesk API

    return new SupportItem(
      date: formatter.format(DateTime.parse(json['created_at'])),
      reportId: json['id'].toString().padLeft(10, '0'),
      location: json['subject'].toString(),
      details: json['description_text'].toString(),
      status: json['status'] as int,
      statusText: statusList[((json['status'] as int) - 2)].toString(), // Status from Freshdesk API starts at 2,
      attachments: json['attachments'],
    );
  }
}

class SupportConvo {
  final String date;
  final String bodyText;

  SupportConvo({this.date, this.bodyText});

  factory SupportConvo.fromJson(Map json) {
    return new SupportConvo(
      date: formatter.format(DateTime.parse(json['created_at'])),
      bodyText: json['body_text'].toString(),
    );
  }
}

class SupportDetailWithConvo {
  final String detail;
  final String convo;

  SupportDetailWithConvo({this.detail, this.convo});
}

class SupportItemAttachments {
  final String date;
  final String attachmentUrl;

  SupportItemAttachments({this.date, this.attachmentUrl});

  factory SupportItemAttachments.fromJson(Map json) {

    return new SupportItemAttachments(
      date: formatter.format(DateTime.parse(json['created_at'])),
      attachmentUrl: json['attachment_url'].toString(),
    );
  }
}