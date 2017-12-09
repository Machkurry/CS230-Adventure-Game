#perl1b_gc_JOHNSON
#created by Alec Johnson
#new updates 9/25/2017
#found that with this particular version of the code,
#if the user throws out block and attack more often they have a better chance of winning
#this is due to the fact that since the computer throws out the block and attack more often
#there's a statistically better chance of hitting it for 3 on an attack roll of 4 or better;


#This is a standalone program that takes user input
#from the command line and compares a randomly rolled attack from the computer

#computer rolls a 4, on a 1-2 block and attack is thrown, 3 ranged, 4 quick attack


#This is a fighting game. There are three moves:
#Quick Strike, Block and Attack and Ranged
#Quick strike hits against Block and Attack 4/6 times
#Block and Attack hits Ranged 4/6 times
#Ranged hits Quick Strikes 4/6 times
#Similar attacks hit each other 3/6 times
#Attacks that are weak against others(ie, Quick Strike vs Ranged) hit 2/6 times
#Attacks are determined by a randomized number between 1 and 6(1 being the worst, 6 being the best)
#in order for an attack to do damage the attack has to exceed the opponents
#AND hit it's target number(ie a quick attack needs to roll a 5 or better against a ranged attack)
#Ties result in no damage on either side and the fight continues,
#the idea coming from fighting games where when attacks hit at the same time there are clashes that
#result in no damage
#




#subroutine to determine attack value
sub attack{

$cattack = int (rand(6)+1);
$pattack = int (rand(6)+1);

}

#subroutine to determine computer's input(1 is quick attack, 2 is ranged, 3 is block and attack)
sub robot{
  $input = int(rand(4)+1);
	my ($input) = @_;
	if($input == 4)
	{
		$input = "q";

	}
		elsif($input == 3)
		{
			$input = "r";
		}
		else
		{
			$input = "b";
		}
		return $input;

}

%word = (

"b"=>"Cross Counter",
"q"=>"Quick Strike",
"r"=>"HADOUKEN",
);




%fighter = (

"b"=>3,
"q"=>1,
"r"=>2,
"phealth"=>9,
"chealth"=>15,

);

				do
				#continues until somebody dies
{

$exit = 0;
#define input for player
	while ($exit == 0)
	{
	print "\nSHOW ME WHAT YOU GOT!!\nq = Quick Strike\nr = Ranged Attack\nb = Block and Attack\n";
	$pinput = <STDIN>;
	$pinput = lc($pinput);
	chomp($pinput);
	$shortp = substr($pinput, 0, 1);#temp for player attack so any extraneous characters are ignored
#compare input from player
		if($shortp eq "q"){

        $exit =1;
				print "\nFast Jab\n";
				}
		elsif($shortp eq "r"){
				$exit =1;
				print "\nHADOUKEN!\n";
				}
		elsif($shortp eq "b"){
				$exit =1;
				print "\nCross Counter!\n";
				}
		else{
		$exit =0;
		print "\nOH jeez, wrong input, if this weren't in beta, you'd be in trouble\n";
}
}
#define computer's choice
$rchoice = robot($input);
print "\n",$rchoice,"\n";
#this allows us to reference this value in the hash made earlier
print "The computer picked ", "$word{$rchoice}", "\n";

#roll the dice for both player and computer, which wil determine who hits who
$cresult = attack($cattack);
$presult =attack($pattack);

print "c: The computer swung at ",$cresult, " speed\n";
print "p: The player swung at ",$presult, " speed\n";


#compare values between player and computer, player strong attacks
if((($shortp eq "q") && ($rchoice eq "b"))
|| (($shortp eq "r") &&($rchoice eq "q"))
|| (($shortp eq "b") &&($rchoice eq "r")))
	{
		#would like to eventually add in a critical hit value,
		if(($presult > 2) && ($presult > $cresult))
		{
			print "You hit the computer for ", $fighter{$shortp}, " damage with a ", $word{$shortp}, "!\n",
			"This brings the robot's health down to ",
	    ($fighter{chealth} = ($fighter{chealth} - $fighter{$shortp})), "\nYour current health is ", $fighter{phealth},"\n";
		}
			elsif(($cresult > 4) && ($presult < $cresult))
			{
				print "The computer hits you for ", $fighter{$rchoice}, " damage with a ",$word{$rchoice}, "!\n",
				"This reduces your health down to ",
		   ($fighter{phealth} =($fighter{phealth} - $fighter{$rchoice})), "\nThe computer's health is ", $fighter{chealth},"\n";
			}
			else{
				print "CLASH!! NO DAMAGE TO EITHER PLAYER!!! THE FIGHT CONTINUES!","\nPlayer health: ",$fighter{phealth},
				 "\nComputer health: ", $fighter{chealth},"\n";
			}
		}
		#computer and player, weak attacks against computer
	elsif((($shortp eq "r") && ($rchoice eq "b"))
	|| (($shortp eq "q") &&($rchoice eq "r"))
	|| (($shortp eq "b") &&($rchoice eq "q")))
	{
		if(($presult > 4) && ($presult > $cresult))
		{
			print "You hit the computer for ", $fighter{$shortp}, " damage with a ", $word{$shortp},"!\n",
			"This brings the robot's health down to ",
	    ($fighter{chealth}=($fighter{chealth} - $fighter{$shortp})), "\nYour current health is ", $fighter{phealth},"\n";
		}
			elsif(($cresult > 2) && ($presult < $cresult))
			{
				print "The computer hits you for ", $fighter{$rchoice}, " damage with a ", $word{$rchoice},"!\n",
				"This reduces your health down to ",
		    ($fighter{phealth} =($fighter{phealth} - $fighter{$rchoice})), "\nThe computer's current health is ", $fighter{chealth},"\n";
			}
			else{
				print "CLASH!! NO DAMAGE TO EITHER PLAYER!!! THE FIGHT CONTINUES!","\nPlayer health: ",$fighter{phealth},
				 "\nComputer health: ", $fighter{chealth}, "\n";
			}

}

	else
	{
		#attacks hitting against themselves
		if(($presult > 3) && ($cresult < $presult))
		{
			print "You hit the computer for ", $fighter{$shortp}, " damage with a ", $word{$shortp},"!\n",
			"This brings the robot's health down to ",
	   ($fighter{chealth} = ($fighter{chealth} - $fighter{$shortp})), "\nYour current health is ", $fighter{phealth},"\n";
		}
			elsif(($cresult > 3) && ($presult < $cresult))
			{
				print "The computer hits you for ", $fighter{$rchoice}, " damage with a ", $word{$rchoice},"!\n",,
				"This reduces your health down to ",
		    ($fighter{phealth} = ($fighter{phealth} - $fighter{$rchoice})),"\nThe computer's health is ", $fighter{chealth},"\n";
			}
			else{
				print "CLASH!! NO DAMAGE TO EITHER PLAYER!!! THE FIGHT CONTINUES!","\nPlayer health: ",$fighter{phealth},
				 "\nComputer health: ", $fighter{chealth},"\n";

			}

	}


#exit out of the loop and tally up wins
	if($fighter{phealth}<1)
	{
		$cw++;#counts computer wins
		print "\nOH NO, YOU LOST TO THE COMPUTER! GIT GUD SCRUB!\n";
		print "\nWould you like to try again and regain your honor? You have lost ", $cw, " time(s) so far.\n";
		print "\ny/n\n";
		$gitgud = <STDIN>;
		$gitgud = lc($gitgud);
		chomp($gitgud);
		$shorta = substr($gitgud, 0, 1);

		if($shorta eq "y")#resets loop and health
		{
			$fighter{chealth} = 15;
			$fighter{phealth} = 9;

		}
		else{
			print "Bye scrub. How's it feel to be a ",$cw, " time loser huh?";
			$fighter{phealth} =0;
		}
	}

	elsif($fighter{chealth} < 1)
	{
		$pw++;#counts player wins
		print "\nNicely done, you kicked that robot's ass! You've kicked metal ass ",$pw, " times so far","\n";
		print "\nWant to try again? \ny/n\n";

	$gitgud = <STDIN>;
	$gitgud = lc($gitgud);
	chomp($gitgud);
	$shorta = substr($gitgud, 0, 1);

	if($shorta eq "y")#resets loop and health
	{
		$fighter{chealth} = 15;
		$fighter{phealth} = 9;

	}
	else{
		print "Bye Knight of awesome computer slaying! You killed ", $pw, " robot(s). \nYou're rad as hell!";
		$fighter{phealth} = 0;
		$fighter{chealth} = 0;
	}
	}

}

while(($fighter{phealth} > 0) && ($fighter{chealth} > 0));#conditional statement for loop
