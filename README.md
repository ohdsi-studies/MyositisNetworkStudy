StudyRepoTemplate
=================

An OHDSI study repository is expected to have a README.md file where the header conforms to a standard. A template README file is provided here:

**[README file template](templateREADME.md)**

When initiating a repository, please copy this file, rename it to 'README.md', and fill in the fields as appropriate.

The information in the repository README file will be used to automatically update the [list of OHDSI research studies](https://data.ohdsi.org/OhdsiStudies/), so it is important to fill in the template accurately, and keep it up-to-date.

## Elements in the README template

| Element | Description |
| ------- | ----------- |
| Study Title | Creation and Evaluation of Dermatomyositis Phenotypes Across Different Database Sources         
| Study Status | <img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started"> |
| Next Steps | Generate the 8 phenotypes on multiple external OMOP CDMs (at least 1 claims and 1 EHR based CDMs) and run Phevaluator on external CDMs |
| Research Question | How do dermatomyositis phenotypes perform across different data sources (EHR, claims, registries) that may have differences in how the OMOP ETL was performed? |
| Uncertainty | We remain uncertain as to how our phenotypes will perform across other database types (claims, other EHR, etc). 
| Study type | Clinical Application. |
| Tags | `OHDSI` `Myositis` |
| Study lead | Dr. Christopher Mecoli.|
| Study lead forums tag | N/A (The OHDSI forums tag of the study lead, which can be used to contact the lead. It is recommended to make this a hyperlink to lead's forums profile) |
| Study team | Christopher Mecoli, Ben Martin, Will Kelly, Sean Yen |
| Phenotype Development | Created and tested 8 myositis phenotypes with Phevaluator using Johns Hopkins OMOP CDM |
| Phenotype Evaluation | Currently under development process. This is the purpose of the study |
| Cohort Definitions | Myositis Phenotype Cohort IDs (ATLAS Demo): 1781804,1788567,1787425,1788503,1789031,1789032,1788875,1789289 |
| Cohort Diagnostics | Currently under development process. (A hyperlink to the R Shiny app where the cohort diagnostics results can be viewed.) |
| Analysis Specifications | Develop a OHDSI protocol to run a multi-centric patient level prediction study on complication comparisons among different drug use for dermatomyositis patients. |
| HADES Packages | ROhdsiWebApi, DatabaseConnecter, CohortDiagnostics, Phevaluator |
| Study Sites | Pending, but likely to include Stanford, Columbia, and other datasources accessed through J&J |
| Results explorer | N/A (A hyperlink to a web app (e.g. a Shiny app) where the results of the study can be explored.) |
| Study start date | Dec 11, 2023 |
| Study end date | Not complete yet (When was the study completed? This typically indicates when the analyses were completed and the results have been collected. Do not enter future (planned) dates here. Format: [Month] [Day], [Year] (e.g. May 1, 2019)) | 
| Protocol | In progress (A hyperlink to the protocol. The protocol is expected to be a document in the study repository itself.) | 
| Publications | N/A (Zero, one or more hyperlinks to papers produced as part of the study (comma-separated).) | 

### Study Status

Choose one of the following options:

| Badge             | Description                          |
| ----------------- | ------------------------------------ |
| <img src="https://img.shields.io/badge/Study%20Status-Repo%20Created-lightgray.svg" alt="Study Status: Repo Created"> | The study repository has just been created. Work has not yet commenced. | 
| <img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started"> | A first commit was made (to something else than the README file). Work has commenced. |
| <img src="https://img.shields.io/badge/Study%20Status-Design%20Finalized-brightgreen.svg" alt="Study Status: Design Finalized"> | The protocol and study code have been finalized. | 
| <img src="https://img.shields.io/badge/Study%20Status-Results%20Available-yellow.svg" alt="Study Status: Results Available"> | The study results are publicly available, for example in a paper or results explorer app. | 
| <img src="https://img.shields.io/badge/Study%20Status-Complete-orange.svg" alt="Study Status: Complete"> | The study is complete, no further dissemination planned. | 
| <img src="https://img.shields.io/badge/Study%20Status-Suspended-red.svg" alt="Study Status: Suspended"> | The study has been suspended, and may or may not be continued at a later point in time. | 

Copy the relevant markdown code from [this page](badgesMarkdownCode.md), and paste it in your README file, just below the study title.

### Analytics Use Cases

Choose one or more options from: 

- `Characterization`
- `Population-Level Estimation`, or
- `Patient-Level Prediction` 

See [the Data Analytics Use Cases chapter](https://ohdsi.github.io/TheBookOfOhdsi/DataAnalyticsUseCases.html) for more details.

### Study types

Can be either:

- `Methods Research` if the study explores a methodological question, for example an evaluation of various propensity score approaches. 
- `Clinical Application` if the study aims to answer a clinically relevant question, for example 'Does drug A cause outcome B?'.

