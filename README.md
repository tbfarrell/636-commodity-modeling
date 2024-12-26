# 636-commodity-modeling
attempts/ideas at modeling sugar &amp; pumpkin commodity pricing ohh god please take mercy on us

12/26/2024

Hello there! Trevor Farrell speaking. If you're reading this, that probably
means you've taken an interest in operating my model. Allow me to describe
the general approach for enabling its implementation.

In general, the required steps for predictive analysis are to a) initalize the 
data by running lord_commodity_(type) before b) running the corresponding 
predictive analysis by running the corresponding MJ_Lord_(type)

Example:

Step 1: Open MATLAB
Step 2: Open repo to containing the following:

	lord_commodity_pumpkin.m
	consumptionECM.m
	productionDynamics.m
	forecastPrice.m

	MJ_Lord_pumpkin.m

	Cut_stats.xlsx

Step 3: Run lord_commodity_pumpkin.m to initialize the data from Cut_stats.xlsx
Step 4: Run MJ_Lord_pumpkin.m to run predictive analysis n months ago for m
months in advance. 

Parameters are determined through statistical analysis and are open to 
variation. Similarly, there are a variety of truncated data sets as .xlsx
files to be used for a variety of applications. 

Remember to run lord_commodity_(type) to re-initialize data sets each
time we wish to iterate predictive analysis. 

Enjoy!
