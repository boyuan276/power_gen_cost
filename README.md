# Power Generation Cost Estimation
ECE 4800 final project on estimating power generation cost curves.
Bo Yuan and Jingwen Ye Cooperate.

## Project to-do list
1. Price data preparation
   Using **zonal price data** in folder **2019_DAM_LBMP_Zonal**, we want to find hours in which **loss** cost and **congestion** cost are low so that we can safely ignore the effects of loss and congestion on the bidding behavior of market participants. First, calculate **total marginal cost of loss** and **total marginal cost of congestion** in NYS by adding up the data in each hour. Second, show the distribution of **total marginal cost of loss** and **total marginal cost of congestion**, and find the hours in which the total costs are relatively low (based on the lost one third of the data or some other statistics). Third, output the resultant hours and obtain the corresponding **price at the reference bus** in the folder **2019_DAM_LBMP_Reference_Bus**. Now we have the hours and prices that we are interested in, we can find the load demand data in these hours in Step 2.
2. Load data preparation
   We need three types of load quantities in each hour, **total demand Q**, **residual demand DR**, and **bid demand of a specific facility**. We use the data in folder **EPA_AMPD** for this calculations. The **total demand Q** can be calculated by adding up the **gross load** of all the generators in each hour. The **residual demand DR** can be calculated by adding up the **gross load** of all the generators except the generators owned by a particular facility. The **bid demand of a specific facility** can be calculated by adding up the **gross load** of the generators owned by a particular facility. Note that we only need to calculate these quantities in the hours **selected by step 1**.
3. Cost function estimation
   Using the method proposed by *Wolak et al*, calcualte estimation of power generation cost of the facilities. To be elaborated ...
4. Results analysis
   The anticipate results need to show that the power generation cost functions are generally convex. Different types of facility's cost function should have different features. To be elaborated ...