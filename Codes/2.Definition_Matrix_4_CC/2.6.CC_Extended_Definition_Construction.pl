# This code constructs extended definitions of GO terms included in CC ontology (Please read the read-me file before use!)
use IO::File;

my $r1 = IO::File->new("../../Extra/CC/CC_GO_name.dat","r") or die "Can not open file to read from;\nRun '2.1.CC_Name_Extractor.pl' first!\n";
my $r2 = IO::File->new("../../Extra/CC/CC_GO_definition.dat","r") or die "Can not open file to read from;\nRun '2.2.CC_Definition_Extractor.pl' first!\n";
my $r3 = IO::File->new("../../Extra/CC/CC_GO_parents.dat","r") or die "Can not open file to read from;\nRun '2.3.CC_Parents_Extractor.pl' first!\n";
my $r4 = IO::File->new("../../Extra/CC/CC_GO_children.dat","r") or die "Can not open file to read from;\nRun '2.4.CC_Children_Extractor.pl' first!\n";
my $r5 = IO::File->new("../../Extra/CC/CC_GO_extra_relationship.dat","r") or die "Can not open file to read from;\nRun '2.5.CC_Extra_Relationship_Extractor.pl' first!\n";
open(my $w, '>', "../../Extra/CC/CC_Extended_Definition.dat") or die "Could not open file to write in\n";

%hash_name;
foreach(<$r1>){
	chomp;
	my @a = split ":: ";
	my @b = split " ", $a[0];
	#$hash_name{$b[0]} = $a[1];	### If you want to include names of GO terms in their extended definitions uncomment this and comment the line below
	$hash_name{$b[0]} = "";
}

%hash_def;
%hash_ext_def;
foreach(<$r2>){
	chomp;
	my @a = split ":: ";
	my @b = split " ", $a[0];
	$hash_def{$b[0]} = $hash_name{$b[0]}." --- ".$a[1];
	$hash_ext_def{$b[0]} = $hash_def{$b[0]};
}


foreach(<$r3>){
	chomp;
	my @a = split ":: ";
	my @b = split " ", $a[0];
	my @par = split " ", $a[1];
	foreach(@par){
		$hash_ext_def{$b[0]} .= " --- ".$hash_def{$_};
	}
}

foreach(<$r4>){
	chomp;
	my @a = split ":: ";
	my @b = split " ", $a[0];
	my @chil = split " ", $a[1];
	foreach(@chil){
		$hash_ext_def{$b[0]} .= " --- ".$hash_def{$_};
	}
}

foreach(<$r5>){
	chomp;
	my @a = split ":: ";
	my @b = split " ", $a[0];
	my @rel = split " ", $a[1];
	foreach(@rel){
		$hash_ext_def{$b[0]} .= " --- ".$hash_def{$_};
	}
}

foreach(sort keys %hash_ext_def){
		$w->print("$_:\: $hash_ext_def{$_}\n");
}
