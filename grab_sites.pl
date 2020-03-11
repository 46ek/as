#!/usr/bin/perl
#by Mr.MinoDz and RaiC0d3r
#TEAM O.R.H DZ 
#use Win32::Console::ANSI;
use Term::ANSIColor;
use LWP::UserAgent;


system(($^O eq 'MSWin32') ? 'cls' : 'clear');

$reverse_options = "

\tChoose an option for Reverse IP Lookup...!!!

	\t[1]  From One Site
	\t[2]  From  List IP 
	\n";
print colored("$reverse_options", 'bold green');
print colored("\n\t\tI wanna choose >>>>  ",'BOLD BLUE');
my $reverse_option = <STDIN>;
chomp $reverse_option;

my $rai = ("http://42.115.91.82:52225");
chomp $rai;
	
if ($reverse_option eq '1') {
	print colored("\n\t\tEnter the site >>>>  ",'BOLD BLUE');
	$single = <STDIN>;
	chomp $single;
	$single_look = "https://api.hackertarget.com/reverseiplookup/?q=$single";
	$ua = LWP::UserAgent->new(keep_alive => 1);
	$ua->proxy('https', ("$rai"));
	$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
	$ua->timeout (8);
	my $checar = $ua->get("$single_look")->content;
	if ($checar =~/No records found for/) {
		print colored("\t[-] $ip have no reverse site found :(\n",'BOLD YELLOW');
	}
	elsif ($checar =~/error check your search parameter/) {
		print colored("\t[-] $ip is wrong IP or its down :|\n",'BOLD RED');
	}
	else {
		print colored("\n [+] $ip Done ==> OK_BB\n",'BOLD GREEN');
		open(save, '>>OK_BB.txt');
		print save "$checar\n";
		close(save);
	}
}
elsif ($reverse_option eq '2') {
	print colored("\n\t\tEnter site list >>>>  ",'BOLD BLUE');
	$list=<STDIN>;
	chomp($list);
	open my($fh), '<:raw', $list or die "Can't open File...!!";
	while( sysread $fh, $buffer, 4096 ) {
	    $lines += ( $buffer =~ tr/\n// );
	}
	close $fh;
	print colored("\n\tGot $lines IP in the list dude...!!!\n",'BOLD YELLOW');
	print colored("\tGrabbing reverse from these one by one....Wait until finish...!!!\n",'BOLD YELLOW');
	print "\n\n";
	open(target,"<$list") or die "Can't open list";
	while (<target>) {
		chomp($_);
		$ip = $_;
		if ($ip =~ /https:\/\// && $ip =~ /http:\/\// ) {
			$ip = "$ip";
		}
		rev_mass();
	}
	sub rev_mass() {
		$mass_look = "https://api.hackertarget.com/reverseiplookup/?q=$ip";
		$ua = LWP::UserAgent->new(keep_alive => 1);
	    $ua->proxy('https', ("$rai")); 
		$ua->agent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31");
		$ua->timeout (8);
		my $checar = $ua->get("$mass_look")->content;
		if ($checar =~/No records found for/) {
			print colored("\tNo reverse site found :(\n",'BOLD YELLOW');
		}
		elsif ($checar =~/error check your search parameter/) {
			print colored("\tWrong or its down :|\n",'BOLD RED');
		}
		else {
			print colored("\n [+] Grabbing done :)\n",'BOLD GREEN');
			open(save, '>>mass.txt');
			print save "http://$checar\n";
			close(save);
		}
	}
}
else {
	print colored("\n\nWrong Option Dude....Next time choose a valid option...!!!",'BOLD RED');
}
