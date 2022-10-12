
# R code for Gillespie simulations

## crawlby_funs.R

Convenient functions used by other scripts.

## crawlby_simulations.R

Compute and save trajectories (in trajset.RData) so the residence time calculation can be separately run.

## combine_trajsets.R

Large numbers of Gillespie/adaptive-tau simulations are time consuming so we run sets of realizations in parallel.  This script combines the output from several such runs.

## crawlby_restimes.R

Load trajset.RData and compute residence times from the saved trajectories.  Save results in restimeset.RData.

## crawlby_get_stats.R

Load restimeset.RData and extract summary stats associated with residence times (region,sigma,ncycles,mean,sd,cycletime).

## crawlby_figure6.R

Create a seqence of summary plots from a collection of simulations.  (This was initially written to help with "figure 6" but Figure 6 in the final paper is unrelated.)

## crawlby_plot_restimes.R

Load trajset.RData and restimeset.RData and create diagnostic plots.

