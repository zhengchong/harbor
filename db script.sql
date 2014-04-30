-- User Validated System

create table pl_user_info(
user_id				number not null primary key,		--login with employee number
user_name			varchar2(20) not null,
user_pswd			varchar2(50) not null,
user_creator		number not null,
user_creation_time	varchar2(20) not null,
user_latest_editor	number not null,
user_updated_time	date not null,
user_record_status	number default null				-- null is not deleted, 0 is deleted
);

create table pl_user_role_info(
user_role_gkey				number not null primary key,
user_role_role_id			number not null,
user_role_user_id			number not null,
user_role_creator			number not null,
user_role_creation_time		date not null,
user_role_latest_editor		number not null,
user_role_updeted_time		date not null,
user_role_record_status		number default null				-- null is not deleted, 0 is deleted
);

create table pl_role(
role_id					number not null primary key,
role_name				varchar2(20) not null,
role_creator			number not null,
role_creation_time		date not null,
role_latest_editor		number not null,
role_updated_time		date not null,
role_record_status		number default null				-- null is not deleted, 0 is deleted
);

create table pl_function_priviledge(
func_priv_key					number not null primary key,
func_priv_role_id				number not null,
func_priv_function_para_key		number not null,
func_priv_function_enable		number default 1 not null,		-- 1 is enable, 0 is disable
func_priv_control_enable		number default 1 not null,		-- 1 is enable, 0 is disable
func_priv_control_visable		number default 1 not null,		-- 1 is visable, 0 is not visable
func_priv_record_status			number default null,			-- null is not deleted, 0 is deleted
func_priv_creation_time			date not null,
func_priv_creator				number not null,
func_priv_latest_editor			number not null,
func_priv_updated_time			date not null
);

create table pl_func_parameters(
func_para_gkey					number not null primary key,
func_para_menu_title			number not null,
func_para_function_name			varchar2(30) not null,
func_para_function_desciption	varchar2(30) not null,
func_para_control_name			varchar2(30) not null,
func_para_control_description	varchar2(30) not null,
func_para_creator				number not null,
func_para_creator_time			date not null,
func_para_latest_editor			number not null,
func_para_updated_time			date not null,
func_para_record_status			number default null				-- null is not deleted, 0 is deleted
);

create table pl_menu(
menu_gkey					number not null primary key,
menu_frm_id					number not null,
menu_title					varchar2(30) not null,
menu_parent_key				number not null,
menu_has_child				number not null default 0,			-- 1 is with child, 0 is no child
menu_type					varchar2(30) not null,					-- MenuItem / Printer / Restart
menu_function_name			varchar2(30) not null,					
menu_exe_path				varchar2(100) not null,
menu_record_status			number default null,				-- null is not deleted, 0 is deleted
menu_creator				number not null,
menu_creation_time			date not null,
menu_latest_editor			number not null,
menu_updated_time			date not null
);


-- Billing System

create table invoice_head(
invoice_gkey			number not null primary key,
invoice_number			number not null,
invoice_date			date not null,
invoice_customer_id		number not null,
invoice_desc			varchar2(50),
invoice_contract_key	number not null,
invoice_total_amount	number not null,
invoice_currency		varchar2(3) not null,
invoice_status			varchar2(1) not null,		-- open / print / check-1 / check-2 / post
invoice_creator			number not null,
invoice_creation_time	date not null,
invoice_latest_editor	number not null,
invoice_updated_time	date not null
);

create table invoice_detail(
invoice_gkey					number not null,
invoice_charge_subject_code		varchar(10) not null,
invoice_charge_desc_chn			varchar2(50) not null,
invoice_charge_desc_eng			varchar2(50) not null,
invoice_tariff_amount			number not null,			-- price per container
invoice_count					number not null,			-- count of containers
invoice_tariff_total_amount		number not null,			-- total price of each invoice detail
constraint pk_invoice_detail(invoice_gkey, invoice_charge_subject_code) primary key
);

create table invoice_container_list(
invoice_gkey					number not null,
invoice_charge_subject_code		number not null,
invoice_container_gkey			number not null,
invoice_container_no			number not null,
invoice_container_length		number not null,
invoice_container_height		number not null,
invoice_container_type			varchar2(20) not null,
constraint pk_invoice_container_list(invoice_gkey, invoice_charge_subject_code, invoice_container_gkey) primary key
);

create table invoice_berthage(
invoice_gkey					number not null,
invoice_charge_subject_code		varchar2(20) not null,		-- not sure if this type is fine?
invoice_voyage_id				number not null,
invoice_voyage_in_seq			varchar2(20) not null,
invoice_voyage_out_seq			varchar2(20) not null,
invoice_voyage_route			varchar2(20) not null,
invoice_voyage_pull_start_date	date not null,
invoice_voyage_pull_end_date	date not null,
constraint pk_invoice_berthage(invoice_gkey, invoice_charge_subject_code, invoice_voyage_id) primary key
);

create table vs_berthplan(
berthplan_gkey					number not null primary key,
berthplan_vessel_gkey			number not null,
berthplan_in_seq				varchar2(20) not null,
berthplan_out_seq				varchar2(20) not null,
berthplan_route					number not null,
berthplan_creator				number not null,
berthplan_creation_date			date not null,
berthplan_latest_editor			number not null,
berthplan_latest_updated_time	date not null,
berthplan_record_status			number default null				-- null is not deleted, 0 is deleted
);

create table vs_vesselinfo(
vessel_id					number not null primary key,
vessel_length				number not null,
vessel_tonage				number not null,
vessel_creator				number not null,
vessel_creation_time		date not null,
vessel_latest_editor		number not null,
vessel_updeted_time			date not null,
vessel_customer_id			number not null
);

create table tr_trucktimes(
trucktimes_gkey						number not null primary key,
trucktimes_in_time					date not null,
trucktimes_out_time					date not null,
trucktimes_truck_no					number not null,
trucktimes_creator					number not null,
trucktimes_creation_time			date not null,
trucktimes_latest_editor			number not null,
trucktimes_latest_updated_time		date not null,
trucktimes_record_status			number default null				-- null is not deleted, 0 is deleted
);

create table tr_truckinfo(
truck_no					number not null primary key,
truck_customer_id			number not null,
truck_creator				number not null,
truck_creation_time			date not null,
truck_latest_editor			number not null,
truck_latest_updated_time	date not null,
truck_record_status			number default null				-- null is not deleted, 0 is deleted
);

create table ct_customer(
customer_id					number not null primary key,
customer_name_chn			varchar2(50) not null,
customer_name_eng			varchar2(50) not null,
customer_addr				varchar2(100) not null,
customer_contact_person		varchar2(25) not null,
customer_phone_num			varchar2(25) not null,
customer_creator			number not null,
customer_creation_time		date not null,
customer_latest_editor		number not null,
customer_updated_time		date not null,
customer_record_status		number default null				-- null is not deleted, 0 is deleted
);

create table ct_contract(
contract_gkey				number not null primary key,
contract_name				varchar2(100) not null,
contract_customer_id		number not null,
contract_route				varchar2(50) not null,
contract_start_date			date not null,
contract_end_date			date not null,
contract_desc_chn			varchar2(50) not null,
contract_desc_eng			varchar2(50) not null,
contract_currency			varchar2(3) not null,
contract_creator			number not null,
contract_latest_editor		number not null,
contract_creation_time		date not null,
contract_updated_time		date not null,
contract_record_status		number default null				-- null is not deleted, 0 is deleted
);

create table cr_tariff(
tarriff_contract_gkey			number not null,
tariff_charge_subject_code		varchar2(20) not null,		-- not sure if this type is fine?
tariff_power_start_time			date not null,
tariff_power_end_time			date not null,
tariff_berth_end_time			date not null,
tariff_berth_end_time			date not null,
tariff_storage_start_time		date not null,
tariff_storage_end_time			date not null,
tariff_amount					number not null,
tariff_creator					number not null,
tariff_creation_time			date not null,
tariff_latest_editor			number not null,
tariff_updated_time				date not null,
tariff_record_status			number default null,			-- null is not deleted, 0 is deleted
constraint pk_cr_tariff(tarriff_contract_gkey, tariff_charge_subject_code) primary key
);

create table ct_charge_subject(
charge_subject_gkey			number not null primary key,
charge_subject_code			varchar2(20) not null unique,		-- not sure if this type is fine?
charge_subject_desc_chn		varchar2(50) not null,
charge_subject_desc_eng		varchar2(50) not null,
charge_containerdesc_key	number not null,
charge_type					varchar2(5) not null,				-- not sure if this type is fine?
charge_contract_id			number not null,
);

create table cm_container_desc(
container_desc_gkey				number not null primary key,
container_desc_height			number not null,
container_desc_length			number not null,
container_desc_type				varchar2(5) not null,			-- not sure if this type is fine?
container_desc_latest_editor	number not null,
container_desc_updated_time		date not null,
container_desc_recore_status	number default null				-- null is not deleted, 0 is deleted
);
