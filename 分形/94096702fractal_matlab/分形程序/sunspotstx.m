% SUNSPOTSTX  Updated version of toolbox/matlab/demos/sunspots.m

% For centuries people have noted that the face of the sun is not
% constant or uniform in appearance, but that darker regions appear
% at random locations on a cyclical basis.  This activity is correlated
% with weather and other economically significant terrestrial phenomena.
% In 1848, Rudolf Wolfer proposed a rule that combined the number and
% size of these sunspots into a single index.  Using archival records,
% astronomers have applied Wolfer's rule to determine sunspot activity
% back to the year 1700.  Today the sunspot index is measured by many
% astronomers and the worldwide distribution of the data is coordinated
% by the Solar Influences Data Center at the Royal Observatory of Belgium.
% 
% The text file sunspot.dat in the matlab/demos directory has two columns
% of numbers.  The first column is the years from 1700 to 1987 and the
% second column is the average Wolfer sunspot number for each year.

    load sunspot.dat
    t = sunspot(:,1)';
    wolfer = sunspot(:,2)';
    n = length(wolfer);

% There is a slight upward trend to the data.  A least squares fit
% gives the trend line.

    c = polyfit(t,wolfer,1);
    trend = polyval(c,t);
    plot(t,[wolfer; trend],'-',t,wolfer,'k.')
    xlabel('year')
    ylabel('Wolfer index')
    title('Sunspot index with linear trend')
    pause
    
% You can definitely see the cyclic nature of the phenomenon.
% The peaks and valleys are a little more than 10 years apart.
% Now, subtract off the linear trend and take the finite Fourier transform.

    y = wolfer - trend;
    Y = fft(y);

% The vector |Y|.^2^2 is the power in the signal.
% A plot of power versus frequency is a periodogram.
% We prefer to plot |Y|, rather than |Y|.^2, because the
% scaling is not so exaggerated.
% The sample rate for this data is one observation per year,
% so the frequency #f# has units of cycles per year.

    Fs = 1;  % Sample rate
    f = (0:n/2)*Fs/n;
    pow = abs(Y(1:n/2+1));
    pmax = 5000;
    plot([f; f],[0*pow; pow],'c-', f,pow,'b.', ...
       'linewidth',2,'markersize',16)
    axis([0 .5 0 pmax])
    xlabel('cycles/year')
    ylabel('power')
    title('Periodogram')
    pause
    
% The maximum power occurs near frequency = 0.09 cycles/year.
% We would like to know the corresponding period in years/cycle.
% Let's zoom in on the plot and use the reciprocal of frequency
% to label the x-axis.

    k = 0:44;
    f = k/n;
    pow = pow(k+1);
    plot([f; f],[0*pow; pow],'c-',f,pow,'b.', ...
       'linewidth',2,'markersize',16)
    axis([0 max(f) 0 pmax])
    k = 2:3:41;
    f = k/n;
    period = 1./f;
    periods = sprintf('%5.1f|',period);
    set(gca,'xtick',f)
    set(gca,'xticklabel',periods)
    xlabel('years/cycle')
    ylabel('power')
    title('Periodogram detail')
    
% As expected, there is a very prominent cycle with a length of
% about 11.1 years.  This shows that over the last 300 years,
% the period of the sunspot cycle has been slightly over 11 years.
