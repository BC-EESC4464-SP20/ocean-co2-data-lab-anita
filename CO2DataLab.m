%% Add your names in a comment here at the beginning of the code!
%Anita Gee Scott Rasmussen
% Instructions: Follow through this code step by step, while also referring
% to the overall instructions and questions from the lab assignment sheet.

%% 1. Read in the monthly gridded CO2 data from the .csv file
% The data file is included in your repository as �LDEO_GriddedCO2_month_flux_2006c.csv�
% Your task is to write code to read this in to MATLAB
% Hint: you can again use the function �readtable�, and use your first data lab code as an example.
filename = 'LDEO_GriddedCO2_month_flux_2006c.csv';
CO2data = readtable(filename);

%% 2a. Create new 3-dimensional arrays to hold reshaped data
%Find each unique longitude, latitude, and month value that will define
%your 3-dimensional grid
longrid = unique(CO2data.LON); %finds all unique longitude values
 latgrid = unique(CO2data.LAT);
 monthgrid = unique(CO2data.MONTH);%<-- following the same approach, find all unique latitude values
 %<-- following the same approach, find all unique months

%Create empty 3-dimensional arrays of NaN values to hold your reshaped data
    %You can make these for any variables you want to extract - for this
    %lab you will need PCO2_SW (seawater pCO2) and SST (sea surface
    %temperature)
S = NaN(length(longrid),length(latgrid),length(monthgrid));%<--
%<--

%% 2b. Pull out the seawater pCO2 (PCO2_SW) and sea surface temperature (SST)
%data and reshape it into your new 3-dimensional arrays
for i = 1:height(CO2data)
    lat = CO2data.LAT(i);
    long = CO2data.LON(i);
    month = CO2data.MONTH(i);
    sst = CO2data.SST(i);
    d=find(long ==longrid);
    e=find(lat == latgrid);
    f=find(month == monthgrid);  
    S(d,e,f) = sst;
end
S2 = NaN(length(longrid),length(latgrid),length(monthgrid));
for i = 1:height(CO2data)
    lat = CO2data.LAT(i);
    long = CO2data.LON(i);
    month = CO2data.MONTH(i);
    pco2 = CO2data.PCO2_SW(i);
    g=find(long ==longrid);
    h=find(lat == latgrid);
    j=find(month == monthgrid);  
    S2(g,h,j) = pco2;
end

%% 3a. Make a quick plot to check that your reshaped data looks reasonable
%Use the imagesc plotting function, which will show a different color for
%each grid cell in your map. Since you can't plot all months at once, you
%will have to pick one at a time to check - i.e. this example is just for
%January
figure(1)
imagesc(S(:,:,1))
figure(2)
imagesc(S2(:,:,1))

%% 3b. Now pretty global maps of one month of each of SST and pCO2 data.
%I have provided example code for plotting January sea surface temperature
%(though you may need to make modifications based on differences in how you
%set up or named your variables above).

figure(3); clf
worldmap world
contourfm(latgrid, longrid, S(:,:,1)','linecolor','none');
colorbar
geoshow('landareas.shp','FaceColor','black')
title('January Sea Surface Temperature (^oC)')

%Check that you can make a similar type of global map for another month
%and/or for pCO2 using this approach. Check the documentation and see
%whether you can modify features of this map such as the contouring
%interval, color of the contour lines, labels, etc.
figure(4); clf
worldmap world
contourfm(latgrid, longrid, S2(:,:,1)','linecolor','none');
colorbar
geoshow('landareas.shp','FaceColor','black')
title('January pco2')
%<--

%% 4. Calculate and plot a global map of annual mean pCO2
annmean = nanmean(S2,3)
figure(5); clf
worldmap world
contourfm(latgrid, longrid, annmean','linecolor','none');
colorbar
geoshow('landareas.shp','FaceColor','black')
title('Annual Mean pco2')

 



%% 5. Calculate and plot a global map of the difference between the annual mean seawater and atmosphere pCO2
%<--
filename = '2009atmCO2data.xlsx';
atmCO2data = readtable(filename);

annmeanatm = mean(atmCO2data.CO2_ppm_)
diff5= annmean-annmeanatm

figure(6); clf
worldmap world
contourfm(latgrid, longrid, diff5','linecolor','none');
colorbar
geoshow('landareas.shp','FaceColor','black')
title('Annual Mean between seawater and atmospheric pco2')

%% 6. Calculate relative roles of temperature and of biology/physics in controlling seasonal cycle

annmeantemp = nanmean(S,3)
annmeantemprep= repmat(annmeantemp,1,1,12)
bioaffct= S2.*exp(0.0423.*(annmeantemprep-S))

annmean_rep= repmat(annmean,1,1,12)
tempaffct= annmean_rep.*exp(0.0423.*(S-annmeantemprep))


%% 7. Pull out and plot the seasonal cycle data from stations of interest
%Do for BATS, Station P, and Ross Sea (note that Ross Sea is along a
%section of 14 degrees longitude - I picked the middle point)
latbats=abs(latgrid-32.5)
[M,I]=min(latbats)

lonbats=abs(longrid-64.1)
[M,I]=min(lonbats)
%% 8. Reproduce your own versions of the maps in figures 7-9 in Takahashi et al. 2002
% But please use better colormaps!!!
% Mark on thesese maps the locations of the three stations for which you plotted the
% seasonal cycle above

%<--
