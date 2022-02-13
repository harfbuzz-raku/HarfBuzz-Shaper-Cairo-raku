use HarfBuzz::Shaper;

#| HarfBuzz / Cairo shaping integration
unit class HarfBuzz::Shaper::Cairo:ver<0.0.3>
    is HarfBuzz::Shaper;

=begin pod

=head2 Synopsis

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

=head3 Description

This module compiles a set of shaped glyphs into a Cairo::Glyphs object; suitable for use by the Cairo::Context `show_glyphs()` and `glyph_path()` methods.

Please see the `examples/` folder, for a full working example.

=head2 Methods
=end pod

use Cairo;
#| Return a set of Cairo compatible shaped glyphs
method cairo-glyphs(
    HarfBuzz::Shaper:D $shaper = self:
    Numeric :x($x0) = 0e0,
    Numeric :y($y0) = 0e0,
    |c --> Cairo::Glyphs
) is export(:cairo-glyphs) {
    my Cairo::Glyphs $cairo-glyphs .= new: :elems($shaper.buf.length);
    my Cairo::cairo_glyph_t $cairo-glyph;
    my int $i = 0;
    my Num $x = $x0.Num;
    my Num $y = $y0.Num;

    for $shaper.shape(|c) -> $glyph {
        $cairo-glyph = $cairo-glyphs[$i++];
        $cairo-glyph.index = $glyph.gid;
        $cairo-glyph.x = $x + $glyph.x-offset;
        $cairo-glyph.y = $y + $glyph.y-offset;
        $x += $glyph.x-advance;
        $y += $glyph.y-advance;
    }

    $cairo-glyphs.x-advance = $x - $x0;
    $cairo-glyphs.y-advance = $y - $y0;

    $cairo-glyphs;
}
=begin pod
=para The returned object is typically passed to either the Cairo::Context show_glyphs() or glyph_path() methods
=end pod
