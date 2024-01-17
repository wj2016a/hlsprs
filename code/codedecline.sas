

Integrated healthy lifestyle, genetic risk, and cognitive decline 
/*NOTE:  The PROC MIXED Models */

%macro rate (data=, expgroup=, zscore=, time=, covar1=, covar2=);
proc mixed data=&data.  covtest noclprint;
	ods output solutionF=b1 lsmeans=b2;
	class id &expgroup.(ref='0');
	model &zscore.=&expgroup. &covar1. &covar2. &time. &time.*&expgroup./s cl ddfm=bw outpm=p;
	random int &time./subject=id g type=un;
       lsmeans &expgroup./pdiff diff cl;
	store out=MixedModel;
run;
%mend;


2)	 Integrated healthy lifestyle, genetic risk, and cognitive impairment
/*NOTE:  The Cox proportional hazard regression model*/
%macro HR (data=, expgroup=, pytime=, outcome=, covar1=, covar2=);
proc phreg data=&data.;
	ods output ParameterEstimates=ParameterEstimates_out;
       class &expgroup. &var2./param=ref ref=first;
       model &pytime.*&outcome.(0)=&expgroup. &covar1. &covar2./rl;
run;       
data ParameterEstimates_out (keep =Parameter ClassVal0  HR probchisq);
	   set  ParameterEstimates_out;
       HR=put (HazardRatio, 5.2)||"("|| put(HRLowerCL,5.2)||"-"|| put(HRUpperCL,5.2)||")";
run;
%mend;
