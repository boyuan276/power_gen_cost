# Power Generation Marginal Cost Estimation

## About

ECE 4800 final project on estimating power generation marginal cost.  
Authors: Bo Yuan and Jingwen Ye.

## Project workflow

### Price data preparation
   
We used ISONE hourly zonal price data in 2019. First, we calculated the sum of congestion cost and loss cost in each zone in each hour, which can be understood as the deviation of zonal price from the reference price. Second, we calculated the average deviation over all zones, and the average price over all zones. Third, we calculated the *CLFactor* defined as the ratio of average deviation over average price. We wanted to select the hours in which the effect of congestion and loss on price is small, so that we can ignore them and make the problem simpler. We selected the hours when the affect factor is less than 0.1, resulting 3533 out of 8760 hours. The data in these 3533 hours were used in the next steps.

**Related code**: hourlyZonalPriceISONE.mlx, importPriceISONE.m

**Related data directory**: 2019_LMP_ISONE

**Related output**: selDateTimePriceISONE.mat

### Bid data analysis
   
We used ISONE hourly bid and demand data in the selected hours in 2019. In each hour, each market participant can bid up to 10 segments of price and quantity pairs into the market. In each hour, we firstly ranked all the bids from low price to high price, and found the most expensive one that is need to serve the demand. Through this simple economic dispatch, we got the awarded/unawarded status of each bid, and we knew the total amount of awarded quantity of each market participant. We selected the top 10 most awarded market participants' data for further study. After that, we constructed residual demand curve of each selected market participants. We did that by ranking the bids from the high price to low price excluding the selected participant's bids. We used a Gaussian smoother to convert the stepwise residual demand curve to a smooth function, and then calculated the derivative of the residual demand function with respect to price. Finally, we used the equation proposed by **Wolak 2003** and **Bosco et al. 2012** to calculate the marginal cost of a market participant in that hour. The equation is `MC = p_e + RD/RD'`, where `MC` is the marginal cost, `p_e` is the market clearing price, `q` is the awarded amount, `RD` is the residual demand function, and `RD'` is the derivative of residual demand function with respect to price. we calculated marginal cost of each market participant in each hour.

**Related code**: hourlyBidISONE.mlx, hourlyMarginalCost.mlx, importBidISONE.m, hourlyQuantityMC.mlx, importDemandISONE.m, gaussianCurve.m, gaussianGradient.m

**Related data directory**: 2019_DAM_BID_ISONE, 2019_DEMAND_ISONE

**Related output**: marginal cost stored as csv files under model_output directory

### Marginal cost regression
   
Using the marginal cost data from Step 2, we did regression analysis to fit polynomial relation between marginal cost and generation quantity of selected market participants. We firstly excluded the market participants that always have the same marginal cost or always have the same quantity, resulting four selected market participants for study. Then, we cleaned the marginal cost data and removed outliers. We used MATLAB *polyfit* to fit quadratic and cubic relations and make plots of them. We also used *CVX* to do least square estimation of quadratic and cubic relations. The performance are similar. Because the performance of annual regression is not ideal, we conducted seasonal regression analysis.

**Related code**: MCCleaning.mlx, MCRegressionPolygit.mlx, MCRegressionCVX.mlx, MCRegressionSeasonal.mlx

**Related data directory**: model_output MC_XX files

**Related output**: cleanedQMCTables.mat, MCPolyfitResults.mat, MCCVXResults.mat, MCPolyfitQuad.mat, MCPolyfitCubic.mat, MCCVXQuad.mat, MCCVXCubic.mat, MCSeasonFitResults.mat, cleanedSel4QMCSeasons.mat, ...

### Market power analysis
   
We firstly estimated generation capacity of the market participants. Then, we calcualted Lerner Index, market share, and Residual Supply Index of selected four market participants to estimate their market power exercise. We also validated the price upper bound theory proposed by **Lin et al. 2019**.

**Related code**: capacityEstimation.mlx, capacitySummary.mlx, LernerIndex.mlx, ResidualSupplyIndex.mlx

**Related data directory**: model_output MC_XX files, 2019_DEMAND_ISONE, 2019_LMP_ISONE

**Related output**: parCapTable.mat, partCapTableSeasons.mat, LernerPolyfitQuad.mat, LernerPolyfitCubic.mat, LernerPolyfitSeasons.mat


## Installation
You will need MATLAB and CVX installed to run the program.

## License
MIT License
