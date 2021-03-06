package EggsML::Spellcheck;
use 5.020;
use warnings;

use Encode;
use Text::Aspell;
use utf8::all;

my $checker = Text::Aspell->new;
$checker->set_option('lang', 'da_DK');
$checker->set_option('encoding', 'utf-8');

sub spellcheck_word {
    my $word = shift;

    return $word if $word =~ qr/^\d+$/;
    return $word if $word =~ qr#^https?://#;

    while (! $checker->check($word) ) {
        my @suggs = map { decode('utf-8', $_) } $checker->suggest($word);
        if (@suggs) {
            $word = $suggs[rand @suggs];
            last;
        } else {
            # No matches! Oh no! Let's just remove a letter and try again.
            my $idx = rand (length $word);
            $word = substr($word, 0, $idx) . substr($word, $idx+1);
        }
    }

    return $word;
}

sub spellcheck {
    my $line = shift;
    $line =~ s#(\d+|https?://\S*|[-\w']+)#spellcheck_word($1)#eg;
    return $line;
}

1;

