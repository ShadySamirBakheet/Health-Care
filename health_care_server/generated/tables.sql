--
-- Class Patient as table patinet
--
DROP TABLE patinet;

CREATE TABLE "patinet" (
  "id" serial,
  "name" text NOT NULL,
  "age" double precision NOT NULL,
  "gender" boolean NOT NULL,
  "healthyReport" text NOT NULL,
  "healthyReportShort" text NOT NULL,
  "reports" json
);

ALTER TABLE ONLY "patinet"
  ADD CONSTRAINT patinet_pkey PRIMARY KEY (id);



Class User as table users
--
DROP TABLE users;

CREATE TABLE "users" (
  "id" serial,
  "name" text NOT NULL,
  "email" text NOT NULL,
  "gender" boolean NOT NULL,
  "password" text NOT NULL,
  "authKey" text
);

ALTER TABLE ONLY "users"
  ADD CONSTRAINT users_pkey PRIMARY KEY (id);


