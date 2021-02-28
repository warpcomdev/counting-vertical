/*
 * Copyright 2021 Telefónica Soluciones de Informática y Comunicaciones de España, S.A.U.
 * PROJECT: Urbo2
 *
 * This software and / or computer program has been developed by Telefónica Soluciones
 * de Informática y Comunicaciones de España, S.A.U (hereinafter TSOL) and is protected
 * as copyright by the applicable legislation on intellectual property.
 *
 * It belongs to TSOL, and / or its licensors, the exclusive rights of reproduction,
 * distribution, public communication and transformation, and any economic right on it,
 * all without prejudice of the moral rights of the authors mentioned above. It is expressly
 * forbidden to decompile, disassemble, reverse engineer, sublicense or otherwise transmit
 * by any means, translate or create derivative works of the software and / or computer
 * programs, and perform with respect to all or part of such programs, any type of exploitation.
 *
 * Any use of all or part of the software and / or computer program will require the
 * express written consent of TSOL. In all cases, it will be necessary to make
 * an express reference to TSOL ownership in the software and / or computer
 * program.
 *
 * Non-fulfillment of the provisions set forth herein and, in general, any violation of
 * the peaceful possession and ownership of these rights will be prosecuted by the means
 * provided in both Spanish and international law. TSOL reserves any civil or
 * criminal actions it may exercise to protect its rights.
 */

/*
 * In addition, note that the name of the database to which the schema belongs must match
 * the parameter used by the cygnus-ngsi.sinks.postgis-sink.postgis_database persisting
 * the data.
 */

\set counting_access 'counting_access'
\set counting_zone 'counting_zone'
\set counting_access_lastdata 'counting_access_lastdata'
\set counting_zone_lastdata 'counting_zone_lastdata'


\set idx_suffix_counting_access_calculated_index 'counting_access_calculated'
\set idx_suffix_counting_access_zoneref_index 'counting_access_zoneref'
\set idx_suffix_counting_access_entityid_calculated 'counting_access_entityid_calculated'
\set idx_suffix_counting_zone_calculated_index 'counting_zone_calculated'
\set idx_suffix_counting_zone_entityid_calculated 'counting_zone_entityid_calculated'

\set separador '_'
\set scope :scope
\set scope_sep :scope:separador

SELECT CASE
  WHEN :'scope'= ':scope'
  THEN ''
  ELSE :'scope_sep'
END AS "scope"  \gset

CREATE EXTENSION postgis;


--
-- Name: counting_access; Type: TABLE; Schema: ---; Owner: urbo
--

DROP TABLE IF EXISTS :target_schema.:scope:counting_access CASCADE;
CREATE TABLE IF NOT EXISTS :target_schema.:scope:counting_access (
    entityid text NOT NULL,
    entitytype text NOT NULL,
    fiwareservicepath text NOT NULL,
    recvtime text NOT NULL,
    timeinstant timestamp with time zone NOT NULL,
    timeinstant_md text,
    zoneref text,
    zoneref_md text,
    source text,
    source_md text,
    sourcetype text,
    sourcetype_md text,
    sourcepath text,
    sourcepath_md text,
    period double precision,
    period_md text,
    name text,
    name_md text,
    description text,
    description_md text,
    address text,
    address_md text,
    location geometry(Point, 4326),
    location_md text,
    areaserved geometry(geometry, 4326),
    areaserved_md text,
    category text,
    category_md text,
    width double precision,
    width_md text,
    "length" double precision,
    length_md text,
    capacity double precision,
    capacity_md text,
    numberofincoming double precision,
    numberofincoming_md text,
    numberofoutgoing double precision,
    numberofoutgoing_md text,
    occupancy double precision,
    occupancy_md text,
    percentageofoccupation double precision,
    percentageofoccupation_md text,
    datecalculatedoccupancy timestamp with time zone,
    datecalculatedoccupancy_md text,

    PRIMARY KEY (entityid, datecalculatedoccupancy)
);

CREATE INDEX :target_schema:scope:idx_suffix_counting_access_calculated_index ON :target_schema.:scope:counting_access (datecalculatedoccupancy);
CREATE INDEX :target_schema:scope:idx_suffix_counting_access_entityid_calculated ON :target_schema.:scope:counting_access (entityid, datecalculatedoccupancy DESC NULLS LAST);
CREATE INDEX :target_schema:scope:idx_suffix_counting_access_zoneref_index ON :target_schema.:scope:counting_access (zoneref);


--
-- Name: counting_access_lastdata; Type: VIEW; Schema: sc_santander; Owner: urbo
--

DROP VIEW IF EXISTS :target_schema.:scope:counting_access_lastdata;
CREATE VIEW :target_schema.:scope:counting_access_lastdata AS
SELECT *
FROM (
    SELECT *,
        row_number() OVER (PARTITION BY entityid ORDER BY datecalculatedoccupancy DESC NULLS LAST) AS rn
    FROM :target_schema.:scope:counting_access
    WHERE datecalculatedoccupancy >= NOW() - INTERVAL '7 days'
) t
WHERE (t.rn = 1)
ORDER BY t.entityid DESC;


--
-- Name: beaches_access_public_lastdata; Type: VIEW; Schema: sc_santander; Owner: urbo
--

DROP TABLE IF EXISTS :target_schema.:scope:counting_zone CASCADE;
CREATE TABLE IF NOT EXISTS :target_schema.:scope:counting_zone (
    entityid text NOT NULL,
    entitytype text NOT NULL,
    fiwareservicepath text NOT NULL,
    recvtime text NOT NULL,
    timeinstant timestamp with time zone NOT NULL,
    timeinstant_md text,
    source text,
    source_md text,
    sourcetype text,
    sourcetype_md text,
    sourcepath text,
    sourcepath_md text,
    period double precision,
    period_md text,
    name text,
    name_md text,
    description text,
    description_md text,
    address text,
    address_md text,
    location geometry(Point, 4326),
    location_md text,
    areaserved geometry(geometry, 4326),
    areaserved_md text,
    category text,
    category_md text,
    width double precision,
    width_md text,
    "length" double precision,
    length_md text,
    capacity double precision,
    capacity_md text,
    numberofincoming double precision,
    numberofincoming_md text,
    numberofoutgoing double precision,
    numberofoutgoing_md text,
    occupancy double precision,
    occupancy_md text,
    percentageofoccupation double precision,
    percentageofoccupation_md text,
    datecalculatedoccupancy timestamp with time zone,
    datecalculatedoccupancy_md text,

    PRIMARY KEY (entityid, datecalculatedoccupancy)
);

CREATE INDEX :target_schema:scope:idx_suffix_counting_zone_calculated_index ON :target_schema.:scope:counting_zone (datecalculatedoccupancy);
CREATE INDEX :target_schema:scope:idx_suffix_counting_zone_entityid_calculated ON :target_schema.:scope:counting_zone (entityid, datecalculatedoccupancy DESC NULLS LAST);


--
-- Name: counting_zone_lastdata; Type: VIEW; Schema: sc_santander; Owner: urbo
--

DROP VIEW IF EXISTS :target_schema.:scope:counting_zone_lastdata;
CREATE VIEW :target_schema.:scope:counting_zone_lastdata AS
SELECT *
FROM (
    SELECT *,
        row_number() OVER (PARTITION BY entityid ORDER BY datecalculatedoccupancy DESC NULLS LAST) AS rn
    FROM :target_schema.:scope:counting_zone
    WHERE datecalculatedoccupancy >= NOW() - INTERVAL '7 days'
) t
WHERE (t.rn = 1)
ORDER BY t.entityid DESC;
