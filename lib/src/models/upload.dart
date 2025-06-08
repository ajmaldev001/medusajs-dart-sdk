import 'package:json_annotation/json_annotation.dart';

part 'upload.g.dart';

/// Upload types
enum UploadType {
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('document')
  document,
  @JsonValue('other')
  other,
}

/// Upload status
enum UploadStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
}

/// File dimensions
@JsonSerializable()
class FileDimensions {
  final int width;
  final int height;

  const FileDimensions({required this.width, required this.height});

  factory FileDimensions.fromJson(Map<String, dynamic> json) =>
      _$FileDimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$FileDimensionsToJson(this);

  /// Get aspect ratio
  double get aspectRatio => width / height;

  /// Check if image is landscape
  bool get isLandscape => width > height;

  /// Check if image is portrait
  bool get isPortrait => height > width;

  /// Check if image is square
  bool get isSquare => width == height;
}

/// Upload model for Medusa v2
@JsonSerializable()
class Upload {
  final String id;
  final String url;
  final String filename;
  final String? originalName;
  final String mimeType;
  final int size;
  final UploadType type;
  final UploadStatus status;
  final FileDimensions? dimensions;
  final String? alt;
  final String? description;
  final Map<String, dynamic>? metadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  const Upload({
    required this.id,
    required this.url,
    required this.filename,
    this.originalName,
    required this.mimeType,
    required this.size,
    required this.type,
    required this.status,
    this.dimensions,
    this.alt,
    this.description,
    this.metadata,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory Upload.fromJson(Map<String, dynamic> json) => _$UploadFromJson(json);

  Map<String, dynamic> toJson() => _$UploadToJson(this);

  /// Check if upload is an image
  bool get isImage => type == UploadType.image;

  /// Check if upload is a video
  bool get isVideo => type == UploadType.video;

  /// Check if upload is a document
  bool get isDocument => type == UploadType.document;

  /// Check if upload is completed
  bool get isCompleted => status == UploadStatus.completed;

  /// Check if upload is pending
  bool get isPending => status == UploadStatus.pending;

  /// Check if upload is processing
  bool get isProcessing => status == UploadStatus.processing;

  /// Check if upload failed
  bool get hasFailed => status == UploadStatus.failed;

  /// Get human readable file size
  String get humanReadableSize {
    if (size < 1024) return '${size}B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)}KB';
    if (size < 1024 * 1024 * 1024) {
      return '${(size / (1024 * 1024)).toStringAsFixed(1)}MB';
    }
    return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(1)}GB';
  }

  /// Get file extension from filename
  String? get fileExtension {
    final parts = filename.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : null;
  }
}

/// Create upload request
@JsonSerializable()
class CreateUploadRequest {
  final String filename;
  final String? originalName;
  final String mimeType;
  final int size;
  final String? alt;
  final String? description;
  final Map<String, dynamic>? metadata;

  const CreateUploadRequest({
    required this.filename,
    this.originalName,
    required this.mimeType,
    required this.size,
    this.alt,
    this.description,
    this.metadata,
  });

  factory CreateUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUploadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUploadRequestToJson(this);
}

/// Update upload request
@JsonSerializable()
class UpdateUploadRequest {
  final String? alt;
  final String? description;
  final Map<String, dynamic>? metadata;

  const UpdateUploadRequest({this.alt, this.description, this.metadata});

  factory UpdateUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUploadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUploadRequestToJson(this);
}

/// Upload URL request
@JsonSerializable()
class GetUploadUrlRequest {
  final String filename;
  final String mimeType;

  const GetUploadUrlRequest({required this.filename, required this.mimeType});

  factory GetUploadUrlRequest.fromJson(Map<String, dynamic> json) =>
      _$GetUploadUrlRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetUploadUrlRequestToJson(this);
}

/// Upload URL response
@JsonSerializable()
class UploadUrlResponse {
  final String url;
  final Map<String, dynamic>? fields;

  const UploadUrlResponse({required this.url, this.fields});

  factory UploadUrlResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadUrlResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadUrlResponseToJson(this);
}

/// Upload response
@JsonSerializable()
class UploadResponse {
  final Upload upload;

  const UploadResponse({required this.upload});

  factory UploadResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);
}

/// Uploads response
@JsonSerializable()
class UploadsResponse {
  final List<Upload> uploads;
  final int count;
  final int offset;
  final int limit;

  const UploadsResponse({
    required this.uploads,
    required this.count,
    required this.offset,
    required this.limit,
  });

  factory UploadsResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadsResponseToJson(this);
}
