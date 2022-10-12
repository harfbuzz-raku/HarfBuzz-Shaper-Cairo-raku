[[Raku HarfBuzz Project]](https://harfbuzz-raku.github.io)
 / [[HarfBuzz-Shaper-Cairo Module]](https://harfbuzz-raku.github.io/HarfBuzz-Shaper-Cairo-raku)
 / [HarfBuzz::Font::Cairo](https://harfbuzz-raku.github.io/HarfBuzz-Shaper-Cairo-raku/HarfBuzz/Font/Cairo)

class HarfBuzz::Font::Cairo
---------------------------

A FreeType integrated Cairo font

Methods
-------

### new

```raku
    multi method new(Font::FreeType::Face:D :$ft-face!, *%opts)
    multi method new(Str:D :$file!, *%opts)
```

Creates an object from a [FreeType::face](FreeType::face) object, or a file to be loaded as a [FreeType::face](FreeType::face) object.

### shaping-font

```raku
method shaping-font returns HarfBuzz::Font::FreeType
```

Returns the built [HarfBuzz::Font::FreeType](https://harfbuzz-raku.github.io/HarfBuzz-Font-FreeType-raku) object.

