[[Raku HarfBuzz Project]](https://harfbuzz-raku.github.io)
 / [[HarfBuzz-Shaper-Cairo Module]](https://harfbuzz-raku.github.io/HarfBuzz-Shaper-Cairo-raku)

class HarfBuzz::Shaper::Cairo
-----------------------------

HarfBuzz / Cairo shaping integration

Synopsis
--------

    use HarfBuzz::Shaper::Cairo :&cairo-glyphs;
    use HarfBuzz::Shaper;
    use Cairo;
    my Cairo::Glyphs $glyphs;
    my $file = 't/fonts/NimbusRoman-Regular.otf';
    my $text = 'Hell€!';
    # -- functional interface --
    my HarfBuzz::Shaper $shaper .= new: :font{:$file}, :buf{:$text};
    $glyphs = cairo-glyphs($shaper);
    # -- OO interface --
    my HarfBuzz::Shaper::Cairo $shaper2 .= new: :font{:$file}, :buf{:$text};
    $glyphs = $shaper2.cairo-glyphs;
    # -- FreeType integration --
    use Font::FreeType;
    use Font::FreeType::Face;
    use Harfbuzz::Shaper::Cairo::Font;
    my Font::FreeType::Face $ft-face = Font::FreeType.face: $file;
    my Harfbuzz::Shaper::Cairo::Font $font .= new: :$file;
    my HarfBuzz::Shaper::Cairo $shaper3 .= $font.shaper: {:$text};
    $glyphs = $shaper3.cairo-glyphs;

### Description

This module compiles a set of shaped glyphs into a Cairo::Glyphs object; suitable for use by the Cairo::Context `show_glyphs()` and `glyph_path()` methods.

Please see the `examples/` folder, for a full working example.

Methods
-------

### method cairo-glyphs

```raku
method cairo-glyphs(
    Numeric :x($x0) = 0e0,
    Numeric :y($y0) = 0e0,
    |c
) returns Cairo::Glyphs
```

Return a set of Cairo compatible shaped glyphs

The returned object is typically passed to either the Cairo::Context show_glyphs() or glyph_path() methods

