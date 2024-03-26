# To list fonts on the system
```
fc-list
```

# I can delete files there to remove fonts then update the cache:
```
fc-cache -fv
```

# Local fonts should be there:
```
~/.local/share/fonts
```

# Kitty

Kitty can only use [Mono fonts](https://sw.kovidgoyal.net/kitty/faq/#kitty-is-not-able-to-use-my-favorite-font)

List available and compatible fonts in the system:

```
kitty +list-fonts
```

Kitty prevents us to use a patched font.  We must download "Symbols Nerd Font Mono" inside NerdFontsSymbolsOnly.zip:
https://github.com/ryanoasis/nerd-fonts/releases/

With our Kitty configuration, we take Glyphs from that font while we use whatever mono font we want (ex: https://www.jetbrains.com/lp/mono/) and put them in `~/.local/share/fonts` and reload the font cache.

Details are here: https://www.reddit.com/r/KittyTerminal/comments/urm6cc/how_to_enable_font_features_for_jetbrainsmono/
