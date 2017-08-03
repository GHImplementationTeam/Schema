DROP SCHEMA IF EXISTS "v2016" cascade;
CREATE SCHEMA "v2016";

DROP TABLE IF EXISTS "v2016".path_status;
DROP TABLE IF EXISTS "v2016".rhybcp_status;
DROP TABLE IF EXISTS "v2016".employment;
DROP TABLE IF EXISTS "v2016".health_status;
DROP TABLE IF EXISTS "v2016".affiliation;
DROP TABLE IF EXISTS "v2016".site;
DROP TABLE IF EXISTS "v2016".inventory;
DROP TABLE IF EXISTS "v2016".funder;
DROP TABLE IF EXISTS "v2016".enrollment_coc;
DROP TABLE IF EXISTS "v2016".medicalassistance;
DROP TABLE IF EXISTS "v2016".domesticviolence;
DROP TABLE IF EXISTS "v2016".disabilities;
DROP TABLE IF EXISTS "v2016".residentialmoveindate;
DROP TABLE IF EXISTS "v2016".dateofengagement;
DROP TABLE IF EXISTS "v2016".incomeandsources;
DROP TABLE IF EXISTS "v2016".noncashbenefits;
DROP TABLE IF EXISTS "v2016".healthinsurance;
DROP TABLE IF EXISTS "v2016".exithousingassessment;
DROP TABLE IF EXISTS "v2016".housingassessmentdisposition;
DROP TABLE IF EXISTS "v2016".exit;
DROP TABLE IF EXISTS "v2016".coc;
DROP TABLE IF EXISTS "v2016".project;
DROP TABLE IF EXISTS "v2016".enrollment;
DROP TABLE IF EXISTS "v2016".organization;
DROP TABLE IF EXISTS "v2016".client_veteran_info;
DROP TABLE IF EXISTS "v2016".client;
DROP TABLE IF EXISTS "v2016".bulk_upload_activity;
DROP TABLE IF EXISTS "v2016".export;
DROP TABLE IF EXISTS "v2016".source;
DROP TABLE IF EXISTS v2016.exitRHY;
DROP TABLE IF EXISTS v2016.exitPath;

-- New ENUMS Insert Ends

create table "v2016".source
(
id uuid not null,
  export text,
  sourcetype text,
  softwarename text,
  softwareVersion character varying(50),
  sourceContactEmail	text,
  sourceContactExtension	text,
  sourceContactFirst	character varying(50),
  sourceContactLast	character varying(50),
  sourceContactPhone	character varying(12),
  sourceID	text,
  sourceName	character varying(50),
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
  constraint "source_pkey" primary key (id)
     )
with (
  oids=false
);

create table "v2016".export
(
  id uuid not null,
  export_date  timestamp,
  start_date  timestamp,
  end_date  timestamp,
  exportPeriodType text,
  exportDirective text,
  source_id uuid,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
    export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
   constraint "export_pkey" primary key (id),
      CONSTRAINT source_fkey FOREIGN KEY (source_id)
      REFERENCES v2016.source (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
     )
with (
  oids=false
);



create table "v2016".organization
(
	id uuid not null,
	organizationname text,
	organizationcommonname text,
   "project_group_code" character varying(8),
   "date_created" timestamp,
   "date_created_from_source" timestamp,
   "date_updated_from_source" timestamp,
   "date_updated" timestamp,
   "user_id" uuid,
   export_id uuid,
   parent_id uuid,
   version integer,source_system_id text,
   deleted boolean DEFAULT false,active boolean DEFAULT true,
   sync boolean DEFAULT false,
  	  constraint "organization_pkey" primary key (id)
)
with (
  oids=false
);


CREATE TABLE  "v2016".project
(
	  id uuid NOT NULL,
	  --project_id character varying(8),
	  projectname text,
	  continuumproject "v2016".no_yes,
	  projecttype "v2016".project_type,
	  --residentialaffiliation "v2016".no_yes,
	  trackingmethod "v2016".tracking_method,
	  targetpopulation "v2016".target_population_type,
	  projectcommonname text,
	  organizationid uuid,
	  date_created timestamp,
	  date_updated timestamp,
	  "date_created_from_source" timestamp,
      "date_updated_from_source" timestamp,
      "project_group_code" character varying(8),
	  user_id uuid,
	  export_id uuid,
	  parent_id uuid,
	  version integer,source_system_id text,
	  deleted boolean DEFAULT false,active boolean DEFAULT true,
	  sync boolean DEFAULT false,
	  	  CONSTRAINT "project_pk" PRIMARY KEY (id),
	      CONSTRAINT "organization_project_fkey" FOREIGN KEY (organizationid)
	      REFERENCES v2016.organization (id) MATCH SIMPLE
	      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

-- DROP TABLE "v2016"."client";
CREATE TABLE "v2016".client
(
  "id" uuid NOT NULL,
  "dedup_client_id" uuid,
  "first_name" character(50),
  "middle_name" character(50),
  "last_name" character(50),
  "name_suffix" character(50),
  "name_data_quality" "v2016".name_data_quality,
  "ssn" character(9),
  "ssn_data_quality" "v2016".ssn_data_quality,
  "dob" timestamp,
  "dob_data_quality" "v2016".dob_data_quality,
  "gender" "v2016".gender,
  "other_gender" text,
  "ethnicity" "v2016".ethnicity,
  "race"  "v2016".race,
  "veteran_status" "v2016".veteran_status,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



  	  CONSTRAINT client_pk PRIMARY KEY ("id")
      )
WITH (
  OIDS=FALSE
);
-- Table: "v2016"."client"

-- veteran_info changed to client_veteran_info
CREATE TABLE "v2016".client_veteran_info
(
  "id" uuid NOT NULL,
  "year_entrd_service" integer,
  "year_seperated" integer,
  "world_war_2" "v2016".five_val_dk_refused,
  "korean_war" "v2016".five_val_dk_refused,
  "vietnam_war" "v2016".five_val_dk_refused,
  "desert_storm" "v2016".five_val_dk_refused,
  "afghanistan_oef" "v2016".afghanistanoef,
  "iraq_oif" "v2016".five_val_dk_refused,
  "iraq_ond" "v2016".five_val_dk_refused,
  "other_theater" "v2016".five_val_dk_refused,
  "military_branch" "v2016".military_branch,
  "discharge_status" "v2016".discharge_status,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  "client_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



  	  CONSTRAINT veteran_info_pk PRIMARY KEY ("id"),
  	  CONSTRAINT veteran_info_client_fk FOREIGN KEY ("client_id")
      REFERENCES "v2016".client ("id") MATCH SIMPLE
)
WITH (
  OIDS=FALSE
);

CREATE TABLE "v2016".enrollment
(
  	id uuid NOT NULL,
 --continuouslyHomelessOneYear "v2016".youth_age_group,
	projectentryid uuid,
	entrydate timestamp,
	householdid text,
	relationshiptohoh "v2016".relationship_to_head_of_household,
	otherresidenceprior text,
	residencePrior "v2016".residence_prior,
	losunderthreshold "v2016".no_yes,
	previousStreetESSH "v2016".no_yes,
	residencePriorlengthofstay "v2016".residence_prior_length_of_stay,
	disablingCondition "v2016".five_val_dk_refused,
	housingstatus "v2016".housing_status,
	entryFromStreetESSH integer,
	dateToStreetESSH integer,
	timesHomelesspastthreeyears "v2016".times_homeless_past_3_years,
	monthsHomelessPastThreeYears "v2016".months_homeless_past_3_years,
	projectid uuid,
	client_id uuid,
	project_group_code character varying(8),
	date_created timestamp,
	date_updated timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	user_id uuid,
	export_id uuid,
	parent_id uuid,
	chronicHomeless boolean DEFAULT false,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,
  		CONSTRAINT "enrollment_pkey" PRIMARY KEY (id),
    	CONSTRAINT enrollment_client_fk FOREIGN KEY ("client_id")
      	REFERENCES "v2016".client ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
      	CONSTRAINT enrollment_project_fk FOREIGN KEY ("projectid")
      	REFERENCES "v2016".project ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);




CREATE TABLE "v2016".path_status
(
  "id" uuid NOT NULL,
  "date_of_status" timestamp,
  "client_enrolled_in_path" bigint,
  "reason_not_enrolled"  "v2016".reason_not_enrolled,
  "enrollmentid" uuid,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



	  CONSTRAINT path_status_pk PRIMARY KEY ("id"),
	  CONSTRAINT "enrollment_path_status_fk_key" FOREIGN KEY ("enrollmentid")
      REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


CREATE TABLE "v2016".entrySSVF
(
	"id" uuid NOT NULL,
	"enrollmentid" uuid,
	"percentami"  "v2016".percentAMI,
	last_permanent_street character(50),
	last_permanent_city character(50),
	last_permanent_state character(50),
	last_permanent_zip character(50),
	address_data_quality integer,
	urgent_referral "v2016".no_yes,
	timeToHousingLoss "v2016".timeToHousingLoss,
	zeroincome "v2016".no_yes,
	annualpercentami "v2016".annualpercentami,
	financialchange "v2016".no_yes,
	householdchange "v2016".no_yes,
	evictionhistory "v2016".evictionhistory,
	subsidyatrisk "v2016".no_yes,
	literalHomelessHistory "v2016".literalHomelessHistory,
	disablehoh "v2016".no_yes,
	criminalrecord "v2016".no_yes,
	sexoffender "v2016".no_yes,
	dependendunder6 "v2016".no_yes,
	singleparent "v2016".no_yes,
	hh5plus "v2016".no_yes,
	iraqafghanistan "v2016".no_yes,
	femvet "v2016".no_yes,
	thresholdscore integer,
	ervisits "v2016".crisisServicesUse,
	jailnights "v2016".crisisServicesUse,
	hospitalnights "v2016".crisisServicesUse,
	hp_screen_score integer,
	vamc_staction character(50),
	"project_group_code" character varying(8),
  	"date_created" timestamp,
  	"date_created_from_source" timestamp,
  	"date_updated_from_source" timestamp,
  	"date_updated" timestamp,
  	"user_id" uuid,
  	export_id uuid,
  	parent_id uuid,
  	version integer,source_system_id text,
  	deleted boolean DEFAULT false,active boolean DEFAULT true,
  	sync boolean DEFAULT false,


  	  CONSTRAINT entrySSVF_pk PRIMARY KEY ("id"),
	  CONSTRAINT "enrollment_entrySSVF_fk_key" FOREIGN KEY ("enrollmentid")
      REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

CREATE TABLE "v2016".entryRHY
(
	"id" uuid NOT NULL,
	"enrollmentid" uuid,
	"sexual_orientation" "v2016".sexual_orientation,
	"formerly_ward_child_welfr_forest_care" "v2016".formerly_ward_child_welfr_forest_care,
	"years_child_welfr_forest_care" "v2016".years_child_welfr_forest_care,
	months_child_welfr_forest_care integer,
	"formerly_ward_of_juvenile_justice" "v2016".formerly_ward_of_juvenile_justice,
	"years_juvenile_justice" "v2016".years_juvenile_justice,
	"months_juvenile_justice" "v2016".years_juvenile_justice,
	"house_hold_dynamics" "v2016".house_hold_dynamics,
	"sexual_orientatiion_gender_identity_youth" "v2016".sexual_orientation_gender_identity_Youth,
	"sexual_orientatiion_gender_identity_family_mbr" "v2016".sexual_orientatiion_gender_identity_family_mbr,
	"housing_issues_youth" "v2016".housing_issues_youth,
	"housing_issues_family_mbrily_mbr" "v2016".housing_issues_family_mbr,
	"school_education_issues_youth" "v2016".school_educational_issues_youth,
	"school_education_issues_family_mbr" "v2016".school_education_issues_family_mbr,
	"unemployement_youth" "v2016".unemployment_youth,
	"unemployement_family_mbr" "v2016".unemployement_family_mbr,
	"mental_health_issues_youth" "v2016".mental_health_issues_youth,
	"mental_health_issues_family_mbrily_mbr" "v2016".mental_health_issues_family_mbrily_mbr,
	"health_issues_youth" "v2016".health_issues_youth,
	"health_issues_family_mbrily_mbr" "v2016".health_issues_family_mbr,
	"physical_disability_youth" "v2016".physical_disability_youth,
	"physical_disability_family_mbr" "v2016".physical_disability_family_mbr,
	"mental_disability_youth" "v2016".mental_disability_youth,
	"mental_disability_family_mbrily_mbr" "v2016".mental_disability_family_mbr,
	"abuse_and_neglect_youth" "v2016".abuse_and_neglect_youth,
	"abuse_and_neglect_family_mbr" "v2016".abuse_and_neglect_family_mbr,
	"alcohol_drug_abuse_youth" "v2016".alcohol_drug_abuse_youth,
	"alcohol_drug_abuse_family_mbr" "v2016".alcohol_drug_abuse_family_mbr,
	"insufficient_income_to_support_youth" "v2016".insufficient_income_to_support_youth,
	"active_military_parent" "v2016".active_military_parent,
	"incarcerated_parent" "v2016".incarcerated_parent,
	"incarcerated_parent_status" "v2016".incarcerated_parent_status,
	referral_source integer,
	count_out_reach_referral_approaches integer,
	exchange_for_sex integer,
	"exchange_for_sex_past_three_months" "v2016".exchange_for_sex_past_three_months,
	"count_of_exchange_for_sex" "v2016".count_of_exchange_for_sex,
	"asked_of_forced_to_exchange_for_sex" "v2016".asked_of_forced_to_exchange_for_sex,
	"asked_of_forced_to_exchange_for_sex_past_3_months" "v2016".asked_of_forced_to_exchange_for_sex_past_3_months,
	"work_place_violence_threat" "v2016".work_place_violence_threats,
	"work_place_promise_difference" "v2016".work_place_promise_difference,
	"coerced_to_continue_work" "v2016".coerced_to_continue_work,
	labor_exploit_past_three_months integer,
	 information_date timestamp,
 	 "datacollectionstage" "v2016".datacollectionstage,
	"project_group_code" character varying(8),
  	"date_created" timestamp,
  	"date_created_from_source" timestamp,
  	"date_updated_from_source" timestamp,
  	"date_updated" timestamp,
  	"user_id" uuid,
  	export_id uuid,
  	parent_id uuid,
  	version integer,source_system_id text,
  	deleted boolean DEFAULT false,active boolean DEFAULT true,
  	sync boolean DEFAULT false,
  	  CONSTRAINT entryRHY_pk PRIMARY KEY ("id"),
	  CONSTRAINT "enrollment_entryRHY_fk_key" FOREIGN KEY ("enrollmentid")
      REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

CREATE TABLE "v2016".enrollment_coc
(
	  id uuid NOT NULL,
  	  enrollmentid uuid,
	  client_code character(20),
	  householdid text,
	  information_date timestamp,
	  "datacollectionstage" "v2016".datacollectionstage,
	  project_group_code character varying(8),
	  date_created timestamp,
	  date_updated timestamp,
	  "date_created_from_source" timestamp,
  	  "date_updated_from_source" timestamp,
	  user_id uuid,
	  export_id uuid,
	  parent_id uuid,
	  version integer,source_system_id text,
	  deleted boolean DEFAULT false,active boolean DEFAULT true,
	  sync boolean DEFAULT false,
 		CONSTRAINT "enrollment_coc_pkey" PRIMARY KEY ("id"),
  		CONSTRAINT "enrollment_coc_fk_key" FOREIGN KEY ("enrollmentid")
      	REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      	ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


CREATE TABLE "v2016".service_fa_referral
(
  "id" uuid NOT NULL,
  "enrollmentid" uuid,
  dateProvided timestamp,
  service_category integer,
  funder_list integer,
  type_provided integer,
  other_type_provided text,
  sub_type_provided integer,
  fa_amount numeric(10,2),
  referral_outcome integer,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
   	CONSTRAINT service_fa_referral_pk PRIMARY KEY ("id"),
	CONSTRAINT "service_fa_referral_fk_key" FOREIGN KEY ("enrollmentid")
	REFERENCES v2016.enrollment ("id") MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

-- Table: v2016.last_grade_completed

CREATE TABLE "v2016".schoolstatus
(
  "id" uuid NOT NULL,
  "information_date" timestamp,
  "school_status" "v2016".school_status,
  "enrollmentid" uuid,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



  CONSTRAINT school_status_pk PRIMARY KEY ("id"),
   CONSTRAINT "enrollment_schoolstatus_fk_key" FOREIGN KEY ("enrollmentid")
      REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


CREATE TABLE "v2016".employment
(
  "id" uuid NOT NULL,
  "information_date" timestamp,
  "datacollectionstage" "v2016".datacollectionstage,
  "employed" "v2016".five_val_dk_refused,
  "employment_type" "v2016".employment_type,
  "not_employed_reason" "v2016".not_employed_reason,
  "enrollmentid" uuid,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



	  CONSTRAINT employment_pk PRIMARY KEY ("id"),
	  CONSTRAINT "enrollment_employment_fk_key" FOREIGN KEY ("enrollmentid")
      REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


CREATE TABLE "v2016".health_status
(
  "id" uuid NOT NULL,
  "enrollmentid" uuid,
  "information_date" timestamp,
   "datacollectionstage" "v2016".datacollectionstage,
  "health_category" "v2016".health_category,
  "health_status" "v2016".health_status_type,
  "due_date" timestamp,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



  	  CONSTRAINT health_status_pk PRIMARY KEY ("id"),
      CONSTRAINT "enrollment_health_status_fk_key" FOREIGN KEY ("enrollmentid")
      REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


create table "v2016".contact
(
	id uuid not null,
	contact_date timestamp,
	contact_location v2016.contact_location,
	"enrollmentid" uuid,
	"project_group_code" character varying(8),
  	"date_created" timestamp,
  	"date_created_from_source" timestamp,
  	"date_updated_from_source" timestamp,
  	"date_updated" timestamp,
  	"user_id" uuid,
  	export_id uuid,
  	parent_id uuid,
  	version integer,source_system_id text,
  	deleted boolean DEFAULT false,active boolean DEFAULT true,
  	sync boolean DEFAULT false,



  	  CONSTRAINT contact_pk PRIMARY KEY ("id"),
      CONSTRAINT "enrollment_health_status_fk_key" FOREIGN KEY ("enrollmentid")
      REFERENCES v2016.enrollment ("id") MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- Table: "affiliation"

-- DROP TABLE "affiliation";

CREATE TABLE "v2016".affiliation
(
	  id uuid NOT NULL,
	  projectid uuid,
	  resprojectid text,
	  "project_group_code" character varying(8),
	  "date_created" timestamp,
	  "date_created_from_source" timestamp,
	  "date_updated_from_source" timestamp,
	  "date_updated" timestamp,
	  "user_id" uuid,
	  export_id uuid,
	  parent_id uuid,
	  version integer,source_system_id text,
	  deleted boolean DEFAULT false,active boolean DEFAULT true,
	  sync boolean DEFAULT false,
		CONSTRAINT "affiliation_pkey" PRIMARY KEY (id),
		CONSTRAINT "affiliation_project_fkey" FOREIGN KEY (projectid)
		REFERENCES v2016.project (id) MATCH SIMPLE
		ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

-- table: "projectcoc" changed to CoC

-- drop table "coc";

create table "v2016".coc
(
  id uuid not null,
  coccode text,
   projectid uuid,
  "project_group_code" character varying(8),
   date_created timestamp,
   "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
   date_updated timestamp,
   user_id uuid,
   export_id uuid,
   parent_id uuid,
   version integer,source_system_id text,
   deleted boolean DEFAULT false,active boolean DEFAULT true,
   sync boolean DEFAULT false,



  constraint "coc_pkey" primary key (id),
  constraint "coc_projectid_fkey" foreign key (projectid)
      references v2016.project (id) match simple
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
with (
  oids=false
);


create table "v2016".site
(
	id uuid not null,
	address character varying(100),
	city  character varying(50),
	geocode  integer,
	principal_site "v2016".no_yes,
	--project_coc_id uuid,
	coc_id uuid,
	state "v2016".state,
	zip text,
	"project_group_code" character varying(8),
	date_created timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	date_updated timestamp,
	user_id uuid,
	export_id uuid,
	parent_id uuid,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,
		constraint "site_pkey" primary key (id),
		constraint "site_coc_fkey" foreign key (coc_id)
		references v2016."coc" (id) match simple
		on update no action on delete no action
)
with (
  oids=false
);


create table "v2016".inventory
(
   id uuid not null,
  householdtype "v2016".house_hold_type,
  bedtype "v2016".bed_type,
  availabilty "v2016".availability,
  unitinventory integer,
  ch_bed_inventory integer,
  vet_bed_inventory integer,
  youth_bed_inventory integer,
  youth_age_group integer,
  inventorystartdate timestamp,
  inventoryenddate timestamp,
  hmisparticipatingbeds integer,
  --project_coc_id uuid,
  coc_id uuid,
  "project_group_code" character varying(8),
  date_created timestamp,
  date_updated timestamp,
   "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  user_id uuid,
  informationDate timestamp,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



  constraint "inventory_pkey" primary key (id),
  constraint "inventory_cocid_fkey" foreign key (coc_id)
      references v2016."coc" (id) match simple
      on update no action on delete no action
)
with (
  oids=false
);


-- table: "funder"

-- drop table "funder";

create table  "v2016".funder
(
  "id"  uuid not null,
  "enddate" timestamp,
  "funder" "v2016".federal_partner_components,
  "grantid" uuid,
  "projectid" uuid,
  "startdate" timestamp,
  "project_group_code" character varying(8),
  date_created timestamp,
  date_updated timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  user_id uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



      constraint "funder_pkey" primary key ("id"),
      constraint "funder_projectid_fkey" foreign key ("projectid")
      references v2016.project (id) match simple
      on update no action on delete no action
)
with (
  oids=false
);


CREATE TABLE "v2016".rhybcp_status
(
  "id" uuid NOT NULL,
  "status_date" timestamp,
  "fysb_youth" "v2016".no_yes,
  "reason_no_services" "v2016".fysb_rsn_not_providing_srvcs,
  "enrollmentid" uuid,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
	CONSTRAINT rhybcp_status_pk PRIMARY KEY ("id"),
	CONSTRAINT "enrollment_rhybcp_status_fk_key" FOREIGN KEY ("enrollmentid")
	REFERENCES v2016.enrollment ("id") MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);


-- table: "medicalassistance"

-- drop table "medicalassistance";

create table "v2016".medicalassistance
(
	id uuid not null,
	hivaidsassistance "v2016".five_val_dk_refused,
  	nohivaidsassistancereason "v2016".no_medical_assistance_reason,
  	adap "v2016".five_val_dk_refused,
  	noadapreason "v2016".no_medical_assistance_reason,
  	information_date timestamp,
  	"datacollectionstage" "v2016".datacollectionstage,
	enrollmentid uuid,
    "project_group_code" character varying(8),
    "date_created" timestamp,
    "date_updated" timestamp,
     "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
    "user_id" uuid,
	  export_id uuid,
	  parent_id uuid,
	  version integer,source_system_id text,
	  deleted boolean DEFAULT false,active boolean DEFAULT true,
	  sync boolean DEFAULT false,



	  constraint "medicalassistance_pkey" primary key (id),
	  constraint "medicalassistance_enrollmentid_fkey" foreign key (enrollmentid)
      references v2016.enrollment ("id") match simple
      on update no action on delete no action

)
with (
  oids=false
);

-- table: "domesticviolence"

-- drop table "domesticviolence";

create table "v2016".domesticviolence
(
  "id"  uuid not null,
  "domesticviolencevictim" "v2016".five_val_dk_refused,
  "enrollmentid" uuid,
  "whenoccurred" "v2016".when_dom_violence_occurred,
  currently_fleeing integer,
  information_date timestamp,
  "datacollectionstage" "v2016".datacollectionstage,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
   "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



  		constraint "domesticviolence_pkey" primary key ("id"),
  		constraint "domesticviolence_enrollmentid_fkey" foreign key ("enrollmentid")
      references v2016.enrollment ("id") match simple
      on update no action on delete no action
)
with (
  oids=false
);

-- table: "disabilities"

-- drop table "disabilities";

create table "v2016".disabilities
(
  "id" uuid not null,
  "disabilitytype" "v2016".disability_type,
  "disabilityresponse" integer,
  "indefiniteandimpairs" "v2016".five_val_dk_refused,
  "documentationonfile" "v2016".no_yes,
  "receivingservices" "v2016".five_val_dk_refused,
  "pathhowconfirmed" "v2016".path_how_confirmed,
  "pathsmiinformation" "v2016".path_smi_info_how_confirmed,
  "enrollmentid" uuid,
  tcellcountavailable integer,
  tcellcount integer,
  tcellcountsource character(8),
  viral_load_available integer,
  viral_load integer,
  viral_load_source character(8),
  information_date timestamp,
  "datacollectionstage" "v2016".datacollectionstage,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
   "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



	  constraint "disabilities_pkey" primary key ("id"),
	  constraint "disabilities_enrollmentid_fkey" foreign key ("enrollmentid")
      references v2016.enrollment ("id") match simple
      on update no action on delete no action
)
with (
  oids=false
);
-- table: "residentialmoveindate"

-- drop table "residentialmoveindate";

create table  "v2016".residentialmoveindate
(
  	id uuid not null,
	inpermanenthousing "v2016".no_yes,
  	enrollmentid uuid,
  	residentialmoveindate timestamp,
    "project_group_code" character varying(8),
  	"date_created" timestamp,
  	"date_created_from_source" timestamp,
   	"date_updated_from_source" timestamp,
  	"date_updated" timestamp,
  	"user_id" uuid,
  	export_id uuid,
  	parent_id uuid,
  	version integer,source_system_id text,
  	deleted boolean DEFAULT false,active boolean DEFAULT true,
  	sync boolean DEFAULT false,



  	  constraint "residentialmoveindate_pkey" primary key (id),
      constraint "residentialmoveindate_enrollmentid_fkey" foreign key (enrollmentid)
      references v2016.enrollment ("id") match simple
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
with (
  oids=false
);

-- table: "dateofengagement"

-- drop table "dateofengagement";

create table  "v2016".dateofengagement
(
  	"id" uuid not null,
	"dateofengagement" timestamp,
	"enrollmentid" uuid,
	"project_group_code" character varying(8),
	"date_created" timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	"date_updated" timestamp,
	"user_id" uuid,
	export_id uuid,
	parent_id uuid,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,



  		constraint "dateofengagement_pkey" primary key ("id"),
  		constraint "dateofengagement_enrollmentid_fkey" foreign key ("enrollmentid")
      	references v2016.enrollment ("id") match simple
      	on update no action on delete no action
)
with (
  oids=false
);

create table  "v2016".entryRHSP
(
  	"id" uuid not null,
	worst_housing_situation integer,
	"enrollmentid" uuid,
	"project_group_code" character varying(8),
	"date_created" timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	"date_updated" timestamp,
	"user_id" uuid,
	export_id uuid,
	parent_id uuid,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,



  		constraint "entryRHSP_pkey" primary key ("id"),
  		constraint "entryRHSP_enrollmentid_fkey" foreign key ("enrollmentid")
      	references v2016.enrollment ("id") match simple
      	on update no action on delete no action
)
with (
  oids=false
);

create table  "v2016".education
(
  	"id" uuid not null,
	lastgradecompleted "v2016".last_grade_completed,
	"school_status" "v2016".school_status,
	"enrollmentid" uuid,
	 information_date timestamp,
     "datacollectionstage" "v2016".datacollectionstage,
	"project_group_code" character varying(8),
	"date_created" timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	"date_updated" timestamp,
	"user_id" uuid,
	export_id uuid,
	parent_id uuid,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,
  		constraint "education_pkey" primary key ("id"),
  		constraint "education_fkey" foreign key ("enrollmentid")
      	references v2016.enrollment ("id") match simple
      	on update no action on delete no action
)
with (
  oids=false
);

-- drop table "incomeandsources";

create table "v2016".incomeandsources
(
  alimony "v2016".no_yes,
  alimonyamount numeric(15,3),
  childsupport "v2016".no_yes,
  childsupportamount numeric(15,3),
  earned "v2016".no_yes,
  earnedamount numeric(15,3),
  ga "v2016".no_yes,
  gaamount numeric(15,3),
  id uuid not null,
  incomefromanysource "v2016".five_val_dk_refused,
  othersource "v2016".no_yes,
  othersourceamount numeric(15,3),
  othersourceidentify text,
  pension "v2016".no_yes,
  pensionamount numeric(15,3),
  privatedisability "v2016".no_yes,
  privatedisabilityamount numeric(15,3),
  enrollmentid uuid,
  socsecretirement "v2016".no_yes,
  socsecretirementamount numeric(15,3),
  ssdi "v2016".no_yes,
  ssdiamount numeric(15,3),
  ssi "v2016".no_yes,
  ssiamount numeric(15,3),
  tanf "v2016".no_yes,
  tanfamount numeric(15,3),
  totalmonthlyincome numeric(15,3),
  unemployment "v2016".no_yes,
  unemploymentamount numeric(15,3),
  vadisabilitynonservice "v2016".no_yes,
  vadisabilitynonserviceamount numeric(15,3),
  vadisabilityservice "v2016".no_yes,
  vadisabilityserviceamount numeric(15,3),
  workerscomp "v2016".no_yes,
  workerscompamount numeric(15,3),
   information_date timestamp,
  "datacollectionstage" "v2016".datacollectionstage,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
    "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,



  constraint "incomeandsources_pkey" primary key (id),
  constraint "incomeandsources_enrollmentid_fkey" foreign key (enrollmentid)
      references v2016.enrollment ("id") match simple
      on update no action on delete no action
)
with (
  oids=false
);



-- drop table "noncashbenefits";

create table "v2016".noncashbenefits
(
	id uuid not null,
	benefitsfromanysource "v2016".five_val_dk_refused,
  	othersource "v2016".no_yes,
  	othersourceidentify text,
  	othertanf "v2016".no_yes,
  	enrollmentid uuid,
  	rentalassistanceongoing "v2016".no_yes,
  	rentalassistancetemp "v2016".no_yes,
  	snap "v2016".no_yes,
  	tanfchildcare "v2016".no_yes,
  	tanftransportation "v2016".no_yes,
  	wic "v2016".no_yes,
  	information_date timestamp,
    "datacollectionstage" "v2016".datacollectionstage,
  	"project_group_code" character varying(8),
  	"date_created" timestamp,
  	"date_created_from_source" timestamp,
    "date_updated_from_source" timestamp,
  	"date_updated" timestamp,
  	"user_id" uuid,
  	export_id uuid,
  	parent_id uuid,
  	version integer,source_system_id text,
  	deleted boolean DEFAULT false,active boolean DEFAULT true,
  	sync boolean DEFAULT false,



	  constraint "noncashbenefits_pkey" primary key (id),
	  constraint "noncashbenefits_enrollmentid_fkey" foreign key (enrollmentid)
      references v2016.enrollment ("id") match simple
      on update no action on delete no action
)
with (
  oids=false
);

-- table: "healthinsurance"

-- drop table "healthinsurance";

create table "v2016".healthinsurance
(
  "id" uuid not null,
  "insurancefromanysource" "v2016".five_val_dk_refused,
  "medicaid" "v2016".no_yes,
  "nomedicaidreason" "v2016".no_health_insurance_reason,
  "medicare" "v2016".no_yes,
  "nomedicarereason" "v2016".no_health_insurance_reason,
  "schip" "v2016".no_yes,
  "noschipreason" "v2016".no_health_insurance_reason,
  "vamedicalservices" "v2016".no_yes,
  "novamedreason" "v2016".no_health_insurance_reason,
  "employerprovided" integer,
  "noemployerprovidedreason" "v2016".no_health_insurance_reason,
  "cobra" integer,
  "nocobrareason" "v2016".no_health_insurance_reason,
  "privatepay" "v2016".no_yes,
  "noprivatepayreason" "v2016".no_health_insurance_reason,
  "statehealthinadults" "v2016".no_yes,
  "nostatehealthinsreason" "v2016".no_health_insurance_reason,
  other_insurance "v2016".no_yes,
  other_insurance_identify text,
  "indianhealthservices" "v2016".no_yes,
  "noindianhealthservicesreason" "v2016".no_health_insurance_reason,
  "enrollmentid" uuid,
   information_date timestamp,
  "datacollectionstage" "v2016".datacollectionstage,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
      constraint "healthinsurance_pkey" primary key ("id"),
	  constraint "healthinsurance_enrollmentid_fkey" foreign key ("enrollmentid")
      references v2016.enrollment ("id") match simple
      on update no action on delete no action
)
with (
  oids=false
);

create table "v2016".exit
(
	"id" uuid not null,
	"destination" "v2016".destination,
	"exitdate" timestamp,
	"otherdestination" text,
	"enrollmentid" uuid,
	"project_group_code" character varying(8),
	"date_created" timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	"date_updated" timestamp,
	"user_id" uuid,
	export_id uuid,
	parent_id uuid,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,
		constraint "exit_pkey" primary key ("id"),
		constraint "exit_enrollmentid_fkey" foreign key ("enrollmentid")
		references v2016.enrollment ("id") match simple
		on update no action on delete no action
)
with (
  oids=false
);

create table "v2016".exitPath
(
	"id" uuid not null,
	"connection_with_soar" "v2016".connection_with_soar,
	"exitid" uuid,
	"project_group_code" character varying(8),
	"date_created" timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	"date_updated" timestamp,
	"user_id" uuid,
	export_id uuid,
	parent_id uuid,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,
		constraint "exit_path_pkey" primary key ("id"),
		constraint "exit_fkey" foreign key ("exitid")
		references v2016.exit(id) match simple
		on update no action on delete no action
)
with (
  oids=false
);

---Done--
create table  "v2016".exithousingassessment
(
  "id" uuid not null,
  "exitid" uuid,
  "housingassessment" "v2016".housing_assmnt_exit,
  "subsidyinformation" "v2016".subsidy_information,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
	  constraint "exithousingassessment_pkey" primary key ("id"),
	  constraint "exithousingassessment_fkey" foreign key ("exitid")
      references v2016.exit(id) match simple
      on update no action on delete no action
)
with (
  oids=false
);


create table "v2016".exitRHY
(
	"id" uuid not null,
	"exitid" uuid,
	"project_completion_status" "v2016".project_completion_status,
	"early_exit_reason" "v2016".early_exit_reason,
	"family_reunification_achieved" "v2016".family_reunification_achieved,
	"written_after_care_plan" "v2016".written_after_care_plan,
	"assistance_main_stream_benefits" "v2016".assistance_main_stream_benefits,
	"permenant_housing_placement" "v2016".permanent_housing_placement,
	"temp_shelter_placement" "v2016".temp_shelter_placement,
	"exit_counseling" "v2016".exit_counseling,
	"further_followup_services" "v2016".further_followup_services,
	"scheduled_followup_contacts" "v2016".scheduled_followup_contacts,
	"resource_package" "v2016".resource_package,
	"other_aftercare_plan_or_action" "v2016".other_aftercare_plan_or_action,
	"project_group_code" character varying(8),
	"date_created" timestamp,
	"date_created_from_source" timestamp,
	"date_updated_from_source" timestamp,
	"date_updated" timestamp,
	"user_id" uuid,
	export_id uuid,
	parent_id uuid,
	version integer,source_system_id text,
	deleted boolean DEFAULT false,active boolean DEFAULT true,
	sync boolean DEFAULT false,
		constraint "exitRHY_pkey" primary key ("id"),
		constraint "exitRHY_fkey" foreign key ("exitid")
		references v2016.exit("id") match simple
		on update no action on delete no action
)
with (
  oids=false
);


-- table: "exitplansactions"

-- drop table "exitplansactions";


create table "v2016".housingassessmentdisposition
(
  "id" uuid not null,
  "assessmentdisposition" "v2016".assessment_disposition,
  "exitid" uuid,
  "otherdisposition" text,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_created_from_source" timestamp,
  "date_updated_from_source" timestamp,
  "date_updated" timestamp,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
	  constraint "housingassessmentdisposition_pkey" primary key ("id"),
	  constraint "housingassessmentdisposition_exitid_fkey" foreign key ("exitid")
      references v2016."exit" ("id") match simple
      on update no action on delete no action
)
with (
  oids=false
);


CREATE TABLE "v2016".hud_coc_report_question_7(
id bigint primary key NOT NULL,
first_name bigint,
last_name bigint ,
ssn bigint ,
dob bigint ,
race bigint ,
ethnicity bigint ,
gender bigint ,
veteran_status bigint ,
disabling_cond bigint ,
residence_prior_to_entry bigint ,
zip_lpa bigint ,
housing_stat_entry bigint ,
income_entry bigint ,
income_exit bigint ,
non_cash_benefits_entry bigint ,
non_cash_benefits_exit bigint ,
physical_disability_entry bigint ,
devlopmental_disability_entry bigint ,
chronic_health_condition_entry bigint ,
hiv_aids_entry bigint ,
mental_health_entry bigint ,
substance_abuse_entry bigint ,
domestic_violence_entry bigint ,
destination bigint ,
total_clients bigint ,
total_adults bigint ,
total_unaccompanied_youth bigint ,
total_leavers bigint ,
del_flag char(3),
status_flag char(3)
);


--CREATE SEQUENCE "v2016".bulk_upload_id_seq START 1;

create table "v2016".bulk_upload_activity
(
 id serial not null,
 bulk_upload_id bigint,
 table_name character varying(100),
 records_processed bigint,
 description text,
  "project_group_code" character varying(8),
  "date_created" timestamp,
  "date_updated" timestamp,
  inserted  bigint,
  updated bigint,
  "user_id" uuid,
  export_id uuid,
  parent_id uuid,
  version integer,source_system_id text,
  deleted boolean DEFAULT false,active boolean DEFAULT true,
  sync boolean DEFAULT false,
     CONSTRAINT export_fkey FOREIGN KEY (export_id)
      REFERENCES v2016.export (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT bulk_upload_activity_pk PRIMARY KEY ("id")
);


DROP TABLE IF EXISTS v2016.bulk_upload_error;

CREATE TABLE v2016.bulk_upload_error
(
  id bigint NOT NULL,
  model_id uuid,
  bulk_upload_ui bigint,
  table_name text,
  project_group_code character varying(8),
  source_system_id text,
  type character varying(8),
  error_description text,
  date_created timestamp without time zone,
  CONSTRAINT bulk_upload_error_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

-- DROP SEQUENCE v2016.error_sequence;

CREATE SEQUENCE v2016.error_sequence
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
