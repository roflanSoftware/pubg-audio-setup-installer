## Installer source: `PUBG-Audio-Setup.iss`

This is the Inno Setup source file used to build `PUBG-Audio-Setup.exe`.

The installer:

- Installs Equalizer APO and Peace when they are not already installed.
- Detects Equalizer APO’s configuration folder, including custom installation locations.
- Copies the included VST plugins and compressor presets into Equalizer APO’s `config` folder.
- Creates and imports a `peace.txt` configuration from an optional personal EQ `.txt` file.
- Creates and selects the `_pubg-config` preset in Peace.
- Generates Equalizer APO’s main `config.txt` with plugin paths adjusted to the detected installation folder.
- Backs up an existing Equalizer APO `config.txt` before replacing it.
- Offers English, Russian, and Ukrainian installer interfaces.

Build it with [Inno Setup](https://jrsoftware.org/isinfo.php). The compiled installer is written to `dist\PUBG-Audio-Setup.exe`.
