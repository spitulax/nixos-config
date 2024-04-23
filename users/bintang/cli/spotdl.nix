{ config
, pkgs
, ...
}: {
  home.packages = [ pkgs.spotdl ];
  home.file.".local/share/spotdl/config.json".text = ''
    {
      "max_retries": 3,
      "audio_providers": [
          "youtube-music",
          "youtube"
      ],
      "lyrics_providers": [
          "synced",
          "musixmatch",
          "genius",
          "azlyrics"
      ],
      "playlist_numbering": true,
      "output": "{artists} - {title}.{output-ext}",
      "overwrite": "skip",
      "search_query": "{title} - {artists}",
      "format": "mp3",
      "filter_results": true,
      "threads": 16,
      "print_errors": true,
      "sponsor_block": false,
      "preload": true,
      "load_config": true,
      "log_level": "INFO",
      "simple_tui": false,
      "fetch_albums": false,
      "id3_separator": "/",
      "ytm_data": false,
      "add_unavailable": false,
      "generate_lrc": false
    }
  '';
}
