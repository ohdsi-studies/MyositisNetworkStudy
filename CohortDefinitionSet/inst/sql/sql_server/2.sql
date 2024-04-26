CREATE TABLE #Codesets (
  codeset_id int NOT NULL,
  concept_id bigint NOT NULL
)
;

INSERT INTO #Codesets (codeset_id, concept_id)
SELECT 0 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (80182,4270868,4081250,4344161)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (80182,4270868,4081250,4344161)
  and c.invalid_reason is null

) I
LEFT JOIN
(
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4005037,606434,37395588,606385,36674477)

) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C UNION ALL 
SELECT 1 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (40228901,40228900,40228903,40228902,40228904,19016894,19014907,19021548,19103333,19014880,19014908,40184084,40184085,40184086,40242200,40220530,40220572,40220574,40220577,40220526,40220575,40220528,40220573,45776924,44506734,44506738,45776933,46275603,46275601,19007333,1305122,19070893,19007332,1594291,1305085,1305086,36277516,43289160,36784095,36274933,43289163,36784101,19078956,19021102,19022826,21603907,19001528,19075846,19001529,19075848,19018902,19072297,19072298,19001528,19075847,19075846,19001529,19075848,19018902,36057779,35896976,36057782,35896975,36057762,36057767,46307444,44338144,45662178,45707894,45683491,45689509,45644115,45631568,44344117,45655362,45649977,45684720,36214313,40220447,45666622,45628095,40220530,40220526,43012549,36246292,43012732,43012731,40220528,43012726,40220525,40220568,40220569,40220566,44344117,45655362,36228437,40184496,40220567,40220565,40220625,40220628,36228435,45695072,45631568,45689509,45662178,45683491,45644115,45707894,45651456,45659710,40220642,40220643,19123094,40220626,40220624,45634479,45660549,40220556,40220549,40220533,40220557,40220551,40220555,40220552,40220547,45626117,45630614,36233665,40226913,40220553,19070890,40220535,40220532,40220572,40220574,40220575,40220573,19022400,40220571,45666622,36228876,40220620,40220621,40220617,40220623,40220619,40220618,19117121,40220559,44353502,46317493,45633493,45662763,36228344,45694706)

) I
) C UNION ALL 
SELECT 2 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (3013023,3018576,40759850,3015302,3036086,3046519,42529529,3052971,3046209,42870556,3048888,42529588,42529265,3030635,40759863,42529058,3030939,40759864,42528593,36031500,36305608,42529123,3013637,40759862,40759756,36304323,42529125,36303431,42529124,42529582,36306115,42528691,3015302,3018576,40759850,3036086,42529584,42529583,42528690)

) I
) C UNION ALL 
SELECT 3 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (2212290)

) I
) C UNION ALL 
SELECT 4 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (40228901,40228900,40228903,40228902,40228904,19016894,19014907,19021548,19103333,19014880,19014908,40184084,40184085,40184086,40242200,40220530,40220572,40220574,40220577,40220526,40220575,40220528,40220573,45776924,44506734,44506738,45776933,46275603,46275601,19007333,1305122,19070893,19007332,1594291,1305085,1305086,36277516,43289160,36784095,36274933,43289163,36784101,19078956,19021102,19022826,21603907,19001528,19075846,19001529,19075848,19018902,19072297,19072298,19001528,19075847,19075846,19001529,19075848,19018902,36057779,35896976,36057782,35896975,36057762,36057767,46307444,44338144,45662178,45707894,45683491,45689509,45644115,45631568,44344117,45655362,45649977,45684720,36214313,40220447,45666622,45628095,40220530,40220526,43012549,36246292,43012732,43012731,40220528,43012726,40220525,40220568,40220569,40220566,44344117,45655362,36228437,40184496,40220567,40220565,40220625,40220628,36228435,45695072,45631568,45689509,45662178,45683491,45644115,45707894,45651456,45659710,40220642,40220643,19123094,40220626,40220624,45634479,45660549,40220556,40220549,40220533,40220557,40220551,40220555,40220552,40220547,45626117,45630614,36233665,40226913,40220553,19070890,40220535,40220532,40220572,40220574,40220575,40220573,19022400,40220571,45666622,36228876,40220620,40220621,40220617,40220623,40220619,40220618,19117121,40220559,44353502,46317493,45633493,45662763,36228344,45694706)

) I
) C UNION ALL 
SELECT 5 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (38003882,38003957,3198921,4202807,706486,45756818,3191718,4163857,44777791,706305,38004491,800963,4147272,3196458,40316907,3103454,3104168,40323832,4138814,3461755,3450539,4123940,45492839,801381,3524358,3524357,3460571,4141876,4141996,3428444,45494734,3463734,4140490,35609057,1008379,40769196,3572172,3571953,3447774,44784538,3559063,44793419,45486371,3556430,3556431,45452827,44793453,45436235,44793420,3556427,3556426,45506160,3556429,3556428,44793452,45502775,3450720,4081929,45452710,4084344,3477097,3272551,44809686,706486,1009500,4304900,37312123,4085153,3464387,45499454,4125988,4138504,3466942,3467819,44808088,3433013,4141720,45429533,3552748,3553029,3461462,4216425,4127770,3467742,4138637,3460095,3473723,4245253,45419703,3556846,3556847,44802386,3196855,45442720,4080078,45505420,45488940,3557212,19386756,1026232,40567163,4214702,3239728,40564134,45446250,3156586,3155848,706305,19393738,1019005,3247937,4147094,3456105,44784540,3557092,45432142,3557113,4062210,3452866,3431205,4147956,4063262,3557501,3468964,4086753,4063261,3250798,3402125,4062999,4061932,3332438,4081261,3442277,3454637,4084857,3440499,3557076,3581788,44784539,45448699,3461315,4061931,45522747,45489572,3430827,4084336,1019006,4061930,3440460,4063259,3437381,4136747,3576704,3572171,45419038,1015757,1019007,4081134,3449675,45446078,46270515,44811418,3279608,45423024,44801961,3435565,4063260,45449478,44809404,3559420,45421509,3462211,4136623,45491416,3558274,3439339,45432925,4140786,4139891,3469328,45522841,4089021,3475962,45532673,45489662,45488155,3448041,4138196,3556692,3556770,3437614,4124216,45488157)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (38003882,38003957,3198921,4202807,706486,45756818,3191718,4163857,44777791,706305,38004491,800963,4147272,3196458,40316907,3103454,3104168,40323832,4138814,3461755,3450539,4123940,45492839,801381,3524358,3524357,3460571,4141876,4141996,3428444,45494734,3463734,4140490,35609057,1008379,40769196,3572172,3571953,3447774,44784538,3559063,44793419,45486371,3556430,3556431,45452827,44793453,45436235,44793420,3556427,3556426,45506160,3556429,3556428,44793452,45502775,3450720,4081929,45452710,4084344,3477097,3272551,44809686,706486,1009500,4304900,37312123,4085153,3464387,45499454,4125988,4138504,3466942,3467819,44808088,3433013,4141720,45429533,3552748,3553029,3461462,4216425,4127770,3467742,4138637,3460095,3473723,4245253,45419703,3556846,3556847,44802386,3196855,45442720,4080078,45505420,45488940,3557212,19386756,1026232,40567163,4214702,3239728,40564134,45446250,3156586,3155848,706305,19393738,1019005,3247937,4147094,3456105,44784540,3557092,45432142,3557113,4062210,3452866,3431205,4147956,4063262,3557501,3468964,4086753,4063261,3250798,3402125,4062999,4061932,3332438,4081261,3442277,3454637,4084857,3440499,3557076,3581788,44784539,45448699,3461315,4061931,45522747,45489572,3430827,4084336,1019006,4061930,3440460,4063259,3437381,4136747,3576704,3572171,45419038,1015757,1019007,4081134,3449675,45446078,46270515,44811418,3279608,45423024,44801961,3435565,4063260,45449478,44809404,3559420,45421509,3462211,4136623,45491416,3558274,3439339,45432925,4140786,4139891,3469328,45522841,4089021,3475962,45532673,45489662,45488155,3448041,4138196,3556692,3556770,3437614,4124216,45488157)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 6 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4128582,3472663,1008853,40769735,19386741,3464926,4143145,1008388,40769206,1008378,40769195,45472950,3471353,4086290,4138371,3452007,3473293,4202186,3454060,4139726,45504653,3556693,3556771,3460406,45506161,4124075,45471496,3195064,4077283)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (4128582,3472663,1008853,40769735,19386741,3464926,4143145,1008388,40769206,1008378,40769195,45472950,3471353,4086290,4138371,3452007,3473293,4202186,3454060,4139726,45504653,3556693,3556771,3460406,45506161,4124075,45471496,3195064,4077283)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 7 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (4128586,3463696,3437749,4123790,3455860,4140334,3468014,4141986,3197373,4207073,19386757,3194692,4205969,45489584,4085150,3444523,4141070,4140956,3451483,3451342,4202187,3556210,45516195,3556167,3466220,764580,3261090,45496135,3449991,4140178,4139728,45454565,3468994,45504652,3451531,45512925,3559985,4139719,3430398,45509516,3559962,4124079,45447872,3463975,45428036,4139080,4138043,3441430,3446398,4123942,45466200,38003979,38003992,38003987,38003981,38003982,38003993,38003988,38003985,38003986,38003984,38003990,38003989,38003997,43125860,903251,45504663,4140489,3468947,45484800,3435973,4144355,35609153,46233432,45472865,44789921,3554646,45509325,3526032,3554216,38003983,45462830,3475418,4081269,3228082,4192658,1026223,45509580,44777725,40567161,38004458,3156584,3155846,19392416,40564132,1018965,38003663,3333908,4150070,3444704,4084989,3475176,4081138,45476297,45482925,4080060,3458347,4154947,3306107,800946,4075506,3193668,1015563,1018966,3473371,4081776,45476295,762429,37312680,44811416,3247165,1992656,1015564,45756788,1010031,45522731,4084677,3431211,45502694,44515736,3567861,3554649,40564136,3156588,3155850,44777781,3300601,45509581,40567165,3423529,3214081,3272182,38003994,4190423,4147095,4304568,4149136,1005595,38004058,33005,44808090,3463477,4084349,44791023,3554703,45422916,3554399,3438657,4142599,44791776,45423054,3554727,3554423,44790926,45436218,3457361,4140802,3555103,3555104,3459241,4125840,3451830,45516295,4088538,45527632,38003996,38003995,44515737,1014805,45756834)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (4128586,3463696,3437749,4123790,3455860,4140334,3468014,4141986,3197373,4207073,19386757,3194692,4205969,45489584,4085150,3444523,4141070,4140956,3451483,3451342,4202187,3556210,45516195,3556167,3466220,764580,3261090,45496135,3449991,4140178,4139728,45454565,3468994,45504652,3451531,45512925,3559985,4139719,3430398,45509516,3559962,4124079,45447872,3463975,45428036,4139080,4138043,3441430,3446398,4123942,45466200,38003979,38003992,38003987,38003981,38003982,38003993,38003988,38003985,38003986,38003984,38003990,38003989,38003997,43125860,903251,45504663,4140489,3468947,45484800,3435973,4144355,35609153,46233432,45472865,44789921,3554646,45509325,3526032,3554216,38003983,45462830,3475418,4081269,3228082,4192658,1026223,45509580,44777725,40567161,38004458,3156584,3155846,19392416,40564132,1018965,38003663,3333908,4150070,3444704,4084989,3475176,4081138,45476297,45482925,4080060,3458347,4154947,3306107,800946,4075506,3193668,1015563,1018966,3473371,4081776,45476295,762429,37312680,44811416,3247165,1992656,1015564,45756788,1010031,45522731,4084677,3431211,45502694,44515736,3567861,3554649,40564136,3156588,3155850,44777781,3300601,45509581,40567165,3423529,3214081,3272182,38003994,4190423,4147095,4304568,4149136,1005595,38004058,33005,44808090,3463477,4084349,44791023,3554703,45422916,3554399,3438657,4142599,44791776,45423054,3554727,3554423,44790926,45436218,3457361,4140802,3555103,3555104,3459241,4125840,3451830,45516295,4088538,45527632,38003996,38003995,44515737,1014805,45756834)
  and c.invalid_reason is null

) I
) C UNION ALL 
SELECT 8 as codeset_id, c.concept_id FROM (select distinct I.concept_id FROM
( 
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (1305058,19014878,19003999,1551099,1506270,19117912,950637,19010482,1310317,1314273,42904205)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (1305058,19014878,19003999,1551099,1506270,19117912,950637,19010482,1310317,1314273,42904205)
  and c.invalid_reason is null

) I
LEFT JOIN
(
  select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in (41236880,41017908,44095070,44043389,41049173,40924453,44029985,40012593,40924346,40986587,40022944,35888457,40236657,35200336,40028532,40892984,40955250,40060727,35864928,35864929,35139788,44068805,42901434,42480795,40830453,40060699,40066583,40066585,41173847,40077886,40077887,40077888,41048586,40073813,36812163)
UNION  select c.concept_id
  from @vocabulary_database_schema.CONCEPT c
  join @vocabulary_database_schema.CONCEPT_ANCESTOR ca on c.concept_id = ca.descendant_concept_id
  and ca.ancestor_concept_id in (41236880,41017908,44095070,44043389,41049173,40924453,44029985,40012593,40924346,40986587,40022944,35888457,40236657,35200336,40028532,40892984,40955250,40060727,35864928,35864929,35139788,44068805,42901434,42480795,40830453,40060699,40066583,40066585,41173847,40077886,40077887,40077888,41048586,40073813,36812163)
  and c.invalid_reason is null

) E ON I.concept_id = E.concept_id
WHERE E.concept_id is null
) C
;

SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, visit_occurrence_id
INTO #qualified_events
FROM 
(
  select pe.event_id, pe.person_id, pe.start_date, pe.end_date, pe.op_start_date, pe.op_end_date, row_number() over (partition by pe.person_id order by pe.start_date ASC) as ordinal, cast(pe.visit_occurrence_id as bigint) as visit_occurrence_id
  FROM (-- Begin Primary Events
select P.ordinal as event_id, P.person_id, P.start_date, P.end_date, op_start_date, op_end_date, cast(P.visit_occurrence_id as bigint) as visit_occurrence_id
FROM
(
  select E.person_id, E.start_date, E.end_date,
         row_number() OVER (PARTITION BY E.person_id ORDER BY E.sort_date ASC, E.event_id) ordinal,
         OP.observation_period_start_date as op_start_date, OP.observation_period_end_date as op_end_date, cast(E.visit_occurrence_id as bigint) as visit_occurrence_id
  FROM 
  (
  -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 0)
) C


-- End Condition Occurrence Criteria

  ) E
	JOIN @cdm_database_schema.observation_period OP on E.person_id = OP.person_id and E.start_date >=  OP.observation_period_start_date and E.start_date <= op.observation_period_end_date
  WHERE DATEADD(day,365,OP.OBSERVATION_PERIOD_START_DATE) <= E.START_DATE AND DATEADD(day,0,E.START_DATE) <= OP.OBSERVATION_PERIOD_END_DATE
) P
WHERE P.ordinal = 1
-- End Primary Events
) pe
  
) QE

;

--- Inclusion Rule Inserts

select 0 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_0
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Demographic Criteria
SELECT 0 as index_id, e.person_id, e.event_id
FROM #qualified_events E
JOIN @cdm_database_schema.PERSON P ON P.PERSON_ID = E.PERSON_ID
WHERE YEAR(E.start_date) - P.year_of_birth >= 18
GROUP BY e.person_id, e.event_id
-- End Demographic Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

select 1 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_1
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Condition Occurrence Criteria
SELECT C.person_id, C.condition_occurrence_id as event_id, C.condition_start_date as start_date, COALESCE(C.condition_end_date, DATEADD(day,1,C.condition_start_date)) as end_date,
  C.visit_occurrence_id, C.condition_start_date as sort_date
FROM 
(
  SELECT co.* 
  FROM @cdm_database_schema.CONDITION_OCCURRENCE co
  JOIN #Codesets cs on (co.condition_concept_id = cs.concept_id and cs.codeset_id = 0)
) C


-- End Condition Occurrence Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,30,P.START_DATE) AND A.START_DATE <= DATEADD(day,365,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

select 2 as inclusion_rule_id, person_id, event_id
INTO #Inclusion_2
FROM 
(
  select pe.person_id, pe.event_id
  FROM #qualified_events pe
  
JOIN (
-- Begin Criteria Group
select 0 as index_id, person_id, event_id
FROM
(
  select E.person_id, E.event_id 
  FROM #qualified_events E
  INNER JOIN
  (
    -- Begin Correlated Criteria
select 0 as index_id, cc.person_id, cc.event_id
from (SELECT p.person_id, p.event_id 
FROM #qualified_events P
JOIN (
  -- Begin Drug Exposure Criteria
select C.person_id, C.drug_exposure_id as event_id, C.drug_exposure_start_date as start_date,
       COALESCE(C.DRUG_EXPOSURE_END_DATE, DATEADD(day,C.DAYS_SUPPLY,DRUG_EXPOSURE_START_DATE), DATEADD(day,1,C.DRUG_EXPOSURE_START_DATE)) as end_date,
       C.visit_occurrence_id,C.drug_exposure_start_date as sort_date
from 
(
  select de.* 
  FROM @cdm_database_schema.DRUG_EXPOSURE de
JOIN #Codesets cs on (de.drug_concept_id = cs.concept_id and cs.codeset_id = 8)
) C


-- End Drug Exposure Criteria

) A on A.person_id = P.person_id  AND A.START_DATE >= P.OP_START_DATE AND A.START_DATE <= P.OP_END_DATE AND A.START_DATE >= DATEADD(day,-90,P.START_DATE) AND A.START_DATE <= DATEADD(day,90,P.START_DATE) ) cc 
GROUP BY cc.person_id, cc.event_id
HAVING COUNT(cc.event_id) >= 1
-- End Correlated Criteria

  ) CQ on E.person_id = CQ.person_id and E.event_id = CQ.event_id
  GROUP BY E.person_id, E.event_id
  HAVING COUNT(index_id) = 1
) G
-- End Criteria Group
) AC on AC.person_id = pe.person_id AND AC.event_id = pe.event_id
) Results
;

SELECT inclusion_rule_id, person_id, event_id
INTO #inclusion_events
FROM (select inclusion_rule_id, person_id, event_id from #Inclusion_0
UNION ALL
select inclusion_rule_id, person_id, event_id from #Inclusion_1
UNION ALL
select inclusion_rule_id, person_id, event_id from #Inclusion_2) I;
TRUNCATE TABLE #Inclusion_0;
DROP TABLE #Inclusion_0;

TRUNCATE TABLE #Inclusion_1;
DROP TABLE #Inclusion_1;

TRUNCATE TABLE #Inclusion_2;
DROP TABLE #Inclusion_2;


select event_id, person_id, start_date, end_date, op_start_date, op_end_date
into #included_events
FROM (
  SELECT event_id, person_id, start_date, end_date, op_start_date, op_end_date, row_number() over (partition by person_id order by start_date ASC) as ordinal
  from
  (
    select Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date, SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) as inclusion_rule_mask
    from #qualified_events Q
    LEFT JOIN #inclusion_events I on I.person_id = Q.person_id and I.event_id = Q.event_id
    GROUP BY Q.event_id, Q.person_id, Q.start_date, Q.end_date, Q.op_start_date, Q.op_end_date
  ) MG -- matching groups
{3 != 0}?{
  -- the matching group with all bits set ( POWER(2,# of inclusion rules) - 1 = inclusion_rule_mask
  WHERE (MG.inclusion_rule_mask = POWER(cast(2 as bigint),3)-1)
}
) Results

;



-- generate cohort periods into #final_cohort
select person_id, start_date, end_date
INTO #cohort_rows
from ( -- first_ends
	select F.person_id, F.start_date, F.end_date
	FROM (
	  select I.event_id, I.person_id, I.start_date, CE.end_date, row_number() over (partition by I.person_id, I.event_id order by CE.end_date) as ordinal
	  from #included_events I
	  join ( -- cohort_ends
-- cohort exit dates
-- By default, cohort exit at the event's op end date
select event_id, person_id, op_end_date as end_date from #included_events
    ) CE on I.event_id = CE.event_id and I.person_id = CE.person_id and CE.end_date >= I.start_date
	) F
	WHERE F.ordinal = 1
) FE;

select person_id, min(start_date) as start_date, end_date
into #final_cohort
from ( --cteEnds
	SELECT
		 c.person_id
		, c.start_date
		, MIN(ed.end_date) AS end_date
	FROM #cohort_rows c
	JOIN ( -- cteEndDates
    SELECT
      person_id
      , DATEADD(day,-1 * 365, event_date)  as end_date
    FROM
    (
      SELECT
        person_id
        , event_date
        , event_type
        , SUM(event_type) OVER (PARTITION BY person_id ORDER BY event_date, event_type ROWS UNBOUNDED PRECEDING) AS interval_status
      FROM
      (
        SELECT
          person_id
          , start_date AS event_date
          , -1 AS event_type
        FROM #cohort_rows

        UNION ALL


        SELECT
          person_id
          , DATEADD(day,365,end_date) as end_date
          , 1 AS event_type
        FROM #cohort_rows
      ) RAWDATA
    ) e
    WHERE interval_status = 0
  ) ed ON c.person_id = ed.person_id AND ed.end_date >= c.start_date
	GROUP BY c.person_id, c.start_date
) e
group by person_id, end_date
;

DELETE FROM @target_database_schema.@target_cohort_table where cohort_definition_id = @target_cohort_id;
INSERT INTO @target_database_schema.@target_cohort_table (cohort_definition_id, subject_id, cohort_start_date, cohort_end_date)
select @target_cohort_id as cohort_definition_id, person_id, start_date, end_date 
FROM #final_cohort CO
;

{1 != 0}?{
-- BEGIN: Censored Stats

delete from @results_database_schema.cohort_censor_stats where cohort_definition_id = @target_cohort_id;

-- END: Censored Stats
}
{1 != 0 & 3 != 0}?{

-- Create a temp table of inclusion rule rows for joining in the inclusion rule impact analysis

select cast(rule_sequence as int) as rule_sequence
into #inclusion_rules
from (
  SELECT CAST(0 as int) as rule_sequence UNION ALL SELECT CAST(1 as int) as rule_sequence UNION ALL SELECT CAST(2 as int) as rule_sequence
) IR;


-- Find the event that is the 'best match' per person.  
-- the 'best match' is defined as the event that satisfies the most inclusion rules.
-- ties are solved by choosing the event that matches the earliest inclusion rule, and then earliest.

select q.person_id, q.event_id
into #best_events
from #qualified_events Q
join (
	SELECT R.person_id, R.event_id, ROW_NUMBER() OVER (PARTITION BY R.person_id ORDER BY R.rule_count DESC,R.min_rule_id ASC, R.start_date ASC) AS rank_value
	FROM (
		SELECT Q.person_id, Q.event_id, COALESCE(COUNT(DISTINCT I.inclusion_rule_id), 0) AS rule_count, COALESCE(MIN(I.inclusion_rule_id), 0) AS min_rule_id, Q.start_date
		FROM #qualified_events Q
		LEFT JOIN #inclusion_events I ON q.person_id = i.person_id AND q.event_id = i.event_id
		GROUP BY Q.person_id, Q.event_id, Q.start_date
	) R
) ranked on Q.person_id = ranked.person_id and Q.event_id = ranked.event_id
WHERE ranked.rank_value = 1
;

-- modes of generation: (the same tables store the results for the different modes, identified by the mode_id column)
-- 0: all events
-- 1: best event


-- BEGIN: Inclusion Impact Analysis - event
-- calculte matching group counts
delete from @results_database_schema.cohort_inclusion_result where cohort_definition_id = @target_cohort_id and mode_id = 0;
insert into @results_database_schema.cohort_inclusion_result (cohort_definition_id, inclusion_rule_mask, person_count, mode_id)
select @target_cohort_id as cohort_definition_id, inclusion_rule_mask, count_big(*) as person_count, 0 as mode_id
from
(
  select Q.person_id, Q.event_id, CAST(SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) AS bigint) as inclusion_rule_mask
  from #qualified_events Q
  LEFT JOIN #inclusion_events I on q.person_id = i.person_id and q.event_id = i.event_id
  GROUP BY Q.person_id, Q.event_id
) MG -- matching groups
group by inclusion_rule_mask
;

-- calculate gain counts 
delete from @results_database_schema.cohort_inclusion_stats where cohort_definition_id = @target_cohort_id and mode_id = 0;
insert into @results_database_schema.cohort_inclusion_stats (cohort_definition_id, rule_sequence, person_count, gain_count, person_total, mode_id)
select @target_cohort_id as cohort_definition_id, ir.rule_sequence, coalesce(T.person_count, 0) as person_count, coalesce(SR.person_count, 0) gain_count, EventTotal.total, 0 as mode_id
from #inclusion_rules ir
left join
(
  select i.inclusion_rule_id, count_big(i.event_id) as person_count
  from #qualified_events Q
  JOIN #inclusion_events i on Q.person_id = I.person_id and Q.event_id = i.event_id
  group by i.inclusion_rule_id
) T on ir.rule_sequence = T.inclusion_rule_id
CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
CROSS JOIN (select count_big(event_id) as total from #qualified_events) EventTotal
LEFT JOIN @results_database_schema.cohort_inclusion_result SR on SR.mode_id = 0 AND SR.cohort_definition_id = @target_cohort_id AND (POWER(cast(2 as bigint),RuleTotal.total_rules) - POWER(cast(2 as bigint),ir.rule_sequence) - 1) = SR.inclusion_rule_mask -- POWER(2,rule count) - POWER(2,rule sequence) - 1 is the mask for 'all except this rule'
;

-- calculate totals
delete from @results_database_schema.cohort_summary_stats where cohort_definition_id = @target_cohort_id and mode_id = 0;
insert into @results_database_schema.cohort_summary_stats (cohort_definition_id, base_count, final_count, mode_id)
select @target_cohort_id as cohort_definition_id, PC.total as person_count, coalesce(FC.total, 0) as final_count, 0 as mode_id
FROM
(select count_big(event_id) as total from #qualified_events) PC,
(select sum(sr.person_count) as total
  from @results_database_schema.cohort_inclusion_result sr
  CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
  where sr.mode_id = 0 and sr.cohort_definition_id = @target_cohort_id and sr.inclusion_rule_mask = POWER(cast(2 as bigint),RuleTotal.total_rules)-1
) FC
;

-- END: Inclusion Impact Analysis - event

-- BEGIN: Inclusion Impact Analysis - person
-- calculte matching group counts
delete from @results_database_schema.cohort_inclusion_result where cohort_definition_id = @target_cohort_id and mode_id = 1;
insert into @results_database_schema.cohort_inclusion_result (cohort_definition_id, inclusion_rule_mask, person_count, mode_id)
select @target_cohort_id as cohort_definition_id, inclusion_rule_mask, count_big(*) as person_count, 1 as mode_id
from
(
  select Q.person_id, Q.event_id, CAST(SUM(coalesce(POWER(cast(2 as bigint), I.inclusion_rule_id), 0)) AS bigint) as inclusion_rule_mask
  from #best_events Q
  LEFT JOIN #inclusion_events I on q.person_id = i.person_id and q.event_id = i.event_id
  GROUP BY Q.person_id, Q.event_id
) MG -- matching groups
group by inclusion_rule_mask
;

-- calculate gain counts 
delete from @results_database_schema.cohort_inclusion_stats where cohort_definition_id = @target_cohort_id and mode_id = 1;
insert into @results_database_schema.cohort_inclusion_stats (cohort_definition_id, rule_sequence, person_count, gain_count, person_total, mode_id)
select @target_cohort_id as cohort_definition_id, ir.rule_sequence, coalesce(T.person_count, 0) as person_count, coalesce(SR.person_count, 0) gain_count, EventTotal.total, 1 as mode_id
from #inclusion_rules ir
left join
(
  select i.inclusion_rule_id, count_big(i.event_id) as person_count
  from #best_events Q
  JOIN #inclusion_events i on Q.person_id = I.person_id and Q.event_id = i.event_id
  group by i.inclusion_rule_id
) T on ir.rule_sequence = T.inclusion_rule_id
CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
CROSS JOIN (select count_big(event_id) as total from #best_events) EventTotal
LEFT JOIN @results_database_schema.cohort_inclusion_result SR on SR.mode_id = 1 AND SR.cohort_definition_id = @target_cohort_id AND (POWER(cast(2 as bigint),RuleTotal.total_rules) - POWER(cast(2 as bigint),ir.rule_sequence) - 1) = SR.inclusion_rule_mask -- POWER(2,rule count) - POWER(2,rule sequence) - 1 is the mask for 'all except this rule'
;

-- calculate totals
delete from @results_database_schema.cohort_summary_stats where cohort_definition_id = @target_cohort_id and mode_id = 1;
insert into @results_database_schema.cohort_summary_stats (cohort_definition_id, base_count, final_count, mode_id)
select @target_cohort_id as cohort_definition_id, PC.total as person_count, coalesce(FC.total, 0) as final_count, 1 as mode_id
FROM
(select count_big(event_id) as total from #best_events) PC,
(select sum(sr.person_count) as total
  from @results_database_schema.cohort_inclusion_result sr
  CROSS JOIN (select count(*) as total_rules from #inclusion_rules) RuleTotal
  where sr.mode_id = 1 and sr.cohort_definition_id = @target_cohort_id and sr.inclusion_rule_mask = POWER(cast(2 as bigint),RuleTotal.total_rules)-1
) FC
;

-- END: Inclusion Impact Analysis - person

TRUNCATE TABLE #best_events;
DROP TABLE #best_events;

TRUNCATE TABLE #inclusion_rules;
DROP TABLE #inclusion_rules;
}



TRUNCATE TABLE #cohort_rows;
DROP TABLE #cohort_rows;

TRUNCATE TABLE #final_cohort;
DROP TABLE #final_cohort;

TRUNCATE TABLE #inclusion_events;
DROP TABLE #inclusion_events;

TRUNCATE TABLE #qualified_events;
DROP TABLE #qualified_events;

TRUNCATE TABLE #included_events;
DROP TABLE #included_events;

TRUNCATE TABLE #Codesets;
DROP TABLE #Codesets;
