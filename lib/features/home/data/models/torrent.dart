class Torrent {
  final String? url;
  final String? hash;
  final String? quality;
  final String? type;
  final String? isRepack;
  final String? videoCodec;
  final String? bitDepth;
  final String? audioChannels;
  final int? seeds;
  final int? peers;
  final String? size;
  final int? sizeBytes;
  final String? dateUploaded;
  final int? dateUploadedUnix;

  const Torrent({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
    url: json['url'] as String?,
    hash: json['hash'] as String?,
    quality: json['quality'] as String?,
    type: json['type'] as String?,
    isRepack: json['is_repack']?.toString(),
    videoCodec: json['video_codec'] as String?,
    bitDepth: json['bit_depth'] as String?,
    audioChannels: json['audio_channels'] as String?,
    seeds: json['seeds'] as int?,
    peers: json['peers'] as int?,
    size: json['size'] as String?,
    sizeBytes: json['size_bytes'] as int?,
    dateUploaded: json['date_uploaded'] as String?,
    dateUploadedUnix: json['date_uploaded_unix'] as int?,
  );
}
