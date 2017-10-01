# This code prepares (extended) definitions of GO terms included in MF ontology for their definition vectors (Please read the read-me file before use!)
use IO::File;

my $r1 = IO::File->new("../../Extra/MF/MF_Extended_Definition.dat","r") or die "Can not open file to read from;\nRun '2.6.MF_Extended_Definition_Construction.pl' first!\n";
my $r2 = IO::File->new("../../Extra/word_index.dat","r") or die "Can not open file to read from;\nRun '1.1.Bigrams_2_Sparse_4_R_preparation.pl' first!\n";
open(my $w, '>', "../../Extra/MF/MF_Pre_Definition_Matrix.dat") or die "Could not open file to write in\n";

my $stopregex;
open (STP , "..\\..\\Extra\\Stoplist.dat") or die "Can not open 'stoplist.dat';\nMake sure it exists in the 'Extra' folder\n";
	$stopregex  = "(";
	while(<STP>) {
		chomp;
		if($_ ne ""){
			$_=~s/\///g;
			$stopregex .= "$_|";
		}
	}   
chop $stopregex; $stopregex .= ")";
close STP;	

%hash;
foreach(<$r2>){
	chomp;
	my @a = split " ";
	$hash{$a[0]} = 1;
}

foreach(<$r1>){
	chomp;
	my @a = split ":: ";
	my $def = lc $a[1];
	$def=~s/--|-vs.-|<li>|<\/li>|<\/ul>|<ul>|<\/em>|<em>|-vs.-|\(<|proto-|&quot/ /g;
	$def=~s/[\~\.\,\?\\\/\'\|\"\;\:\[\]\{\}\!\@\#\$\%\^\&\*\(\)\_\+\-\<\>\=]/ /g;
	$def=~s/  / /g;
	$def=~s/ \d*th | \d*nd | \d*rd | \d*s | \d*d | \d*h | \d*m / /g;	
	$def=~s/\s+/ /g;
	
	my @b = split " ", $def;
	my %hash_temp;
	foreach(@b){
		if(!($_=~$stopregex) and (exists $hash{$_})){
			$hash_temp{$_}++;
		}
	}
	
	$w->print("$a[0]:\:");
	foreach(sort keys %hash_temp){
		$w->print(" $_ $hash_temp{$_}");	
	}
	$w->print("\n");
}
