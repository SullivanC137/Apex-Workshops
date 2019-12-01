prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_default_workspace_id=>1581493274460380
);
end;
/
-- Oracle Application Express 18.2.0.00.12 SQL Script Export file
-- Exported 02:45 Tuesday May 28, 2019 by: OBE
-- Scripts included:
--      OBE
 
begin wwv_flow.g_user := nvl(wwv_flow.g_user,'OBE'); end;
/
prompt --application/sql/scripts
prompt ...exporting script file
--
begin
    wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
    wwv_flow_api.g_varchar2_table(1) := '64726F70207461626C65206361725F6465636C61726174696F6E733B0D0A64726F70207461626C65206361725F6D61696E745F636F6D6D656E74733B0D0A64726F70207461626C65206361725F6D61696E74616E616E63653B0D0A64726F70207461626C';
    wwv_flow_api.g_varchar2_table(2) := '6520636172733B0D0A64726F70207461626C652063617274797065733B0D0A64726F70207461626C6520656D705F636172733B';
end;
/
 
declare
  l_name   varchar2(255);
begin
  l_name   := '5782304895662681/dropCarDatamodel01';
  wwv_flow_api.import_script(
    p_name          => l_name,
    p_varchar2_table=> wwv_flow_api.g_varchar2_table,
    p_pathid=> null,
    p_filename=> 'dropCarDatamodel01',
    p_title=> 'dropCarDatamodel01',
    p_mime_type=> 'text/plain',
    p_dad_charset=> '',
    p_deleted_as_of=> to_date('00010101000000','YYYYMMDDHH24MISS'),
    p_content_type=> 'BLOB',
    p_language=> '',
    p_description=> '',
    p_file_type=> 'SCRIPT',
    p_file_charset=> 'utf-8');
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
--commit;
end;
/
set verify on feedback on define on
prompt  ...done
