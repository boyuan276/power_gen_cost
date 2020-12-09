# Power Generation Marginal Cost Estimation

## About

ECE 4800 final project on estimating power generation marginal cost.  
Authors: Bo Yuan and Jingwen Ye.

## Project workflow

### Price data preparation
   
We use ISONE hourly zonal price data in 2019. First, calculate the sum of congestion cost and loss cost in each zone in each hour, which can be understood as the deviation of zonal price from the reference price. Second, calculate the average deviation over all zones, and the average price over all zones. Third, calculate the *affect factor* defined as the ratio of average deviation over average price. We want to select the hours in which the effect of congestion and loss on price is small, so that we can ignore them and make the problem simpler. We selecte the hours when the affect factor is less than 0.1, resulting 3533 out of 8760 hours. The data in these 3533 hours are used in the next steps.

**Related code**: hourlyZonalPriceISONE.mlx, importPriceISONE.m

**Related data directory**: 2019_LMP_ISONE

**Related output**: selDateTimePriceISONE.mat

### Bid data analysis
   
We use ISONE hourly bid and demand data in the selected hours in 2019. In each hour, each market participant can bid up to 10 segments of price and quantity pairs into the market. In each hour, we firstly ranked all the bids from low price to high price, and find the most expensive one that is need to serve the demand. Through this simple economic dispatch, we get the awarded/unawarded status of each bid, and we know the total amount of awarded quantity of each market participant. We select the top 10 most awarded market participants' data for further study. After that, we construct residual demand curve of each selected market participants. We do that by ranking the bids from the high price to low price excluding the selected participant's bids. We use a Gaussian smoother to convert the stepwise residual demand curve to a smooth function, and then calculate the derivative of the residual demand function with respect to price. Finally, we use the equation proposed by **Wolak 2003** and **Bosco et al 2012** to calculate the marginal cost of a market participant in that hour. The equation is `MC = p_e + (q - x)/RD'`, where `MC` is the marginal cost, `p_e` is the market clearing price, `q` is the awarded amount, `x` is the contracted amount in forward market, and `RD'` is the derivative of residual demand function. Because we don't have the information about contracted amount in forward market, we negelect it and remove it from the equation. Using this equation, we can calculate marginal cost of each market participant in each hour.

**Related code**: hourlyBidISONE.mlx, hourlyMarginalCost.mlx, importBidISONE.m, hourlyQuantityMC.mlx, importDemandISONE.m, gaussianCurve.m, gaussianGradient.m

**Related data directory**: 2019_DAM_BID_ISONE, 2019_DEMAND_ISONE

**Related output**: marginal cost stored as csv files under model_output directory

### Marginal cost regression
   
Using the marginal cost data from Step 2, we do regression analysis to fit polynomial relation between marginal cost and generation quantity of selected market participants. We firstly exclude the market participants that always have the same marginal cost or always have the same quantity, resulting eight selected market participants for study. Then, we cleaned the marginal cost data and removed outliers. We use MATLAB *polyfit* to fit quadratic and cubic relations and make plots of them. We also used CVX to do least square estimation of quadratic and cubic relations. The performance are similar.

**Related code**: MCCleaning.mlx, MCRegressionPolygit.mlx, MCRegressionCVX.mlx

**Related data directory**: model_output

**Related output**: cleanedQMCTables.mat, MCPolyfitResults.mat, MCCVXResults.mat, MCPolyfitQuad.mat, MCPolyfitCubic.mat, MCCVXQuad.mat, MCCVXCubic.mat

### Results analysis
   
   To be continued ...

## Installation
You will need MATLAB and CVX installed to run the program.

## License
MIT License
