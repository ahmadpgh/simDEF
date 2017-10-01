# This code extracts full name of GO terms included in BP ontology (Please read the read-me file before use!)
use IO::File;

$r = IO::File->new("../../Extra/go.obo","r") or die "Can not open file to read from;\nYou need to download 'go.obo' file from the gene ontology website,\nand then put it in the 'Extra' folder\n";
open(my $w, '>', "../../Extra/BP/BP_GO_name.dat") or die "Can not open file to write in\n";

%hash;
my $i = 1;
my $flag  = 0;
my $GO_id;
%hash;
foreach(<$r>){
	chomp;
	if($_=~/^\[Typedef\]/){last;}
	
	if ($i <= 29){$i++;next;}
	
	if ((!($_=~/^\[Term\]/) and ($flag == 1))){
		
		if ($_=~/^id: GO:/){
			my @a = split /^id: GO:/;
			$GO_id = $a[1];
			if (!(exists $hash{$GO_id})){
				$hash{$GO_id} = "__OBSOLETE__";
			}
		}
		
		if(($_=~/^name: /) and (!($_=~/^name: obsolete /))){
			my @b = split /^name: /;
			$hash{$GO_id} = $b[1];
		}
		
		if($_=~/^namespace: /){
			if (!($_=~/^namespace: biological_process/)){
			#if (!($_=~/^namespace: cellular_component/)){
			#if (!($_=~/^namespace: molecular_function/)){
				$hash{$GO_id} = "__OBSOLETE__";
			}
		}

		if($_=~/^synonym: "/){
			if (!($hash{$GO_id} eq "__OBSOLETE__")){
			my @b = split /\"/;
				$hash{$GO_id} .= " --- $b[1]";
			}
		}
		
		if ($_=~/^alt_id: GO:/){
			my @b = split /^alt_id: GO:/;
			$hash{"$GO_id $b[1]"} = $hash{$GO_id};
			delete $hash{$GO_id};
			$GO_id = "$GO_id $b[1]";
		}		
		
	}else{
		$flag = 0;
	}
	
	if (($_=~/^\[Term\]/) and ($flag == 0)){ $flag = 1}
	
}

foreach(sort keys %hash){
	if(!($hash{$_} eq "__OBSOLETE__")){
		$w->print("$_:\: $hash{$_}\n");
	}
}
