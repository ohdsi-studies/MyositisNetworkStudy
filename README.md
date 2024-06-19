
OHDSI Network Study: Dermatomyositis Phenotype Evaluation
=================

This is an OHDSI study being coordinated by the Johns Hopkins Myositis Center. Please see [our post on the OHDSI forum](https://forums.ohdsi.org/t/network-study-seeking-data-partners-in-rheumatology/21584) for more information.

The Coordinating site is currently in the process of obtaining IRB approval through the Johns Hopkins Medicine IRB. The JHU Application is IRB00373992 and the JHU PI is Dr. Christopher Mecoli, MD. Participating data partners should ensure that ethics board or IRB approval has been obtained as appropriate.
  
### Notes:
  
1. All site-dependent variables are configured at the 'env setup' section of the R/CodeToRun.R script. Please edit those variables according to your site's database needs. The values  used by the coordinating study team at JHU have been preserved as a reference.
2. This script assumes that you have RTools and Java setup to run HADES  packages. [See the instructions from Hades](https://ohdsi.github.io/Hades/rSetup.html).   
3. The use of either a container or renv is recommended, but not included in the script. Packages will be installed as part of this package. Please ensure that you are in an isolated R environment before executing if needed.
4. After the study package has been executed, a /results folder and results.zip  file will be created. Please inspect these files to ensure that the contents do   not contain any patient data (they normally should not!) and submit results.zip   using the OneDrive link provided to you. If you need a OneDrive link, please contact the study team. The study team will be notified once files are received.      
5. Please reach out to the study team with any questions or concerns.


### To participate in this network study:
 1. Review the study protocol found in the documents directory and ensure that your site meets the inclusion criteria.
 2. Contact the study team for a submission link.
 3. Clone the repository `git clone https://github.com/ohdsi-studies/MyositisNetworkStudy.git` or using the RStudio GUI.
 4. Modify the 'env setup' section of the RunMe.R script to connect to your CDM and set metadata for the execution. A file zip file with the results and meta data will be created
 5. Submit the generated zip file to the coordinating study team using the OneDrive link provided.

  




| Element | Description |
| ------- | ----------- |
| Study Title | Creation and Evaluation of Dermatomyositis Phenotypes Across Different Database Sources         
| Study Status | <img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started"> |
| Next Steps | Generate the 8 phenotypes on multiple external OMOP CDMs (at least 1 claims and 1 EHR based CDMs) and run Phevaluator on external CDMs |
| Research Question | How do dermatomyositis phenotypes perform across different data sources (EHR, claims, registries) that may have differences in how the OMOP ETL was performed? |
| Uncertainty | We remain uncertain as to how our phenotypes will perform across other database types (claims, other EHR, etc). 
| Study type | Clinical Application. |
| Tags | `OHDSI` `Myositis` |
| Study lead | Dr. Christopher Mecoli, MD|
| Study lead forums tag | Christopher_Mecoli|
| Study team | See protocol |
| Phenotype Development | Created and tested 8 myositis phenotypes with Phevaluator using Johns Hopkins OMOP CDM |
| Phenotype Evaluation | Currently under development process. This is the purpose of the study |
| Cohort Definitions | Myositis Phenotype Cohort IDs are defined in the `cohorts` directory. These can also be viewed on the [OHDSI Atlas demo instance](https://atlas-demo.ohdsi.org/); ID: 1781804,1788567,1787425,1788503,1789031,1789032,1788875,1789289 |
| Cohort Diagnostics | Currently under development process. (A hyperlink to the R Shiny app where the cohort diagnostics results can be viewed.) |
| Analysis Specifications | Develop a OHDSI protocol to run a multi-centric patient level prediction study on complication comparisons among different drug use for dermatomyositis patients. |
| HADES Packages | DatabaseConnecter, CohortDiagnostics, Phevaluator |
| Study Sites | Pending, but likely to include Stanford, Columbia, and other datasources accessed through J&J |
| Results explorer | N/A  |
| Study start date | Dec 11, 2023 |
| Study end date | Not completed| 
| Protocol | See documents directory | 
| Publications | N/A  | 


### Study Progress

| Study Attribute | Value |
| ------- | ----------- |
| IRB materials sufficient for review | Yes |
| Cohort definition(s) available | Yes |
| Data partner recruitment status | Ready |
| Deadline for adding new data partners | N/A |
| Protocol building team recruitment status | ready |
| Deadline for adding new protocol building team members | N/A |
| Manuscript preparation team recruitment status | Ready |
| Deadline for adding new manuscript preparation team members | N/A |


