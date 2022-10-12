#| A FreeType integrated Cairo font
unit class HarfBuzz::Font::Cairo;

use Font::FreeType;
use HarfBuzz::Buffer;
use HarfBuzz::Shaper::Cairo;
use Font::FreeType::Face;
use HarfBuzz::Font::FreeType;
use Cairo;

has Cairo::Font $.cairo-font is built;
has HarfBuzz::Font::FreeType() $.shaping-font handles<ft-face>;

my Font::FreeType $freetype .= new;

multi submethod TWEAK(Font::FreeType::Face:D :$ft-face!, *%o) {
    $!cairo-font .= create($ft-face.raw, :free-type);
    $!cairo-font.face.reference;
    $!shaping-font = %( :$ft-face, %o );
}

multi submethod TWEAK(Str:D :$file!, *%o) {
    my Font::FreeType::Face $ft-face = $freetype.face($file);
    self.TWEAK(:$ft-face, |%o);
}

multi method COERCE(%opt) { self.new: |%opt }

method shaper(HarfBuzz::Buffer() $buf) {
     HarfBuzz::Shaper::Cairo.new: :$buf, :font($!shaping-font);
}

submethod DESTROY {
    $!cairo-font.face.destroy;
}

=begin pod
=head2 Methods
=head3 new
=begin code :lang<raku>
    multi method new(Font::FreeType::Face:D :$ft-face!, *%opts)
    multi method new(Str:D :$file!, *%opts)
=end code
Creates an object from a L<FreeType::face> object, or a file to be loaded as a  L<FreeType::face> object.

=head3 shaping-font
=for code :lang<raku>
method shaping-font returns HarfBuzz::Font::FreeType

Returns the built L<HarfBuzz::Font::FreeType> object.
=end pod
