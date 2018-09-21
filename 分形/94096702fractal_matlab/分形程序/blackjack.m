function blackjack(N)
% BLACKJACK.  Use random numbers in Monte Carlo simulation.
% Play the game of Blackjack, either one hand, or thousands of hands,
% at a time, and display payoff statistics.
%
% In Blackjack, face cards count 10 points, aces count one or 11 points,
% all other cards count their face value.  The objective is to reach,
% but not exceed, 21 points.  If you go over 21, or "bust", before the
% dealer, you lose your bet on that hand.  If you have 21 on the first
% two cards, and the dealer does not, this is "blackjack" and is worth
% 1.5 times the bet.  If your first two cards are a pair, you may "split"
% the pair by doubling the bet and use the two cards to start two
% independent hands.  You may "double down" after seeing the first two
% cards by doubling the bet and receiving just one more card.
% "Hit" and "draw" mean take another card.  "Stand" means stop drawing.
% "Push" means the two hands have the same total.
%
% The first mathematical analysis of Blackjack was published in 1956
% by Baldwin, Cantey, Maisel and McDermott. Their basic strategy, which
% is also described in many more recent books, makes Blackjack very
% close to a fair game.  With basic strategy, the expected win or loss
% per hand is less than one percent of the bet.  The key idea is to
% avoid going bust before the dealer.  The dealer must play a fixed
% strategy, hitting on 16 or less and standing on 17 or more.  Since
% almost one-third of the cards are worth 10 points, you can compare
% your hand with the dealer's under the assumption that the dealer's
% hole card is a 10.  If the dealer's up card is a six or less, she
% must draw.  Consequently, the strategy has you stand on any total over
% 11 when the dealder is showing a six or less.  Split aces and split 8's.
% Do not split anything else.  Double down with 11, or with 10 if the
% dealer is showing a six or less.  The complete basic strategy is
% defined by three arrays, HARD, SOFT and SPLIT, in the code.
%
% A more elaborate strategy, called "card counting", can provide a
% definite mathematical advantage.  Card counting players keep track
% of the cards that have appeared in previous hands, and use that
% information to alter both the bet and the play as the deck becomes
% depleated.  Our simulation does not involve card counting.
%
% BLACKJACK(N) plays N hands with an initial bet of $10 for each hand.
% "Play" mode, N = 1, indicates the basic strategy with color, but allows
% you to make other choices.  "Simulate" mode, N > 1, plays N hands
% using basic strategy and displays the evolving payoff results.
% One graph shows the total return accumulated over the duration of the
% simulation.  Another graph shows the observed probabilities of the
% ten possible payoffs for each hand.  These payoffs include zero for a
% push, win $15 for a blackjack, win or lose $10 on a hand that has not been
% split or doubled, win or lose $20 on a hand that has been split or doubled,
% and win or lose $30 or $40 on hands that are after doubled after a split.
% The $30 and $40 payoffs occur rarely (and may not be allowed at some
% casinos), but are important in determining the expected return from the
% basic strategy.  The second graph also displays with 0.xxxx +/- 0.xxxx
% the expected fraction of the bet that is won or lost each hand, together
% with its confidence interval.  Note that the expected return is usually
% negative, but within the confidence interval.  The total return in any
% session with less than a few million hands is determined more by the luck
% of the cards than by the expected return.
%
%   From "Numerical Computing with MATLAB"
%   Cleve Moler
%   The MathWorks, Inc.
%   See http://www.mathworks.com/moler
%   March 1, 2004.  Copyright 2004.

clf
shg
set(gcf,'name','Blackjack','menu','none','numbertitle','off', ...
   'double','on','userdata',[])
rand('state',sum(100*clock))
if nargin == 0
   N = 10000;
   kase = 1;
else
   if ischar(N)
      N = str2double(N);
   end
   bj(N)
   kase = 2;
end
while kase > 0
   kase = bjbuttonclick(kase);
   switch kase
      case 0, break    % Close
      case 1, bj(1)    % Play one hand
      case 2, bj(N)    % Simulate
   end
end
close(gcf)


% ------------------------

function bj(N)
% Blackjack, main program.
% Play N hands.
% If N == 1, show detail and allow interaction.
   
S = get(gcf,'userdata');
n = length(S);
bet = 10;
detail = N==1;

% Set up graphics 

if detail
   delete(get(gca,'children'))
   delete(findobj(gcf,'type','axes'))
   axes('pos',[0 0 1 1])
   axis([-5 5 -5 5])
   axis off
   bjbuttons('detail');
   stake = sum(S);
   if stake >= 0, sig = '+'; else, sig = '-'; end
   str = sprintf('%6.0f hands,  $ %c%d',n,sig,abs(stake));
   titl = text(-2.5,4.5,str,'fontsize',20);
   n0 = n+1;
   n1 = n0;
else
   bjbuttons('off');
   payoffs = [-4:1 1.5 2:4]*bet;   % Possible payoffs
   counts = hist(S,payoffs);
   n0 = n+1;
   n1 = ceil((n0)/N)*N;
   subplot(2,1,2)
   h = plot(0,0);
end
S = [S zeros(1,n1-n0+1)];

for n = n0:n1
   bet1 = bet;
   P = deal;         % Player's hand
   D = deal;         % Dealer's hand
   P = [P deal];
   D = [D -deal];    % Hide dealer's hole card
      
   % Split pairs
   split = mod(P(1),13)==mod(P(2),13);
   if split
      if detail
         show('Player',P)
         show('Dealer',D)
         split = pair(value(P(1)),value(D(1)));
         % 0 = Keep pair
         % 1 = Split pair
         split = bjbuttonclick('split',split+1);
      else
         split = pair(value(P(1)),value(D(1)));
      end
   end
   if split
      P2 = P(2);
      if detail, show('Split',P2); end
      P = [P(1) deal];
      bet2 = bet1;
   end
      
   % Play player's hand(s)
   if detail
      [P,bet1] = playhand('Player',P,D,bet1);
      show('Player',P)
      if split
         P2 = [P2 deal];
         show('Split',P2)
         [P2,bet2] = playhand('Split',P2,D,bet2);
      end
   else
      [P,bet1] = playhand('',P,D,bet1);
      if split
         P2 = [P2 deal];
         [P2,bet2] = playhand('',P2,D,bet2);
      end
   end
      
   % Play dealer's hand
   D(2) = -D(2);     % Reveal dealer's hole card
   while value(D) <= 16
      D = [D deal];
   end
      
   % Payoff
   if detail
      show('Dealer',D)
      show('Player',P)
      s = payoff('Player',P,D,split,bet1);
      if split
         show('Split',P2)
         s = s + payoff('Split',P2,D,split,bet2);
      end
   else
      s = payoff('',P,D,split,bet1);
      if split
         s = s + payoff('',P2,D,split,bet2);
      end
   end
   S(n) = s;

   if detail
      stake = stake + s;
      if stake >= 0, sig = '+'; else, sig = '-'; end
      str = sprintf('%6.0f hands,  $ %c%d',n,sig,abs(stake));
      set(titl,'string',str)
   end

   chunk = min(2000,N);
   if ~detail & mod(n,chunk) == 0
      Schunk = S(n-chunk+1:n);

      subplot(2,1,2)
      ydata = get(h,'ydata');
      ydata = ydata(end) + cumsum(Schunk);
      ylim = get(gca,'ylim');
      if max(ydata) > ylim(1) | min(ydata) < ylim(2)
         ydata = cumsum(S(1:n));
         h = plot(1:n,ydata,'erasemode','none');
         line([1 n1],[0 0],'color','black')
         ylim = 1000*[floor(min(min(ydata)/1000,-1)) ...
                      ceil(max(max(ydata)/1000,1))];
         axis([1 n1 ylim])
      else
         set(h,'xdata',n-chunk+1:n,'ydata',ydata);
      end

      subplot(2,1,1)
      [kounts,x] = hist(S(n-chunk+1:n),payoffs);
      counts = counts + kounts;
      p = counts/n;
      bar(x,p)
      axis([-4.5*bet 4.5*bet 0 .45])
      stake = ydata(end);
      if stake >= 0, sig = '+'; else, sig = '-'; end
      str = sprintf('%c%d',sig,abs(stake));
      if abs(stake) < 1000, str = [' ' str]; end
      if abs(stake) < 100, str = [' ' str]; end
      if abs(stake) < 10, str = [' ' str]; end
      title(sprintf('%6.0f hands,  $ %s',n,str))
      set(gca,'xtick',payoffs);
      for k = 1:length(payoffs)
         if payoffs(k)==15, y = -.12; else, y = -.08; end
         text(payoffs(k)-6.5,y,sprintf('%9.4f',p(k)));
      end

%     Mean and confidence interval, relative to unit bet

      r = payoffs/bet;
      mu = p*r';
      crit = 1.96;         % norminv(.975)
      rho = crit*sqrt((p*(r.^2)'-mu^2)/n);
      pm = char(177);
      text(20,.3,sprintf('%6.4f %c %6.4f',mu,pm,rho));
      drawnow
   end
end
set(gcf,'userdata',S);


% ------------------------

function c = deal
% Deal one card

persistent deck ncards
if isempty(deck) | ncards < 6
   % Four decks
   deck = [1:52 1:52 1:52 1:52];
   % Shuffle
   ncards = length(deck);
   deck = deck(randperm(ncards));
end
c = deck(ncards);
ncards = ncards - 1;


% ------------------------

function v = valuehard(X)
% Evaluate hand
X = mod(X-1,13)+1;
X = min(X,10);
v = sum(X);

% ------------------------

function v = value(X)
% Evaluate hand
X = mod(X-1,13)+1;
X = min(X,10);
v = sum(X);
% Promote soft ace
if any(X==1) & v<=11
   v = v + 10;
end

% ------------------------

function [P,bet] = playhand(hand,P,D,bet)
% Play player's hand

while value(P) < 21
   % 0 = stand
   % 1 = hit
   % 2 = double down
   if any(mod(P,13)==1) & valuehard(P)<=10
      strat = soft(value(P)-11,value(D(1)));
   else
      strat = hard(value(P),value(D(1)));
   end
   if length(P) > 2 & strat == 2
      strat = 1;
   end
   if ~isempty(hand)
      show(hand,P)
      show('Dealer',D)
      strat = bjbuttonclick('hit',strat+1,length(P)>2);
   end
   switch strat
       case 0
          break
       case 1
          P = [P deal];
       case 2
          % Double down.
          % Double bet and get one more card
          bet = 2*bet;
          P = [P deal];
          break
       otherwise
          break
   end
end


% ------------------------

function s = payoff(who,P,D,split,bet)
% Payoff
detail = ~isempty(who);
fs = 20;
valP = value(P);
valD = value(D);
if valP == 21 & length(P) == 2 & ...
   ~(valD == 21 & length(D) == 2) & ~split
   s = 1.5*bet;
   if detail, str = ['BLACKJACK: +' int2str(s)]; end
elseif valP > 21
   s = -bet;
   if detail, str = ['BUST: ' int2str(s)]; end
elseif valD > 21
   s = bet;
   str = ['WIN: +' int2str(s)];
   if detail
      text(min(1.5*length(D)-4.5,2.75),-2.5,'BUST','fontsize',fs)
   end
elseif valD > valP
   s = -bet;
   if detail, str = ['LOSE: ' int2str(s)]; end
elseif valD < valP
   s = bet;
   if detail, str = ['WIN: +' int2str(s)]; end
else
   s = 0;
   if detail, str = 'PUSH'; end
end
if detail
   x = min(1.5*length(P)-4.5,2.75);
   if isequal(who,'Player')
      y = 2.5;
   else
      y = 0;
   end
   text(x,y,str,'fontsize',fs)
end


% ------------------------

function show(who,H)
% Displays one hand
switch who
   case 'Player', y = 2.5;
   case 'Split', y = 0;
   case 'Dealer', y = -2.5;
end
x = -4;
for j = 1:length(H)
   card(x,y,H(j),length(H))
   x = x + 1.5;
end


% ------------------------

function card(x,y,v,gray)
% card(x,y,v) plots v-th card at position (x,y).
z = exp((0:16)/16*pi/2*i)/16;
edge = [z+1/2+7*i/8 i*z-1/2+7*i/8 -z-1/2-7*i/8 -i*z+1/2-7*i/8 9/16+7*i/8];
pips = {'A','2','3','4','5','6','7','8','9','10','J','Q','K'};
if v <= 0
   % Hole card
   patch(real(edge)+x,imag(edge)+y,[0 0 2/3])
else
   fs = 20;
   s = ceil(v/13);
   v = mod(v-1,13)+1;
   x1 = x;
   if v==10, x1 = x1-.2; end
   offwhite = [1 1 1];
   if y == 0 & gray == 1, offwhite = [.75 .75 .75]; end
   patch(real(edge)+x,imag(edge)+y,offwhite)
   switch s
      case {1,4}, redblack = [0 0 0];
      case {2,3}, redblack = [2/3 0 0];
   end
   if ispc
      % PC has symbol font with card suits.
      text(x1-.2,y,pips{v},'fontname','courier','fontsize',fs, ...
         'fontweight','bold','color',redblack)
      text(x,y+.025,char(166+s),'fontname','symbol','fontsize',fs, ...
         'color',redblack)
   else
      text(x1-.1,y,pips{v},'fontname','courier','fontsize',fs, ...
         'fontweight','bold','color',redblack)
   end
end


% ------------------------

function val = bjbuttonclick(kase,basic,disable)
bjb = bjbuttons(kase);
if nargin == 3 & disable
   set(bjb(3),'enable','off')
end
if nargin >= 2
   set(bjb(basic),'fore','red')
end
while all(cell2mat(get(bjb,'val')) == 0)
   drawnow
end
val = find(cell2mat(get(bjb,'val')))-1;


% ------------------------

function bjb = bjbuttons(kase)

bjb = findobj(gcf,'style','toggle');
if isempty(bjb)
   for b = 3:-1:1
      bjb(b,1) = uicontrol('units','normal','style','toggle', ...
         'pos',[.95-.18*b .02 .16 .08],'fontweight','bold');
   end
end
set(bjb,'fore','black')
switch kase
   case {1,2}
      switch kase
         case 1
            fs = 12; y = .02; dy = .08;
         case 2
            fs = 10; y = .01; dy = .06;
      end
      for b = 1:3
         set(bjb(b),'pos',[.95-.18*b y .16 dy])
      end
      set(bjb,'val',0,'vis','on','enable','on','fontsize',fs)
      set(bjb(1),'string','Close')
      set(bjb(2),'string','Play')
      set(bjb(3),'string','Simulate')
      set(bjb(kase+1),'fore','red')
   case 'detail'
      set(bjb(1:2),'vis','on')
      set(bjb(3),'vis','off')
      for b = 1:3
         set(bjb(b),'pos',[.95-.18*b .02 .16 .08])
      end
      set(bjb,'val',0,'fontsize',12)
   case 'off'
      set(bjb,'vis','off')
   case 'split'
      set(bjb,'val',0,'fontsize',12)
      set(bjb(1),'string','Keep')
      set(bjb(2),'string','Split')
   case 'hit'
      set(bjb,'val',0,'vis','on','fontsize',12)
      set(bjb(1),'string','Stand')
      set(bjb(2),'string','Hit')
      set(bjb(3),'string','Double')
end


% ------------------------

function strat = hard(p,d)
% Strategy for hands without aces.
% strategy = hard(player's_total,dealer's_upcard)

% 0 = stand
% 1 = hit
% 2 = double down

persistent HARD
if isempty(HARD)
   n = NaN; % Not possible
   % Dealer shows:
   %      2 3 4 5 6 7 8 9 T A
   HARD = [ ...
      1   n n n n n n n n n n
      2   1 1 1 1 1 1 1 1 1 1
      3   1 1 1 1 1 1 1 1 1 1
      4   1 1 1 1 1 1 1 1 1 1
      5   1 1 1 1 1 1 1 1 1 1
      6   1 1 1 1 1 1 1 1 1 1
      7   1 1 1 1 1 1 1 1 1 1
      8   1 1 1 1 1 1 1 1 1 1
      9   2 2 2 2 2 1 1 1 1 1
     10   2 2 2 2 2 2 2 2 1 1
     11   2 2 2 2 2 2 2 2 2 2
     12   1 1 0 0 0 1 1 1 1 1
     13   0 0 0 0 0 1 1 1 1 1
     14   0 0 0 0 0 1 1 1 1 1
     15   0 0 0 0 0 1 1 1 1 1
     16   0 0 0 0 0 1 1 1 1 1
     17   0 0 0 0 0 0 0 0 0 0
     18   0 0 0 0 0 0 0 0 0 0
     19   0 0 0 0 0 0 0 0 0 0
     20   0 0 0 0 0 0 0 0 0 0];
end
strat = HARD(p,d);


% ------------------------

function strat = soft(p,d)
% Strategy array for hands with aces.
% strategy = soft(player's_total,dealer's_upcard)

% 0 = stand
% 1 = hit
% 2 = double down

persistent SOFT
if isempty(SOFT)
   n = NaN; % Not possible
   % Dealer shows:
   %      2 3 4 5 6 7 8 9 T A
   SOFT = [ ...
      1   n n n n n n n n n n
      2   1 1 2 2 2 1 1 1 1 1
      3   1 1 2 2 2 1 1 1 1 1
      4   1 1 2 2 2 1 1 1 1 1
      5   1 1 2 2 2 1 1 1 1 1
      6   2 2 2 2 2 1 1 1 1 1
      7   0 2 2 2 2 0 0 1 1 0
      8   0 0 0 0 0 0 0 0 0 0
      9   0 0 0 0 0 0 0 0 0 0];
end
strat = SOFT(p,d);


% ------------------------

function strat = pair(p,d)
% Strategy for splitting pairs
% strategy = pair(paired_card,dealer's_upcard)

% 0 = keep pair
% 1 = split pair

persistent PAIR
if isempty(PAIR)
   n = NaN; % Not possible
   % Dealer shows:
   %      2 3 4 5 6 7 8 9 T A
   PAIR = [ ...
      1   n n n n n n n n n n
      2   1 1 1 1 1 1 0 0 0 0
      3   1 1 1 1 1 1 0 0 0 0
      4   0 0 0 1 0 0 0 0 0 0
      5   0 0 0 0 0 0 0 0 0 0
      6   1 1 1 1 1 1 0 0 0 0
      7   1 1 1 1 1 1 1 0 0 0
      8   1 1 1 1 1 1 1 1 1 1
      9   1 1 1 1 1 0 1 1 0 0
     10   0 0 0 0 0 0 0 0 0 0
     11   1 1 1 1 1 1 1 1 1 1];
end
strat = PAIR(p,d);
