{

Joshua Trunk
4/12/2018
CSC540 Graduate Research Seminar (Online)

Using Free Pascal Compiler, this program simulates the European Roulette Wheel with one zero; no double zero. User inputs the amount of spins they want to gamble on and they select one lucky number for a chance to win a progressive jackpot
if that number appears twice in a row. The program computes random winning numbers and answers 5 questions regarding probabilities. 

}



program JackpotRoulette;

const	numResult 			=37; 		{Possible Numbers 0-36}
var	numSpins, x                     :qword; 	{number of spins}
	currentNumber			:integer; 	{ball is on this number now}
	previousNumber			:integer; 	{ball was on this number las spin}
	previousx2Number		:integer; 	{ball was on this number 2 spins ago}
	doubles				:int64; 	{ball landing on same number x2 in a row}
	triples				:int64;		{ball landing on same number x3 in a row}
	numLucky			:integer;	{lucky jackpot number, ie 13}
	numRun				:int64;		{consecutive run of Even and Odds}
	numEvens			:int64;		{consecutive run of Evens}
	numOdds				:int64;		{consecutive run of Odds}
	currentNumberJackpot		:Boolean;	{Jackpot winner - True or False}
	currentNumberJackpotSpin	:int64;		{On what spin was the jackpot awarded}
        myString                        :string;

begin

x:=0;
doubles:=0;
triples:=0;
numRun:=1;
numEvens:=1;
numOdds:=1;
previousNumber:=100;
previousx2Number:=100;
currentNumberJackpot:=False;
{setting initial values}



write ('How many spins would you like to gamble on? [Enter number & hit ENTER twice]');
readln (numSpins);

writeln;

write ('Pick your lucky number. Hit it twice in a row to win our PROGRESSIVE JACKPOT!!! [Pick any value 0-36 & hit ENTER twice]');
readln (numLucky);

writeln;

writeln ('No more bets. Your ', numSpins, ' spins are in progress. Your lucky number is ', numLucky, '. Good Luck!'); {print on console}

writeln;

randomize; {Initialize random number generator}

while (x < numSpins) do {loops until your NumSpins value is reached}

	begin

                x:= (x + 1); {increment loop by 1}
		currentNumber:= random(numResult); {random number where the ball lands}
                writeln(currentNumber); {print on console}

		if (currentNumber = previousNumber) {if two matching numbers in a row}
		then

		begin

			doubles:= (doubles + 1); {increments for question 1 answer}
			if (currentNumber = numLucky) AND (currentNumberJackpot = False) {looking question 3 numLucky}
			then

			begin
		
				currentNumberJackpotSpin:= x; {records spin that Jackpot hit}
				currentNumberJackpot:= True;
			end;

		if (previousNumber = previousx2Number) {matching numbers for questions 1-2}
		then
		triples:= (triples + 1); {increment for question 2}
		
		end;

	if (currentNumber = 0) {house wins, reset Even Number streak for question 4}
	then
	numRun:= 1;
	if (x > 1) AND (currentNumber <> 0 ) AND (currentNumber MOD 2 = 0) AND (previousNumber MOD 2 = 0) {Looking for consecutive evens numbers for question 4. Disregarding initial values and 0's}
		then
		begin

			numRun:= (numRun + 1); {increments for question 4}
			if (numRun > numEvens)
			then
			numEvens:= numRun; {records longest Even streak}

		end;

	if (currentNumber MOD 2 = 0) AND (previousNumber MOD 2 = 1) {reset streak}
	then
	numRun:= 1;

	if (currentNumber MOD 2 = 1) AND (previousNumber MOD 2 = 1) {consecutive odds question 5}
	then

		begin

			numRun:= (numRun + 1);
			if (numRun > numOdds) then
			numOdds:= numRun;

		end;

	if (currentNumber MOD 2 = 1) AND (previousNumber MOD 2 = 0)
	then
	numRun:= 1;

	previousx2Number:= previousNumber;
	previousNumber:= currentNumber;

	end;

writeln;

writeln('1. On average, how often does a number come up two times in a row? ', (doubles/numSpins)*100:6:3, '%');    {print on console}

writeln;

writeln('2. On average, how often does a number come up three times in a row? ', (triples/numSpins)*100:6:3, '%');   {print on console}

writeln;

if (currentNumberJackpot = False) {if console}
then
writeln('3. ', numLucky, ' never hit twice in a row. Progressive Jackpot increased.')  {print on console}
else
writeln('3. JACKPOT!!! Lucky number ', numLucky, ' hit twice in a row on spin ', currentNumberJackpotSpin, '. Would you like to record and pay your taxes now?');  {print on console}
writeln;

writeln('4. The longest run of winning even numbers in a row is ', numEvens);  {print on console}

writeln;

writeln('5. The longest run of winning odd numbers in a row is ', numOdds);  {print on console}

writeln;

write('Hit ENTER to cash out in Bitcoin and erase all your transactions from our books.');   {print on console}
readln;


end.
