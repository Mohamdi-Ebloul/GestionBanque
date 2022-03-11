--------------------------------------------------------
--  Fichier cr�� - lundi-f�vrier-21-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence COMPTE_ID
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."COMPTE_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1001 CACHE 1000 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ID_AGENT
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."ID_AGENT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1001 CACHE 1000 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence ID_CLIENT
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."ID_CLIENT"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1001 CACHE 1000 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence NUMERO
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."NUMERO"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1000001 CACHE 1000000 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence OPERATION_ID
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."OPERATION_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1001 CACHE 1000 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STATUTCOMPTE_ID
--------------------------------------------------------

   CREATE SEQUENCE  "SYSTEM"."STATUTCOMPTE_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1001 CACHE 1000 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table AGENT
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."AGENT" 
   (	"ID_AGENT" NUMBER(*,0), 
	"NOM" VARCHAR2(80 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table CLIENT
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."CLIENT" 
   (	"ID_CLIENT" NUMBER(*,0), 
	"NOM" VARCHAR2(50 BYTE), 
	"PRENOM" VARCHAR2(50 BYTE), 
	"PHONE" NUMBER(*,0), 
	"EMAIL" VARCHAR2(80 BYTE)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table COMPTE
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."COMPTE" 
   (	"COMPTE_ID" NUMBER(*,0), 
	"DATE_CREATION" DATE, 
	"CURRENT_BALANCE" FLOAT(126) DEFAULT 0, 
	"ID_CLIENT" NUMBER(*,0), 
	"NUMERO" NUMBER(*,0) DEFAULT NULL
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table OPERATION
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."OPERATION" 
   (	"OPERATION_ID" NUMBER(*,0), 
	"AMOUNT" FLOAT(126), 
	"ACTION" VARCHAR2(100 BYTE), 
	"DATE_OPERATION" DATE, 
	"ID_AGENT" NUMBER(*,0), 
	"COMPTE_ID" NUMBER(*,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table STATUTCOMPTE
--------------------------------------------------------

  CREATE TABLE "SYSTEM"."STATUTCOMPTE" 
   (	"STATUTCOMPTE_ID" NUMBER, 
	"STATU" VARCHAR2(100 BYTE), 
	"COMPTE_ID" NUMBER(*,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into SYSTEM.AGENT
SET DEFINE OFF;

--------------------------------------------------------
--  DDL for Procedure ACTIVERCOMPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."ACTIVERCOMPT" 
(numcompte number)
is 
idcopte number;
begin 
select compte_id into idcopte from compte WHERE numero=numcompte;
update statutcompte set statu='active' WHERE compte_id=idcopte;
commit;

exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure ADDCLIENTS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."ADDCLIENTS" 
(id NUMBER,nomcli varchar2,prenomcli varchar2, tele number, emailcli varchar2)
is 
begin 
insert into client values (id ,nomcli,prenomcli,tele, emailcli);
commit;

exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure AFFICHERINFO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."AFFICHERINFO" 
(numcompte number)
is 
nomcl VARCHAR2(100) ;prenomcl VARCHAR2(100);tel number;emailcl VARCHAR2(100);
solde number;status VARCHAR2(100);
begin 
select current_balance ,statu,nom,prenom,phone,email into solde,status,nomcl,prenomcl,tel,emailcl from compte,statutcompte,client WHERE numero=numcompte 
and compte.compte_id=statutcompte.compte_id and compte.id_client=client.id_client;

dbms_output.put_line('Tout les information du Client' );
dbms_output.put_line('Nom:   '||nomcl);
dbms_output.put_line('Prenom:   '||prenomcl);
dbms_output.put_line('Telephone:   '||tel);
dbms_output.put_line('Email:   '||emailcl);
dbms_output.put_line('Numero compte:  '||numcompte);
dbms_output.put_line('Solde:  '||solde);
dbms_output.put_line('Status:  '||status);
commit;

exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure AJOUTAGENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."AJOUTAGENT" 
(nom varchar)
is 
begin 
insert into agent values (ID_AGENT.nextval ,nom);
commit;
exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure CREEAT_COMPTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."CREEAT_COMPTE" 
(nomcli varchar2,prenomcli varchar2, tele number, emailcli varchar2)
is 
last_id_client number;
last_id_compte number;
begin 
insert into client values (id_client.nextval ,nomcli,prenomcli,tele, emailcli);
select max(id_client) into last_id_client from client;
insert into compte VALUES (compte_id.nextval,(to_date(sysdate, 'yyyy/mm/dd hh24:mi:ss')),0,last_id_client,numero.nextval);
select max(compte_id) into last_id_compte from compte;
insert into statutcompte values (STATUTCOMPTE_ID.nextval,'active',last_id_compte);
commit;

exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure DEPOSER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."DEPOSER" 
(numcompte number,montant decimal, id_agent number)
is 
idcopte number;
begin 
select compte_id into idcopte from compte WHERE numero=numcompte;
update compte set current_balance=current_balance+montant WHERE numero=numcompte;
insert into operation values (OPERATION_ID.nextval ,montant,'versement',(to_date(sysdate, 'yyyy/mm/dd hh24:mi:ss')),id_agent,idcopte);
commit;

exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure DESACTIVERCOMPT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."DESACTIVERCOMPT" 
(numcompte number)
is 
idcopte number;
begin 
select compte_id into idcopte from compte WHERE numero=numcompte;
update statutcompte set statu='noactive' WHERE compte_id=idcopte;
commit;

exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure MODIFIEREAGENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."MODIFIEREAGENT" (val_col varchar,idcl number )
is

begin

 update agent set nom=val_col where id_agent=idcl;

exception 
   when others then 
   dbms_output.put_line('Ereur ');
   dbms_output.put_line(sqlcode);
   dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure MODIFIERECLIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."MODIFIERECLIENT" (nomcol varchar ,val_col varchar,idcl number)
is

begin
if nomcol='nom' then
 update client set nom=val_col where id_client=idcl;
 end if;
if nomcol='prenom' then
 update client set prenom=val_col where id_client=idcl;
 end if;
if nomcol='phone' then
 update client set phone=val_col where id_client=idcl;
 end if;
if nomcol='email' then
 update client set email=val_col where id_client=idcl;
 end if;
exception 
   when others then 
   dbms_output.put_line('Ereur ');
   dbms_output.put_line(sqlcode);
   dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure RETIER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."RETIER" 
(numcompte number,montant decimal, id_agent number)
is 
idcopte number;
balance number;
begin 
select current_balance into balance from compte WHERE numero=numcompte;
if balance < montant then
dbms_output.put_line('impossible de retirer');
else
select compte_id into idcopte from compte WHERE numero=numcompte;
update compte set current_balance=current_balance-montant WHERE numero=numcompte;
insert into operation values (OPERATION_ID.nextval ,montant,'retirer',(to_date(sysdate, 'yyyy/mm/dd hh24:mi:ss')),id_agent,idcopte);
commit;
end if;
exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure SUPCLIENT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."SUPCLIENT" (idclient number)
is
cid number;
begin
select compte_id into cid from compte where id_client=idclient;
delete  from statutcompte where compte_id=cid;
delete  from compte where id_client=idclient;
 delete  from client where id_client=idclient;
 
exception 
   when others then 
   dbms_output.put_line('Ereur ');
   dbms_output.put_line(sqlcode);
   dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Procedure TRANSFER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."TRANSFER" 
(NumCompteExpd number,NumCompteDest number,montant decimal, id_agent number)
is 
idcopte number;
balance number;
begin 
retier(NumCompteExpd,montant,id_agent);
deposer(NumCompteDest,montant,id_agent);
end;

/
--------------------------------------------------------
--  DDL for Procedure VERFIERCOMPTE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "SYSTEM"."VERFIERCOMPTE" 
(numcompte number)
is 
solde number;
begin 
select current_balance into solde from compte WHERE numero=numcompte;
dbms_output.put_line('solde: '||solde);
commit;

exception 
when OTHERS THEN 
dbms_output.put_line('Error');
dbms_output.put_line(sqlcode);
dbms_output.put_line(sqlerrm);
end;

/
--------------------------------------------------------
--  DDL for Function CONTER
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "SYSTEM"."CONTER" (nom_t IN varchar2)
  return number
is
  nb number;
begin
  execute immediate 'select count(*) from ' || nom_t into nb;

  return nb;
exception 
   when others then 
   dbms_output.put_line('Ereur ');
   dbms_output.put_line(sqlcode);
   dbms_output.put_line(sqlerrm);
end;

/
