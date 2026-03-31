class Torrent {
  final String url;
  final String hash;
  final String quality;
  final String type;
  final String isRepack;
  final String videoCodec;
  final String bitDepth;
  final String audioChannels;
  final int? seeds;
  final int? peers;
  final String size;
  final int? sizeBytes;
  final String dateUploaded;
  final int? dateUploadedUnix;

  const Torrent({
    required this.url,
    required this.hash,
    required this.quality,
    required this.type,
    required this.isRepack,
    required this.videoCodec,
    required this.bitDepth,
    required this.audioChannels,
    required this.seeds,
    required this.peers,
    required this.size,
    required this.sizeBytes,
    required this.dateUploaded,
    required this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
    url: (json['url'] as String?) ?? "",
    hash: (json['hash'] as String?) ?? "",
    quality: (json['quality'] as String?) ?? "",
    type: (json['type'] as String?) ?? "",
    isRepack: (json['is_repack'] as String?) ?? '',
    videoCodec: (json['video_codec'] as String?) ?? "",
    bitDepth: (json['bit_depth'] as String?) ?? "",
    audioChannels: (json['audio_channels'] as String?) ?? "",
    seeds: json['seeds'] as int?,
    peers: json['peers'] as int?,
    size: (json['size'] as String?) ?? "",
    sizeBytes: json['size_bytes'] as int?,
    dateUploaded: (json['date_uploaded'] as String?) ?? "",
    dateUploadedUnix: json['date_uploaded_unix'] as int?,
  );
}
