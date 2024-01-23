
*Integrated healthy lifestyle, genetic risk, and rate of cognitive decline; 
/*NOTE:The PROC MIXED Models */
/*data: name of the input SAS datafile; 
  expgroup: integrated healthy lifestyle group;
  zscore:transformed Z score of total cognitive score,and six aspects of total cognitive score:
         orientation score,attention and calculation score,visual construction score,language score,naming score,and recall skills score;
  covar1:set one of related covariates adjusted in linear mixed-effects models; 
  covar2:set two of related covariates adjusted in linear mixed-effects models;
  time: variable of follow-up time;
*/

%macro rate (data=, expgroup=, zscore=, time=, covar1=, covar2=);
proc mixed data=&data. covtest noclprint;
	ods output solutionF=b1 lsmeans=b2;
	class id &expgroup.(ref='0');
	model &zscore.=&expgroup. &covar1. &covar2. &time. &time.*&expgroup./s cl ddfm=bw outpm=p;
	random int &time./subject=id g type=un;
    lsmeans &expgroup./pdiff diff cl;
	store out=MixedModel;
run;
%mend;


*Integrated healthy lifestyle, genetic risk, and risk of cognitive impairment;
/*NOTE:The Cox proportional hazard regression model*/
/*data: name of the input SAS datafile; 
  expgroup: integrated healthy lifestyle group;
  pytime: follow-up time of incident of cognitive impairment; 
  outcome: incident of cognitive impairment;
  covar1:set one of related covariates adjusted in Cox proportional hazard regression model; 
  covar2:set two of related covariates adjusted in Cox proportional hazard regression model;
*/

%macro HR (data=, expgroup=, pytime=, outcome=, covar1=, covar2=);
/*Step1: Testing the proportional hazard assumption in Cox models*/
proc phreg data=&data.;
    model &pytime.*&outcome.(0)=&expgroup. &covar1. &covar2./rl;
    output out=res ressch=sch;
run;  
proc sgplot data=res;
	scatter x=&pytime. y=sch;
run;
proc corr data=res;
	var &pytime. sch;
run;

/*Step2: Estimates of hazard ratios and 95% confidence interval*/
proc phreg data=&data.;
	ods output ParameterEstimates=ParameterEstimates_out;
    class &expgroup. &covar2./param=ref ref=first;
    model &pytime.*&outcome.(0)=&expgroup. &covar1. &covar2./rl;
run;  
 
data ParameterEstimates_out (keep =Parameter ClassVal0  HR probchisq);
	set  ParameterEstimates_out;
    HR=put (HazardRatio, 5.2)||"("|| put(HRLowerCL,5.2)||"-"|| put(HRUpperCL,5.2)||")";
run;
%mend;
