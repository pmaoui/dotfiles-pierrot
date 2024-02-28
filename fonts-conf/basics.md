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

Kitty prevents us to use a patched font and to download NerdFontsSymbolsOnly.zip and use a regular font. It will automatically take Glyphs from that font.

Then use whatever mono font you want (ex: https://www.jetbrains.com/lp/mono/) and put them in `~/.local/share/fonts` and reload the font cache.
