%Play the game of guess the number
x=fix(100*rand);   %a random number calculated by the computer
n=7;
test=1;
for k=1:7
    numb=int2str(n);
    disp(['You have a right to ',numb,' guesses'])
    disp(['A guess is a number between 0 and 100'])
    guess=input('Enter your guess:');
    if guess<x
        disp('Low')
    elseif guess>x
        disp('High')
    else
        disp('You won')
        test=0;
        break;
    end
    n=n-1;
end
if test==1
    disp('You lost')
end
