class FaultReport {
  final String phoneNumber;
  final String description;
  final String? photoPath;     // local file path (before upload)
  final String? photoUrl;      // Firebase Storage URL (after upload)
  final String commonName;
  final double latitude;
  final double longitude;

  const FaultReport({
    required this.phoneNumber,
    required this.description,
    this.photoPath,
    this.photoUrl,
    required this.commonName,
    required this.latitude,
    required this.longitude,
  });

  FaultReport copyWith({String? photoUrl}) {
    return FaultReport(
      phoneNumber: phoneNumber,
      description: description,
      photoPath: photoPath,
      photoUrl: photoUrl ?? this.photoUrl,
      commonName: commonName,
      latitude: latitude,
      longitude: longitude,
    );
  }

  /// Convert to a Map for Firestore
  Map<String, dynamic> toFirestore(String trackingId) {
    return {
      'trackingId': trackingId,
      'phoneNumber': phoneNumber,
      'description': description,
      'photoUrl': photoUrl,
      'location': {
        'commonName': commonName.isNotEmpty ? commonName : 'Unknown',
        'latitude': latitude,
        'longitude': longitude,
      },
      'status': 'pending',
      'submittedAt': DateTime.now().toIso8601String(),
    };
  }
}
