
libname data "E:\CLHLS\data";
options nofmterr;
run;

/*Step1:input the original data*/
/*The datasets used and analyzed of this study are available from Peking University Open Research Data website:https://opendata.pku.edu.cn/dataverse/CHADS*/

proc import out= data.b1998                                                                                                                                                                                                                                       
             datafile="E:\CLHLS\data\clhls_1998_2018_longitudinal_dataset_released_version1.sav"                                                                
             dbms=sav replace;     
run;
proc import out= data.b2000                                                                                                                                                                                                                                    
             datafile="E:\CLHLS\data\clhls_2000_2018_longitudinal_dataset_released_version1.sav"                                                                
             dbms=sav replace;     
run;
proc import out= data.b2002                                                                                                                                                                                                                                      
             datafile="E:\CLHLS\data\clhls_2002_2018_longitudinal_dataset_released_version1.sav"                                                                
             dbms=sav replace;     
run;
proc import out= data.b2005                                                                                                                                                                                                                                     
             datafile="E:\CLHLS\data\clhls_2005_2018_longitudinal_dataset_released_version1.sav"                                                                
             dbms=sav replace;     
run;
proc import out= data.b2008                                                                                                                                                                                                                                       
             datafile="E:\CLHLS\data\clhls_2008_2018_longitudinal_dataset_released_version1.sav"                                                                
             dbms=sav replace;     
run;
proc import out= data.b2011                                                                                                                                                                                                                                       
             datafile="E:\CLHLS\data\clhls_2011_2018_longitudinal_dataset_released_version1.sav"                                                                
             dbms=sav replace;     
run;
proc import out= data.b2014                                                                                                                                                                                                                                      
             datafile="E:\CLHLS\data\clhls_2014_2018_longitudinal_dataset_released_version1.sav"                                                                
             dbms=sav replace;     
run;
proc import out= data.b2018                                                                                                                                                                                                                                        
             datafile="E:\CLHLS\data\clhls_2018_cross_sectional_dataset_15874.sav"                                                                
             dbms=sav replace;     
run;

/*Step2:data cleaning*/
/*Healthy lifestyle score and cognition score calculation*/
/*Taking 2008wave for example*/

%macro clean(input=,output=);
data &output.;
	set &input.;

	/*smoking*/
    if d71=2 & d72=2 then smoke=0;
		else if d71=2 & d72=1 then smoke=1;
			else if d71=1 then smoke=2;
	label smoke='smoking£¨0=never smoking 1=past 2=current£©';

	/*drinking*/
	if d81=2 & d82=2 then drink=0;
		else if d81=2 & d82=1 then drink=1;
			else if d81=1 then drink=2;
	label drink='drinking£¨0=never drinking 1=past 2=current)';

	/*physical activity*/
    if d91=1 then currentpa=2;   else if d91=9 then currentpa=.;   else currentpa=0; 
	if d11a in (4,5) then sad1=0;else if d11a=3 then sad1=1;else if d11a in (1,2) then sad1=2;else sad1=.;
	if d11b in (4,5) then sad2=0;else if d11b=3 then sad2=1;else if d11b in (1,2) then sad2=2;else sad2=.;
	if d11c in (4,5) then sad3=0;else if d11c=3 then sad3=1;else if d11c in (1,2) then sad3=2;else sad3=.;
	if d11d in (4,5) then sad4=0;else if d11d=3 then sad4=1;else if d11d in (1,2) then sad4=2;else sad4=.;
	if d11e in (4,5) then sad5=0;else if d11e=3 then sad5=1;else if d11e in (1,2) then sad5=2;else sad5=.;
	if d11f in (4,5) then sad6=0;else if d11f=3 then sad6=1;else if d11f in (1,2) then sad6=2;else sad6=.;
	if d11g in (4,5) then sad7=0;else if d11g=3 then sad7=1;else if d11g in (1,2) then sad7=2;else sad7=.;
	if d11h in (4,5) then sad8=0;else if d11h=3 then sad8=1;else if d11h in (1,2) then sad8=2;else sad8=.;
	pasum=currentpa+sad1+sad2+sad3+sad4+sad5+sad6+sad7+sad8;

	/*diet score*/
	if d31=4     then fruit=0;  else if d31=3   then fruit=1;   else if d31 in (1,2) then fruit=2;else fruit=.;
	if d32=4     then veget=0;  else if d32=3   then veget=1;   else if d32 in (1,2) then veget=2;else veget=.;
    if d4bean2 in (4,5) then bean=0;   else if d4bean2=3  then bean=1;  else if d4bean2 in (1,2) then bean=2;else bean=.; 
    if d4fish2 in (4,5) then fish=0;   else if d4fish2=3 then fish=1;   else if d4fish2 in (1,2) then fish=2;else fish=.; 
    if d4meat2 in (4,5) then meat=0;   else if d4meat2=3 then meat=1;   else if d4meat2 in (1,2) then meat=2;else meat=.; 
    if d4egg2  in (4,5) then egg=0;    else if d4egg2=3  then egg=1;    else if d4egg2  in (1,2) then egg=2;else egg=.; 
    if d4veg2  in (4,5) then saltveg=0;else if d4veg2=3  then saltveg=1;else if d4veg2  in (1,2) then saltveg=2;else saltveg=.; 
    if d4tea2  in (4,5) then tea=0;    else if d4tea2=3  then tea=1;    else if d4tea2  in (1,2) then tea=2;else tea=.; 
    if d4garl2 in (4,5) then garl=0;   else if d4garl2=3 then garl=1;   else if d4garl2 in (1,2) then garl=2;else garl=.; 
    dietsum=fruit+veget+bean+fish+meat+egg+(2-saltveg)+garl+tea;

    /*covariate*/
	label a1='sex(1=male 2=female)';

	/*educational attainment (years of schooling completed <1 year, 1¨C6 years, or >6 years)*/
    if f1 in (88,99) then edu=.;
		else if .<f1<1 then edu=0;
			else if 1<=f1<=6 then edu=1;
				else if f1>6 then edu=2;
	label edu='educational attainment(0=<1year 1=1-6years 2=>6 years)';

	/*area of residence (urban, rural)*/
    if residenc in (1,2) then urban=1;
		else if residenc=3 then urban=2;
	label urban='urban(1=urban 2=rural)';

	/*current marital status (in marriage, not in marriage)*/
	if f41 in(1,2) then married=1;
		else if f41 in (8,9) then married=.;
			else married=0;
	label married='married status(1=yes 0=no)';

	/*occupation:divided into 4 groups*/
	*agriculture/forestry/husbandry/fishery;
    *commercial, service, industrial worker/self-employed;
    *professional/governmental/managerial personnel;
    *houseworker/never worked/other;
	if f2=4 then job=0;
		else if f2 in (2,3) then job=1;
			else if f2 in (0,1,6) then job=2;
				else if f2 in (5,7,8) then job=3;
					else if f2=9 then job=.;

	/*source of income (independent, dependent)*/
	if f31=99 then income=.
		else if f31 in (1,7) then income=1;
			else income=0;
	label income='source of income(1=yes 0=no)';

	/*cognitive score calculation and its respective six dimensions*/
	*orientation;
    if c11=9  then c11_new=.; else if c11=8  then c11_new=0; else c11_new=c11;
	if c12=9  then c12_new=.; else if c12=8  then c12_new=0; else c12_new=c12;
    if c13=9  then c13_new=.; else if c13=8  then c13_new=0; else c13_new=c13;
    if c14=9  then c14_new=.; else if c14=8  then c14_new=0; else c14_new=c14;
    if c15=9  then c15_new=.; else if c15=8  then c15_new=0; else c15_new=c15;
	*naming foods;
    if c16=99 then c16_new=.; else if c16=88 then c16_new=0; else c16_new=c16;
	if c16_new>7 then c16_new=7;
	*registration of three words recall;
	if c21a=9 then c21a_new=.;else if c21a=8 then c21a_new=0;else c21a_new=c21a;               
	if c21b=9 then c21b_new=.;else if c21b=8 then c21b_new=0;else c21b_new=c21b;               
	if c21c=9 then c21c_new=.;else if c21c=8 then c21c_new=0;else c21c_new=c21c;  
    if c41a=9 then c41a_new=.;else if c41a=8 then c41a_new=0;else c41a_new=c41a;
    if c41b=9 then c41b_new=.;else if c41b=8 then c41b_new=0;else c41b_new=c41b;
    if c41c=9 then c41c_new=.;else if c41c=8 then c41c_new=0;else c41c_new=c41c;
    *attention and calculation;
	if c31a=9 then c31a_new=.;else if c31a=8 then c31a_new=0;else c31a_new=c31a;
	if c31b=9 then c31b_new=.;else if c31b=8 then c31b_new=0;else c31b_new=c31b;
	if c31c=9 then c31c_new=.;else if c31c=8 then c31c_new=0;else c31c_new=c31c;
	if c31d=9 then c31d_new=.;else if c31d=8 then c31d_new=0;else c31d_new=c31d;
	if c31e=9 then c31e_new=.;else if c31e=8 then c31e_new=0;else c31e_new=c31e;
    *copy a figure;
	if c32=9  then c32_new=.; else if c32=8  then c32_new=0; else c32_new=c32;
	*language;
    if c51a=9 then c51a_new=.;else if c51a=8 then c51a_new=0;else c51a_new=c51a;
    if c51b=9 then c51b_new=.;else if c51b=8 then c51b_new=0;else c51b_new=c51b;
	if c52=9  then c52_new=.; else if c52=8  then c52_new=0; else c52_new=c52;
	if c53a=9 then c53a_new=.;else if c53a=8 then c53a_new=0;else c53a_new=c53a;
	if c53b=9 then c53b_new=.;else if c53b=8 then c53b_new=0;else c53b_new=c53b;
	if c53c=9 then c53c_new=.;else if c53c=8 then c53c_new=0;else c53c_new=c53c;

    *cognitive score calculation;
    mmse=sum(c11_new,c12_new,c13_new,c14_new,c15_new,c16_new, c21a_new,c21b_new,c21c_new,c41a_new,c41b_new,c41c_new,c31a_new,c31b_new,c31c_new,c31d_new,c31e_new,c32_new,c51a_new,c51b_new,c52_new,c53a_new,c53b_new,c53c_new);
	mmse_null=c11_new+c12_new+c13_new+c14_new+c15_new+c16_new+c21a_new+c21b_new+c21c_new+c41a_new+c41b_new+c41c_new+c31a_new+c31b_new+c31c_new+c31d_new+c31e_new+c32_new+c51a_new+c51b_new+c52_new+c53a_new+c53b_new+c53c_new;

    *five points,four points for time orientation and one point for place orientation;
    c_orientation=sum(c11_new,c12_new,c13_new,c14_new,c15_new);
    *five points,mentally subtracting 3 iteratively from 20;
	c_compute=sum(c31a_new,c31b_new,c31c_new,c31d_new,c31e_new);
    *one point,copy a figure;
	c_visual=c32_new;
    *six point,two points for naming objectives,one point for repeating a sentence,three points for listening and following directions;
	c_language=sum(c51a_new,c51b_new,c52_new,c53a_new,c53b_new,c53c_new);
    *seven points,response naming foods:naming as many kinds of food as possible in one minute;
	c_name=c16_new;
	*six points repeat three words;
    c_recall=sum(c21a_new,c21b_new,c21c_new,c41a_new,c41b_new,c41c_new);
run;
%mend;
%macro1(input=data.b2008,output=b2008);
%macro1(input=data.b2011,output=b2011)
%macro1(input=data.b2014,output=b2014)
%macro1(input=data.b2018,output=b2018)

/*Step3:combination of baseline data of 2008 wave and the following visit*/
/*Cognition score and its respective six dimensions at baseline and each follow-up visit, Wide data*/
/*One row per subject*/

/*Baseline of 2008wave*/
data b2008_0;
	set b2008;
	if substrn(id,7,2) in (08,09);
run;

/*First follow-up for 2008wave*/
data b2008_1;
	set b2011;
	if substrn(id,7,2) in (08,09);
run;
%rename(indata=b2008_1,outdata=b2008_1,prefix=f1_,ID=id);

/*Second follow-up for 2008wave*/
data b2008_2;
	set b2014;
	if substrn(id,7,2) in (08,09);
run;
%rename(indata=b2008_2,outdata=b2008_2,prefix=f2_,ID=id);

/*Third follow-up for 2008wave*/
data b2008_3;
	set b2018;
	if substrn(id,7,2) in (08,09);
run;
%rename(indata=b2008_3,outdata=b2008_3,prefix=f3_,ID=id);

/*Combine the baseline and follow-up data*/
proc sort data=b2008_0;by id;run;
proc sort data=b2008_1;by id;run;
proc sort data=b2008_2;by id;run;
proc sort data=b2008_3;by id;run;

data combine2008;
	merge b2008_0(in=a) b2008_1-b2008_3;
	by id;
	if a=1 then output;
run;

data combine2008;
	set combine2008;
	if substrn(id,7,2) in (08,09) then do;
		array mmsemiss5[4] mmse	f1_mmse	f2_mmse	f3_mmse;
		do i=1 to dim(mmsemiss5);
		if mmsemiss5(i)=. then j+1;
		end;
	    k=j-lag(j);
		if j=0 and k=. then k=0;
		if k=. then k=j;
	    label k="number of missing value";
		if k=3 then delete;
    end;
run;


/*Step4:similar methods were used to 1998wave, 2000wave,2002wave,2005wave,2011wave,2014wave,
  seven database were generated,namely combine1998 combine2000 combine2002 combine2005 combine2008 combine2011 combine2014,
  set the above datasets to create a new dataset "dcombine"*/
data data.dcombine;
	set combine1998 combine2000 combine2002 combine2005 combine2008 combine2011 combine2014;
run;

/*Step5:input the weighted genetic risk score*/
/*The genetic data underlying this study cannot be shared publicly due to the privacy of individuals that participated in the study, 
which will be shared on reasonable request to the corresponding author (Prof. Shi: shixm@chinacdc.cn or Associate Prof. Lv: lvyuebin@nieh.chinacdc.cn)*/
proc import out=prs 
            datafile= "E:\CLHLS\data\mmseprs.csv" 
            dbms=csv replace;
            getnames=yes;
            datarow=2; 
run;
%mergedata(data_main=data.dcombine,data_match=prs,data_out=data.dcombine_prs,id=id);

/*PRS categories:classified into low and high genetic risk categories based on a set of percentiles of the PRS to investigate the stratification of the PRS, 
using the following five classifications:
(1) low (bottom 50%) and high (top 50%); 
(2) low (bottom 60%) and high (top 40%); 
(3) low (bottom 70%) and high (top 30%); 
(4) low (bottom 80%) and high (top 20%); 
(5) low (bottom 90%) and high (top 10%). 
*/
proc univariate data=data.dcombine_prs;
    var mmseprs;
    output out=mmseprs_pct pctlpts=(50 60 70 80 90) pctlpre=p;
run;

/*Baseline MMSE score below the 10th percentile*/
proc univariate data=data.dcombine_prs;
    var mmse;
    output out=mmse_pct pctlpts=(10 20 30) pctlpre=p;
run;

data compute;
    if _N_=1 then set mmse_pct;
	set data.dcombine_prs;

	/*baseline MMSE score below the 10th percentile*/
	if mmse<p10 then mmselow10=1;
			else mmselow10=0;

	/*combined lifestyle score*/
	hls=smoke_s+drink_s+pa_s+diet_s;
    if hls in (0,1,2) then hlsg=0;
		else if hls =3 then hlsg=1;
				else hlsg=2;
	label hlsg='lifestyle group£¨0=0-2factors 1=3 factors 2=4 factors£©';

	/*combined lifestyle score using "never smoking" as a healthy lifestyle factor*/
	hlsnew=smoke_ss+drink_s+pa_s+diet_s;
    if hlsnew in (0,1,2) then hlsnewg=0;
		else if hlsnew =3 then hlsnewg=1;
				else hlsnewg=2;
	label hlsnewg='new lifestyle group£¨0=0-2factors 1=3 factors 2=4 factors£©';

	/*genetic risk group,low (bottom 50%) and high (top 50%)*/
	label q2prs="genetic risk (0=low genetic risk 1=high genetic risk)";
	/*joint association of genetic risk and lifestyle*/
	if q2prs=1 & hlsg=0 then groupc=0;
	if q2prs=1 & hlsg=1 then groupc=1;
	if q2prs=1 & hlsg=2 then groupc=2;
	if q2prs=0 & hlsg=0 then groupc=3;
	if q2prs=0 & hlsg=1 then groupc=4;
	if q2prs=0 & hlsg=2 then groupc=5;
run;



/*Step5:Integrated healthy lifestyle, genetic risk, and rate of cognitive decline;*/ 
/*data from the wide to long format*/

data compute_long;
	set compute;
	y_mmse_z=z_mmse;   y_mmse=mmse;   y_c_orientation_z=z_c_orientation;   y_c_orientation=c_orientation;   y_c_compute_z=z_c_compute;   y_c_compute=c_compute;   y_c_visual_z=z_c_visual;   y_c_visual=c_visual;   y_c_language_z=z_c_language;   y_c_language=c_language;   y_c_name_z=z_c_name;   y_c_name=c_name;   y_c_recall_z=z_c_recall;   y_c_recall=c_recall;   visit=b_py;  output;
	y_mmse_z=z_f1_mmse;y_mmse=f1_mmse;y_c_orientation_z=z_f1_c_orientation;y_c_orientation=f1_c_orientation;y_c_compute_z=z_f1_c_compute;y_c_compute=f1_c_compute;y_c_visual_z=z_f1_c_visual;y_c_visual=f1_c_visual;y_c_language_z=z_f1_c_language;y_c_language=f1_c_language;y_c_name_z=z_f1_c_name;y_c_name=f1_c_name;y_c_recall_z=z_f1_c_recall;y_c_recall=f1_c_recall;visit=f1_py; output;
	y_mmse_z=z_f2_mmse;y_mmse=f2_mmse;y_c_orientation_z=z_f2_c_orientation;y_c_orientation=f2_c_orientation;y_c_compute_z=z_f2_c_compute;y_c_compute=f2_c_compute;y_c_visual_z=z_f2_c_visual;y_c_visual=f2_c_visual;y_c_language_z=z_f2_c_language;y_c_language=f2_c_language;y_c_name_z=z_f2_c_name;y_c_name=f2_c_name;y_c_recall_z=z_f2_c_recall;y_c_recall=f2_c_recall;visit=f2_py; output;
	y_mmse_z=z_f3_mmse;y_mmse=f3_mmse;y_c_orientation_z=z_f3_c_orientation;y_c_orientation=f3_c_orientation;y_c_compute_z=z_f3_c_compute;y_c_compute=f3_c_compute;y_c_visual_z=z_f3_c_visual;y_c_visual=f3_c_visual;y_c_language_z=z_f3_c_language;y_c_language=f3_c_language;y_c_name_z=z_f3_c_name;y_c_name=f3_c_name;y_c_recall_z=z_f3_c_recall;y_c_recall=f3_c_recall;visit=f3_py; output;
	y_mmse_z=z_f4_mmse;y_mmse=f4_mmse;y_c_orientation_z=z_f4_c_orientation;y_c_orientation=f4_c_orientation;y_c_compute_z=z_f4_c_compute;y_c_compute=f4_c_compute;y_c_visual_z=z_f4_c_visual;y_c_visual=f4_c_visual;y_c_language_z=z_f4_c_language;y_c_language=f4_c_language;y_c_name_z=z_f4_c_name;y_c_name=f4_c_name;y_c_recall_z=z_f4_c_recall;y_c_recall=f4_c_recall;visit=f4_py; output;
	y_mmse_z=z_f5_mmse;y_mmse=f5_mmse;y_c_orientation_z=z_f5_c_orientation;y_c_orientation=f5_c_orientation;y_c_compute_z=z_f5_c_compute;y_c_compute=f5_c_compute;y_c_visual_z=z_f5_c_visual;y_c_visual=f5_c_visual;y_c_language_z=z_f5_c_language;y_c_language=f5_c_language;y_c_name_z=z_f5_c_name;y_c_name=f5_c_name;y_c_recall_z=z_f5_c_recall;y_c_recall=f5_c_recall;visit=f5_py; output;
	y_mmse_z=z_f6_mmse;y_mmse=f6_mmse;y_c_orientation_z=z_f6_c_orientation;y_c_orientation=f6_c_orientation;y_c_compute_z=z_f6_c_compute;y_c_compute=f6_c_compute;y_c_visual_z=z_f6_c_visual;y_c_visual=f6_c_visual;y_c_language_z=z_f6_c_language;y_c_language=f6_c_language;y_c_name_z=z_f6_c_name;y_c_name=f6_c_name;y_c_recall_z=z_f6_c_recall;y_c_recall=f6_c_recall;visit=f6_py; output;
	y_mmse_z=z_f7_mmse;y_mmse=f7_mmse;y_c_orientation_z=z_f7_c_orientation;y_c_orientation=f7_c_orientation;y_c_compute_z=z_f7_c_compute;y_c_compute=f7_c_compute;y_c_visual_z=z_f7_c_visual;y_c_visual=f7_c_visual;y_c_language_z=z_f7_c_language;y_c_language=f7_c_language;y_c_name_z=z_f7_c_name;y_c_name=f7_c_name;y_c_recall_z=z_f7_c_recall;y_c_recall=f7_c_recall;visit=f7_py; output;
run;

/*Step6:The PROC MIXED Models among overall participants*/
/*data: name of the input SAS datafile; 
  expgroup: integrated healthy lifestyle group;
  zscore:transformed Z score of total cognitive score,and six aspects of total cognitive score:
         orientation score,attention and calculation score,visual construction score,language score,naming score,and recall skills score;
  covar1:set one of related covariates adjusted in linear mixed-effects models; 
  covar2:set two of related covariates adjusted in linear mixed-effects models;
  time: variable of follow-up time;*/

/*To account for the non-linear relationship, quadratic terms of time were included in the multivariate model*/

%macro decline(data=, expgroup=, zscore=, time=, covar1=, covar2=);
proc mixed data=&data. covtest noclprint;
	ods output solutionF=b1 lsmeans=b2;
	class id &cov1. &expgroup.(ref='0');
	model &zscore.=&expgroup. &covar1. &covar2. &time. &time.*&expgroup./s cl outpred=pred outpm=predm;
	random int &time./subject=id g type=un;
    lsmeans &expgroup./pdiff diff cl;
	store out=MixedModel;
run;
proc plm restore=MixedModel NOCLPRINT;/*use item store to create fit plots*/
   effectplot slicefit(x=&time. sliceby=&expgroup.)/clm;  
   ods output SliceFitPlot=predplot_&name.;
run;  

data output1(keep=effect1 group1 mean1 pvalue1 lower1 upper1 mmse_int_ci);
	set b1;
	if Effect="&expgroup.*&time." or Effect="&expgroup.";
    effect1=effect;
	group1=&expgroup.;
    mean1=Estimate;
    pvalue1=Probt;
    lower1=Lower;
    upper1=Upper;
	mmse_int_ci=put(mean1,6.3)||" ("||put(lower1,6.3)||"," ||put(upper1,6.3)||")";
run;

data output2(keep=effect2 group2 mean2 pvalue2 lower2 upper2 mmse_lsmeans_ci);
	set b2;
	effect2=effect;
	group2=&expgroup.;
	mean2=estimate;
	pvalue2=Probt;
	lower2=Lower;
    upper2=Upper;
	mmse_lsmeans_ci=put(mean2,6.3)||" ("||put(lower2,6.3)||","||put(upper2,6.3)||")";
run;

data output;merge output1 output2;run;

proc sql;insert into beta_total set var="&name.";quit;
data beta_total;set beta_total output;run;
%mend;

%macro outcsv(data=,name=);
proc export data=&data.
            outfile= "E:\plotdata\&name..csv" 
            dbms=csv replace;
     putnames=yes;
run;
%mend;


/*Overall participants*/
proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num,lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse;
%decline(data=compute_long,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_overall.csv" 
            dbms=csv replace;
            putnames=yes;
run;

%outcsv(data=predplot_mmse,       name=plot_overallcog)
%outcsv(data=predplot_orientation,name=plot_orientation)
%outcsv(data=predplot_compute,    name=plot_compute)
%outcsv(data=predplot_visual,     name=plot_visual)
%outcsv(data=predplot_language,   name=plot_language)
%outcsv(data=predplot_name,       name=plot_name)
%outcsv(data=predplot_recall,     name=plot_recall)


/*sensitivity analyses:further adjusted for self-reported health status (yes/no)*/
proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse health_report;
%decline(data=compute_long,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall health_report;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall health_report;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall health_report;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall health_report;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall health_report;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall health_report;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_health_report.csv" 
            dbms=csv replace;
            putnames=yes;
run;


/*sensitivity analyses:further adjusted for optimism status (continuous)*/
proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse optimism;
%decline(data=compute_long,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall optimism;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall optimism;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall optimism;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall optimism;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall optimism;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall optimism;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_optimism.csv" 
            dbms=csv replace;
            putnames=yes;
run;


/*sensitivity analyses:further adjusted for history of chronic disease status (yes/no)*/
proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse chronic;
%decline(data=compute_long,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall chronic;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall chronic;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall chronic;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall chronic;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall chronic;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall chronic;
%decline(data=compute_long,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_chronic.csv" 
            dbms=csv replace;
            putnames=yes;
run;


/*sensitivity analyses:excluding participants with baseline MMSE score below the 10th percentile*/
data compute_long_mmselow10;set compute_long; if mmselow10=0;run;

proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse;
%decline(data=compute_long_mmselow10,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmselow10,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmselow10,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmselow10,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmselow10,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmselow10,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmselow10,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_mmselow10.csv" 
            dbms=csv replace;
            putnames=yes;
run;


/*sensitivity analyses:a new healthy lifestyle score using "never smoking" as a healthy lifestyle factor*/
proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse;
%decline(data=compute_long,expgroup=hlsnewg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsnewg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsnewg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsnewg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsnewg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsnewg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long,expgroup=hlsnewg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_hlsnew.csv" 
            dbms=csv replace;
            putnames=yes;
run;


/*sensitivity analyses:restricting to participants who complete all the MMSE items*/
data compute_long_mmsenull;set compute_long; if mmse_null^=.;run;

proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse;
%decline(data=compute_long_mmsenull,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmsenull,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmsenull,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmsenull,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmsenull,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmsenull,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_mmsenull,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_mmsenull.csv" 
            dbms=csv replace;
            putnames=yes;
run;


/*Among participants with genetic information,joint association*/
data compute_long_prs;set compute_long;if q2prs^=.;run;

proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse;
%decline(data=compute_long_prs,expgroup=groupc,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs,expgroup=groupc,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs,expgroup=groupc,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs,expgroup=groupc,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs,expgroup=groupc,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs,expgroup=groupc,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs,expgroup=groupc,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate_prs.csv" 
            dbms=csv replace;
            putnames=yes;
run;

%outcsv(data=predplot_mmse,       name=prs_plot_overallcog)
%outcsv(data=predplot_orientation,name=prs_plot_orientation)
%outcsv(data=predplot_compute,    name=prs_plot_compute)
%outcsv(data=predplot_visual,     name=prs_plot_visual)
%outcsv(data=predplot_language,   name=prs_plot_language)
%outcsv(data=predplot_name,       name=prs_plot_name)
%outcsv(data=predplot_recall,     name=prs_plot_recall)


/*Among participants with genetic information,stratified by genetic risk*/
/*low genetic risk*/
data compute_long_prs_low;set compute_long;if q2prs=0;run;

proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse;
%decline(data=compute_long_prs_low,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_low,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_low,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_low,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_low,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_low,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_low,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate3_lowprs.csv" 
            dbms=csv replace;
            putnames=yes;
run;

%outcsv(data=predplot_mmse,       name=prs_low_plot_overallcog)
%outcsv(data=predplot_orientation,name=prs_low_plot_orientation)
%outcsv(data=predplot_compute,    name=prs_low_plot_compute)
%outcsv(data=predplot_visual,     name=prs_low_plot_visual)
%outcsv(data=predplot_language,   name=prs_low_plot_language)
%outcsv(data=predplot_name,       name=prs_low_plot_name)
%outcsv(data=predplot_recall,     name=prs_low_plot_recall)

/*high genetic risk*/
data compute_long_prs_high;set compute_long;if q2prs=1;run;

proc sql noprint;create table beta_total (var char(30),effect1 char(30),group1 num,mean1 num,pvalue1 num, lower1 num,upper1 num, mmse_int_ci char(30),effect2 char(30),group2 num,mean2 num,pvalue2 num, lower2 num,upper2 num, mmse_lsmeans_ci char(30));quit;

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_mmse;
%decline(data=compute_long_prs_high,expgroup=hlsg,zscore=y_mmse_z,time=visit,name=mmse);/*overall cognitive function*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_high,expgroup=hlsg,zscore=y_c_orientation_z,time=visit,name=orientation);/*orientation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_high,expgroup=hlsg,zscore=y_c_compute_z,time=visit,name=compute);/*attention and calculation skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_high,expgroup=hlsg,zscore=y_c_visual_z,time=visit,name=visual);/*visual skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_high,expgroup=hlsg,zscore=y_c_language_z,time=visit,name=language);/*language skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_high,expgroup=hlsg,zscore=y_c_name_z,time=visit,name=name);/*name skill*/

%let cov1=edu job;
%let cov2=a1 age wave urban married income z_c_orientation z_c_compute z_c_visual z_c_language z_c_name z_c_recall;
%decline(data=compute_long_prs_high,expgroup=hlsg,zscore=y_c_recall_z,time=visit,name=recall);/*recall skill*/

proc export data=beta_total
            outfile= "E:\CLHLS\result\rate3_highprs.csv" 
            dbms=csv replace;
            putnames=yes;
run;

%outcsv(data=predplot_mmse,       name=prs_high_plot_overallcog)
%outcsv(data=predplot_orientation,name=prs_high_plot_orientation)
%outcsv(data=predplot_compute,    name=prs_high_plot_compute)
%outcsv(data=predplot_visual,     name=prs_high_plot_visual)
%outcsv(data=predplot_language,   name=prs_high_plot_language)
%outcsv(data=predplot_name,       name=prs_high_plot_name)
%outcsv(data=predplot_recall,     name=prs_high_plot_recall)




/*Step7:Integrated healthy lifestyle, genetic risk, and risk of cognitive impairment;*/
/*NOTE:The Cox proportional hazard regression model*/
/*data: name of the input SAS datafile; 
  expgroup: integrated healthy lifestyle group;
  pytime: follow-up time of incident of cognitive impairment; 
  outcome: incident of cognitive impairment;
  covar1:set one of related covariates adjusted in Cox proportional hazard regression model; 
  covar2:set two of related covariates adjusted in Cox proportional hazard regression model;
*/

%macro HR (data=, expgroup=, pytime=, outcome=, covar1=, covar2=);
/*Testing the proportional hazard assumption in Cox models*/
proc phreg data=&data.;
    class &expgroup. &covar2./param=ref ref=first;
    model &pytime.*&outcome.(0)=&expgroup. &covar1. &covar2./rl;
	output out=res ressch=sch;
run;  

proc sgplot data=res;
	scatter x=&pytime. y=sch;
run;

proc corr data=res;
	var &pytime. sch;
run;

/*Estimates of hazard ratios and 95% confidence interval*/
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



