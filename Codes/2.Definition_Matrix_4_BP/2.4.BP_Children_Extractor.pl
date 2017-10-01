# This code extracts children of GO terms included in BP ontology (Please read the read-me file before use!)
use IO::File;

$r = IO::File->new("../../Extra/BP/BP_GO_parents.dat","r") or die "Can not open file to read from;\nWe need to have parents first!\n";
open(my $w, '>', "../../Extra/BP/BP_GO_children.dat") or die "Could not open file to write in\n";

%hash;
foreach(<$r>){
	chomp;
	my @a = split ":: ";
	my @child = split " ", $a[0];
	my @par = split " ", $a[1];
	
	foreach(@par){
		$hash{$_} .= " ".$child[0];
	}
		
}

foreach(sort keys %hash){
		$w->print("$_:\:$hash{$_}\n");
}
