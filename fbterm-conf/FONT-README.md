# Configure Fbterm TTY to work with powerline fonts

Check those 3 lines in `/etc/default/console-setup`:

```
CODESET="guess"
FONTFACE="Terminus"
FONTSIZE="10x20"
```

List files in `/usr/share/consolefonts` and select the best font.

It was for me: `Uni2-Terminus14.psf.gz`


Adapt:

```
CODESET="ter"
FONTFACE="powerline"
FONTSIZE="v16n"
```

Get a patched font here:
https://github.com/powerline/fonts/tree/master/Terminus/PSF

Becareful to rename ter-powerline-v20b to ter-powerlinev20b
