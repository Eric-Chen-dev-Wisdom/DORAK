# DORAK - Audio Assets

## Karaoke Audio Files

Place royalty-free karaoke audio clips here for the karaoke challenge mode.

### Required Format:
- Format: MP3 or WAV
- Duration: 10-30 seconds (short clips)
- Quality: 128kbps minimum

### Sample File Names:
- `happy_birthday.mp3`
- `twinkle.mp3`
- `arabic_song_1.mp3`
- `gulf_song_1.mp3`

### Where to Get Royalty-Free Music:
1. **YouTube Audio Library** - Free background music
2. **FreePD** - Public domain music
3. **Incompetech** - Royalty-free music by Kevin MacLeod
4. **Bensound** - Free music (with attribution)

### Usage in App:
```dart
AudioService().playAudio('audio/happy_birthday.mp3');
```

## Note:
For MVP testing, you can use placeholder audio or record simple melodies.
The app gracefully handles missing audio files.

