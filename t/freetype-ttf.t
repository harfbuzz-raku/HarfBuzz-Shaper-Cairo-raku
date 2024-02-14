use HarfBuzz;
use HarfBuzz::Shaper;
use HarfBuzz::Font::FreeType;
use HarfBuzz::Raw::Defs :hb-script, :hb-direction;
use Font::FreeType;
use Font::FreeType::Face;
use Test;
plan 7;
unless $*RAKU.compiler.version >= v2020.11 {
    die "This version of Raku is too old to use the HarfBuzz semantics";
}
my Version $version = HarfBuzz.version;

unless $version >= v1.6.0 {
    skip-rest "HarfBuzz version $version is too old to run these tests";
    exit;
}

my $file = 't/fonts/unifont-subset.ttf';

my HarfBuzz::Shaper $shaper .= new: :font{ :$file, :size(20) }, :buf{:text<Hello>, :language<epo>};

my Font::FreeType::Face $ft-face = Font::FreeType.new.face($file);
my HarfBuzz::Font::FreeType() $font = %( :$ft-face, :size(20), );
my HarfBuzz::Shaper $ft-shaper .= new: :$font, :buf{:text<Hello>, :language<epo>};

for <size length language script direction> {
    is $ft-shaper."$_"(), $shaper."$_"(), "FreeType $_ accessor";
}

enum <x y>;
is-approx $shaper.text-advance[x], $ft-shaper.text-advance[x];

my @shape = $shaper.shape;
my @ft-shape = $ft-shaper.shape;

is-approx @ft-shape.tail<ax>, @shape.tail<ax>;

