class OtpResponse {
  bool status;
  String message;
  OtpData data;

  OtpResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory method to create an instance of OtpResponse from JSON
  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      status: json['status'],
      message: json['message'],
      data: OtpData.fromJson(json['data']),
    );
  }

  // Method to convert an OtpResponse instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }

  @override
  String toString() {
    return 'OtpResponse{status: $status, message: $message, data: $data}';
  }
}

class OtpData {
  int otp;
  String id;
  String firstname;

  OtpData({
    required this.otp,
    required this.id,
    required this.firstname,
  });

  // Factory method to create an instance of OtpData from JSON
  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      otp: json['OTP'],
      id: json['id'],
      firstname: json['firstname'],
    );
  }

  // Method to convert an OtpData instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'OTP': otp,
      'id': id,
      'firstname': firstname,
    };
  }

  @override
  String toString() {
    return 'OtpData{otp: $otp, id: $id, firstname: $firstname}';
  }
}
