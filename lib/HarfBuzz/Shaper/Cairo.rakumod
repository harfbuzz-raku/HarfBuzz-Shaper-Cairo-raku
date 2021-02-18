use HarfBuzz::Shaper;

#| HarfBuzz / Cairo shaping integration
unit class HarfBuzz::Shaper::Cairo
    is HarfBuzz::Shaper;

use Cairo;
#| Return a set of Cairo compatible shaped glyphs
method cairo-glyphs(HarfBuzz::Shaper:D $shaper = self: Numeric :x($x0) = 0e0, Numeric :y($y0) = 0e0, |c) is export(:cairo-glyphs) {
    my Cairo::Glyphs $cairo-glyphs .= new: :elems($shaper.buf.length);
    my Cairo::cairo_glyph_t $cairo-glyph;
    my int $i = 0;
    my Num $x = $x0.Num;
    my Num $y = $y0.Num;

    for $shaper.shape(|c) -> $glyph {
        $cairo-glyph = $cairo-glyphs[$i++];
        $cairo-glyph.index = $glyph.codepoint;
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
