class FaultReport {
  final String phoneNumber;
  final String description;
  final String? photoPath;
  final String? photoUrl;
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
}
