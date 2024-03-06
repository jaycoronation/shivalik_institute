import 'dart:convert';

import 'package:shivalik_institute/model/UserListResponseModel.dart';
/// success : "1"
/// message : "List Found"
/// total_records : "29"
/// list : [{"id":"96","course_id":"1","prefix_name":"Mr.","first_name":"Raj","last_name":"Shukla","enrollment_no":"","email":"jay.m@coronation.in","contact_no":"9725059007","user_type":"3","faculty_type":"","profile_pic":"https://shivalik.institute/api/image-tool/index.php?src=https://shivalik.institute/api/assets/uploads/1708087646_FfOFYHrg.jpg","gender":"Male","date_of_birth":"","highest_education":"Computer Science","college_name":"","designation":"Founder @ Salt Pixels Pvt Ltd","years_of_experience":"17","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1699021187","updated_at":"1708087646","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"35","address":"Orchid Divine","payment_mode":"Cash","payment_details":"","document_submitted":[""],"start_date_course":"","enrolled_by":"","total_fees":94400,"aadhar_card":"https://shivalik.institute/api/image-tool/index.php?src=https://shivalik.institute/api/assets/uploads/1699021187_gvldg3Go.png","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Raj_Shukla_invoice_30_01_24_17_41.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"1","enrolled_in_course_desc":"","pan_card":"","batch_id":"15","batch":{"name":"JRE09","timezone":"Afternoon","duration":"1:30 PM to 4:30 PM","start_date":"1st December 2023","end_date":"24th January 2024"},"payment_link":"https://www.shivalik.institute/payment/96","current_batch":"","prev_batch":""},{"id":"157","course_id":"1","prefix_name":"Mr.","first_name":"Swar","last_name":"Shah","enrollment_no":"ER00000241","email":"student.SwarShah@shivalik.institute","contact_no":"7574044412","user_type":"3","faculty_type":"","profile_pic":"","gender":"male","date_of_birth":"","highest_education":"na","college_name":"","designation":"","years_of_experience":"5","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1705496712","updated_at":"1708342717","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"28","address":"any","payment_mode":"Cash","payment_details":"","document_submitted":[""],"start_date_course":"2023-12-20","enrolled_by":"","total_fees":94400,"aadhar_card":"https://shivalik.institute/api/image-tool/index.php?src=https://shivalik.institute/api/assets/uploads/1705496712_N8UGV69p.png","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"na","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/157","current_batch":"","prev_batch":""},{"id":"233","course_id":"1","prefix_name":"Mrs.","first_name":"Priya","last_name":"Khatri","enrollment_no":"ER000035","email":"priya@coronation.in","contact_no":"9033629230","user_type":"3","faculty_type":"educator","profile_pic":"","gender":"female","date_of_birth":"22-05-1994","highest_education":"BE CE","college_name":"","designation":"Sr Software Developer","years_of_experience":"1","teaching_experience":"","industrial_experience":"10","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1707463830","updated_at":"1708088747","deleted_at":"","is_alumini":"0","paid_fees":0,"pending_fees":0,"is_hold":"0","age":"29","address":"Corporate Road, Prahalad Nagar\r\n506-Pinnacle business park,","payment_mode":"Cash","payment_details":"","document_submitted":[""],"start_date_course":"2023-10-30","enrolled_by":"","total_fees":0,"aadhar_card":"https://shivalik.institute/api/image-tool/index.php?src=https://shivalik.institute/api/assets/uploads/1707463830_DrCHU0v1.png","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"any","pan_card":"","batch_id":"5","batch":{"name":"JRE12","timezone":"Afternoon","duration":"1:30 PM to 4:30 PM","start_date":"8th February 2024","end_date":"4th April 2024"},"payment_link":"https://www.shivalik.institute/payment/233","current_batch":"","prev_batch":""},{"id":"105","course_id":"1","prefix_name":"Mr.","first_name":"Hrishi ","last_name":"Patel","enrollment_no":"SIRE/24/00273","email":"hrishi567@hotmail.com","contact_no":"9824019419","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"25-03-2002","highest_education":"BBA","college_name":"","designation":"Aithi dining hall","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1703097000","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"21","address":"Bougan Villa Appartment,380054","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Hrishi_Patel_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/105","current_batch":"","prev_batch":""},{"id":"106","course_id":"1","prefix_name":"Mr.","first_name":"Mahek ","last_name":" Mevada","enrollment_no":"SIRE/24/00274","email":"mahekmevada1234567@gmail.com","contact_no":"9712957725","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"17-09-2002","highest_education":"BBA","college_name":"","designation":"----","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1703183400","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"22","address":"27,Arya Bunglows,380015","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Mahek_Mevada_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/106","current_batch":"","prev_batch":""},{"id":"107","course_id":"1","prefix_name":"Mr.","first_name":"Vikas ","last_name":" Oza","enrollment_no":"SIRE/24/00275","email":"vikasoza93civil@gmail.com","contact_no":"9737055160","user_type":"3","faculty_type":"","profile_pic":"","gender":"male","date_of_birth":"13-08-1993","highest_education":"B.E(Civil)","college_name":"","designation":"Sr. engineer at Colliers internaional,Ahm","years_of_experience":"7 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1703529000","updated_at":"1705670633","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"29","address":"Prajapatiwas,Kheralu","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Vikas_Oza_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/107","current_batch":"","prev_batch":""},{"id":"108","course_id":"1","prefix_name":"Mr.","first_name":"Ankit ","last_name":" Patel","enrollment_no":"SIRE/24/00276","email":"ankit@sabaragroseeds.com","contact_no":"9429152707","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"24-04-1987","highest_education":"DP ( Mechanical)","college_name":"","designation":"Proprietors","years_of_experience":"2 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1703615400","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"36","address":"Laxinarayan Society,Himatnagar","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1111","country_name":"India","state_name":"Gujarat","city_name":"Himatnagar","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Ankit_Patel_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/108","current_batch":"","prev_batch":""},{"id":"109","course_id":"1","prefix_name":"Mr.","first_name":"Punit ","last_name":" Parmar","enrollment_no":"SIRE/24/00278","email":"punitparmar99@gmail.com","contact_no":"9712347245","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"21-02-1992","highest_education":"NA","college_name":"","designation":"director","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1703701800","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"31","address":"Anmol Park,Bopal","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Punit_Parmar_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/109","current_batch":"","prev_batch":""},{"id":"110","course_id":"1","prefix_name":"Mr.","first_name":"Siddharthsinh ","last_name":" Vaghela","enrollment_no":"SIRE/24/00280","email":"siddarthsinh0@gmail.com","contact_no":"9173832049","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"12-01-1997","highest_education":"HSC","college_name":"","designation":"chairman","years_of_experience":"4 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704133800","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"26","address":"42,Bapa ni Deli,Godhavi","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Siddharthsinh_Vaghela_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/110","current_batch":"","prev_batch":""},{"id":"111","course_id":"1","prefix_name":"Mr.","first_name":"Nelson ","last_name":" Christian","enrollment_no":"SIRE/24/00281","email":"brainstormbird@gmail.com","contact_no":"9725454170","user_type":"3","faculty_type":"","profile_pic":"","gender":"male","date_of_birth":"","highest_education":"NA","college_name":"","designation":"Investment Advisor","years_of_experience":"1","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"","updated_at":"1706346169","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"32","address":"ahmedabad","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Nelson_Christian_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/111","current_batch":"","prev_batch":""},{"id":"113","course_id":"1","prefix_name":"Mr.","first_name":"Jay ","last_name":"Patel","enrollment_no":"SIRE/24/00283","email":"jaypatel8887@gmail.com","contact_no":"9725852970","user_type":"3","faculty_type":"","profile_pic":"","gender":"male","date_of_birth":"08-08-1987","highest_education":"BSC","college_name":"","designation":"self employea","years_of_experience":"12 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704220200","updated_at":"1706343040","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"36","address":"Paras Bunglows,Kathwada","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"2024-01-12","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Jay_Patel_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/113","current_batch":"","prev_batch":""},{"id":"116","course_id":"1","prefix_name":"Mr.","first_name":"Nixon ","last_name":" Christian","enrollment_no":"SIRE/24/00286","email":"nixon.er@outlook.com","contact_no":"9662222224","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"05-10-1985","highest_education":"MBA","college_name":"","designation":"Owner","years_of_experience":"5 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704220200","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"37","address":"kalapinagar","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"","country_name":"India","state_name":"Gujarat","city_name":"","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Nixon_Christian_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/116","current_batch":"","prev_batch":""},{"id":"117","course_id":"1","prefix_name":"Mr.","first_name":"Gaurav","last_name":"Gaulechha","enrollment_no":"SIRE/24/00287","email":"gaurav.391@gmail.com","contact_no":"9924943975","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"31-10-1987","highest_education":"MBA","college_name":"","designation":"Proprietor","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704393000","updated_at":"1707316127","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"36","address":"Bodakdev","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Gaurav_Gaulechha_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/117","current_batch":"","prev_batch":""},{"id":"118","course_id":"1","prefix_name":"Mr.","first_name":"Arjun ","last_name":" Javia","enrollment_no":"SIRE/24/00288","email":"javiaarjun99@gmail.com","contact_no":"9988944455","user_type":"3","faculty_type":"","profile_pic":"","gender":"male","date_of_birth":"17-01-1992","highest_education":"Bcom","college_name":"","designation":"R.A.Realty","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704306600","updated_at":"1706343978","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"32","address":"Shahibaug","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"2024-01-12","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Arjun_Jayia_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/118","current_batch":"","prev_batch":""},{"id":"119","course_id":"1","prefix_name":"Mr.","first_name":"Chirag ","last_name":" Rawal","enrollment_no":"SIRE/24/00289","email":"chiragrawal2004@icoud.com","contact_no":"7600666666","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"24-02-2004","highest_education":"Student","college_name":"","designation":"student","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704220200","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"21","address":"Adani Shantigram","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Chirag_Rawal_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/119","current_batch":"","prev_batch":""},{"id":"120","course_id":"1","prefix_name":"Mr.","first_name":"Meet ","last_name":" Thakkar","enrollment_no":"SIRE/24/00290","email":"PGfoodspvtltd@gmail.com","contact_no":"9925411157","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"17-10-1998","highest_education":"B.E(Mechanical)","college_name":"","designation":"Managing Director","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704393000","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"25","address":"Nandwan Bunglow","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1130","country_name":"India","state_name":"Gujarat","city_name":"Unjha","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Meet_Thakkar_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/120","current_batch":"","prev_batch":""},{"id":"122","course_id":"1","prefix_name":"Mr.","first_name":"Pritesh ","last_name":" Mistry","enrollment_no":"SIRE/24/00292","email":"pmistry@aesticare.com","contact_no":"9825020173","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"03-01-1978","highest_education":"PGDBM","college_name":"","designation":"Managing Director","years_of_experience":"15 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704393000","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"46","address":"Thaltej","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Pritesh_Mistry_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/122","current_batch":"","prev_batch":""},{"id":"123","course_id":"1","prefix_name":"Mr.","first_name":"Parth ","last_name":" Patel","enrollment_no":"SIRE/24/00293","email":"parthh6364@gmail.com","contact_no":"9099099567","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"25-05-1999","highest_education":"Masters","college_name":"","designation":"fice souls pigech","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704479400","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"24","address":"Sindhubhavan","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Parth_Patel_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/123","current_batch":"","prev_batch":""},{"id":"124","course_id":"1","prefix_name":"Mr.","first_name":"Vimesh ","last_name":"Soni","enrollment_no":"SIRE/24/00294","email":"vimeshrs@gmail.com","contact_no":"9879079002","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"24-02-1988","highest_education":"Bcom","college_name":"","designation":"Self Employed","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704479400","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"36","address":"Shahibaug","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Vimesh_Soni_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/124","current_batch":"","prev_batch":""},{"id":"125","course_id":"1","prefix_name":"Mr.","first_name":"Vishal","last_name":" Gediya","enrollment_no":"SIRE/24/00295","email":"vishalgediya448@gmail.com","contact_no":"8000074200","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"05-07-1994","highest_education":"B.E(IT)","college_name":"","designation":"Shyam Developers","years_of_experience":"7-8Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704479400","updated_at":"1705405464","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"29","address":"Happy Bunglows","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1251","country_name":"India","state_name":"Gujarat","city_name":"Surat","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Vishal_Gediya_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/125","current_batch":"","prev_batch":""},{"id":"126","course_id":"1","prefix_name":"Mr.","first_name":"Ketan ","last_name":"Patel","enrollment_no":"SIRE/24/00296","email":"kk.agola4662@gmail.com","contact_no":"9662646500","user_type":"3","faculty_type":"","profile_pic":"https://shivalik.institute/api/image-tool/index.php?src=https://shivalik.institute/api/assets/uploads/1705561556_y0bOViaA.jpg","gender":"male","date_of_birth":"22-02-1994","highest_education":"Bcom","college_name":"","designation":"Na","years_of_experience":"4 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704652200","updated_at":"1706360270","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"30","address":"Nikol","payment_mode":"","payment_details":"","document_submitted":[""],"start_date_course":"2024-01-12","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Ketan_Patel_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/126","current_batch":"","prev_batch":""},{"id":"127","course_id":"1","prefix_name":"Mr.","first_name":"Himanshu ","last_name":" Savaliya","enrollment_no":"SIRE/24/00297","email":"himanshu6161@rediff.com","contact_no":"9824258361","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"01-06-1980","highest_education":"Bcom","college_name":"","designation":"savaliya infa partner","years_of_experience":"17 Years","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704652200","updated_at":"1705405465","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"44","address":"Vastrapur","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Himanshu_Savaliya_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"1","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/127","current_batch":"","prev_batch":""},{"id":"128","course_id":"1","prefix_name":"Mr.","first_name":"Dhwani","last_name":"Bhagat","enrollment_no":"SIRE/24/00298","email":"dhwanibhagat3@gmail.com ","contact_no":"9724314792","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"14-12-1901","highest_education":"MBA","college_name":"","designation":"Co-Director Chemidyes","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704825000","updated_at":"1705405465","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"32","address":"Ambikakunj  Society ","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Dhwani_Bhagat_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"1","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/128","current_batch":"","prev_batch":""},{"id":"134","course_id":"1","prefix_name":"Mr.","first_name":"TANISHQ ","last_name":" SHARMA","enrollment_no":"SIRE/24/00299","email":"tanishqsharma40@gmail.com","contact_no":"8469818708","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"11-02-1994","highest_education":"PGDM-SCM ","college_name":"","designation":"Manager","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704997800","updated_at":"1705405465","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"29","address":"Satellite","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/TANISHQ_SHARMA_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/134","current_batch":"","prev_batch":""},{"id":"135","course_id":"1","prefix_name":"Mr.","first_name":"Bhavin ","last_name":" Ratanghayra","enrollment_no":"SIRE/24/00300","email":"bhavin.ratan@gmail.com","contact_no":"9909429980","user_type":"3","faculty_type":"","profile_pic":"","gender":"Male","date_of_birth":"11-08-1983","highest_education":"Company Secretary","college_name":"","designation":"partner","years_of_experience":"NA","teaching_experience":"","industrial_experience":"","motivation_for_teaching":"","linkedin_profile_link":"","facebook_profile_link":"","cv":"","is_active":"1","created_at":"1704997800","updated_at":"1705405465","deleted_at":"","is_alumini":"0","paid_fees":94400,"pending_fees":0,"is_hold":"0","age":"40","address":"Shivalik Sharda Park","payment_mode":"","payment_details":"","document_submitted":[],"start_date_course":"2024-01-16","enrolled_by":"","total_fees":94400,"aadhar_card":"","receipt":"","photo":"","family_background":"","country":"101","state":"12","city":"1019","country_name":"India","state_name":"Gujarat","city_name":"Ahmedabad","hourly_rate":"","bank_name":"","account_no":"","ifsc_code":"","about":"","past":"","skills":"","education":"","alt_email":"","invoice_file":"https://shivalik.institute/api/assets/saved_invoice/Bhavin_Ratanghayra_16_01_24_06:30_PM.pdf","payment_mode_cash":"0","payment_mode_cheque":"0","payment_mode_netbanking":"0","payment_mode_cash_amount":"","payment_mode_cheque_amount":"","payment_mode_netbanking_amount":"","holding_seat":"0","enrolled_in_course":"0","holding_seat_desc":"","enrolled_in_course_desc":"","pan_card":"","batch_id":"4","batch":{"name":"JRE11","timezone":"Evening","duration":"6 PM to 9 PM","start_date":"12th January 2024","end_date":"23rd March 2024"},"payment_link":"https://www.shivalik.institute/payment/135","current_batch":"","prev_batch":""}]

GroupResponseModel groupResponseModelFromJson(String str) => GroupResponseModel.fromJson(json.decode(str));
String groupResponseModelToJson(GroupResponseModel data) => json.encode(data.toJson());
class GroupResponseModel {
  GroupResponseModel({
      String? success, 
      String? message, 
      String? totalRecords, 
      List<UserList>? list,
  }){
    _success = success;
    _message = message;
    _totalRecords = totalRecords;
    _list = list;
}

  GroupResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _totalRecords = json['total_records'];
    if (json['list'] != null) {
      _list = [];
      json['list'].forEach((v) {
        _list?.add(UserList.fromJson(v));
      });
    }
  }
  String? _success;
  String? _message;
  String? _totalRecords;
  List<UserList>? _list;
GroupResponseModel copyWith({  String? success,
  String? message,
  String? totalRecords,
  List<UserList>? list,
}) => GroupResponseModel(  success: success ?? _success,
  message: message ?? _message,
  totalRecords: totalRecords ?? _totalRecords,
  list: list ?? _list,
);
  String? get success => _success;
  String? get message => _message;
  String? get totalRecords => _totalRecords;
  List<UserList>? get list => _list;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['total_records'] = _totalRecords;
    if (_list != null) {
      map['list'] = _list?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "96"
/// course_id : "1"
/// prefix_name : "Mr."
/// first_name : "Raj"
/// last_name : "Shukla"
/// enrollment_no : ""
/// email : "jay.m@coronation.in"
/// contact_no : "9725059007"
/// user_type : "3"
/// faculty_type : ""
/// profile_pic : "https://shivalik.institute/api/image-tool/index.php?src=https://shivalik.institute/api/assets/uploads/1708087646_FfOFYHrg.jpg"
/// gender : "Male"
/// date_of_birth : ""
/// highest_education : "Computer Science"
/// college_name : ""
/// designation : "Founder @ Salt Pixels Pvt Ltd"
/// years_of_experience : "17"
/// teaching_experience : ""
/// industrial_experience : ""
/// motivation_for_teaching : ""
/// linkedin_profile_link : ""
/// facebook_profile_link : ""
/// cv : ""
/// is_active : "1"
/// created_at : "1699021187"
/// updated_at : "1708087646"
/// deleted_at : ""
/// is_alumini : "0"
/// paid_fees : 94400
/// pending_fees : 0
/// is_hold : "0"
/// age : "35"
/// address : "Orchid Divine"
/// payment_mode : "Cash"
/// payment_details : ""
/// document_submitted : [""]
/// start_date_course : ""
/// enrolled_by : ""
/// total_fees : 94400
/// aadhar_card : "https://shivalik.institute/api/image-tool/index.php?src=https://shivalik.institute/api/assets/uploads/1699021187_gvldg3Go.png"
/// receipt : ""
/// photo : ""
/// family_background : ""
/// country : "101"
/// state : "12"
/// city : "1019"
/// country_name : "India"
/// state_name : "Gujarat"
/// city_name : "Ahmedabad"
/// hourly_rate : ""
/// bank_name : ""
/// account_no : ""
/// ifsc_code : ""
/// about : ""
/// past : ""
/// skills : ""
/// education : ""
/// alt_email : ""
/// invoice_file : "https://shivalik.institute/api/assets/saved_invoice/Raj_Shukla_invoice_30_01_24_17_41.pdf"
/// payment_mode_cash : "0"
/// payment_mode_cheque : "0"
/// payment_mode_netbanking : "0"
/// payment_mode_cash_amount : ""
/// payment_mode_cheque_amount : ""
/// payment_mode_netbanking_amount : ""
/// holding_seat : "1"
/// enrolled_in_course : "0"
/// holding_seat_desc : "1"
/// enrolled_in_course_desc : ""
/// pan_card : ""
/// batch_id : "15"
/// batch : {"name":"JRE09","timezone":"Afternoon","duration":"1:30 PM to 4:30 PM","start_date":"1st December 2023","end_date":"24th January 2024"}
/// payment_link : "https://www.shivalik.institute/payment/96"
/// current_batch : ""
/// prev_batch : ""

UserList listFromJson(String str) => UserList.fromJson(json.decode(str));
String listToJson(UserList data) => json.encode(data.toJson());
class UserList {
  UserList({
      String? id, 
      String? courseId, 
      String? isBatchAdmin,
      String? prefixName,
      String? firstName, 
      String? lastName, 
      String? enrollmentNo, 
      String? email, 
      String? contactNo, 
      String? userType, 
      String? facultyType, 
      String? profilePic, 
      String? gender, 
      String? dateOfBirth, 
      String? highestEducation, 
      String? collegeName, 
      String? designation, 
      String? yearsOfExperience, 
      String? teachingExperience, 
      String? industrialExperience, 
      String? motivationForTeaching, 
      String? linkedinProfileLink, 
      String? facebookProfileLink, 
      String? cv, 
      String? isActive, 
      String? createdAt, 
      String? updatedAt, 
      String? deletedAt, 
      String? isAlumini, 
      num? paidFees, 
      num? pendingFees, 
      String? isHold, 
      String? age, 
      String? address, 
      String? paymentMode, 
      String? paymentDetails, 
      // List<String>? documentSubmitted,
      String? startDateCourse, 
      String? enrolledBy, 
      num? totalFees, 
      String? aadharCard, 
      String? receipt, 
      String? photo, 
      String? familyBackground, 
      String? country, 
      String? state, 
      String? city, 
      String? countryName, 
      String? stateName, 
      String? cityName, 
      String? hourlyRate, 
      String? bankName, 
      String? accountNo, 
      String? ifscCode, 
      String? about, 
      String? past, 
      String? skills, 
      String? education, 
      String? altEmail, 
      String? invoiceFile, 
      String? paymentModeCash, 
      String? paymentModeCheque, 
      String? paymentModeNetbanking, 
      String? paymentModeCashAmount, 
      String? paymentModeChequeAmount, 
      String? paymentModeNetbankingAmount, 
      String? holdingSeat, 
      String? enrolledInCourse, 
      String? holdingSeatDesc, 
      String? enrolledInCourseDesc, 
      String? panCard, 
      String? batchId, 
      Batch? batch, 
      String? paymentLink, 
      String? currentBatch, 
      String? prevBatch,}){
    _id = id;
    _courseId = courseId;
    _isBatchAdmin = isBatchAdmin;
    _prefixName = prefixName;
    _firstName = firstName;
    _lastName = lastName;
    _enrollmentNo = enrollmentNo;
    _email = email;
    _contactNo = contactNo;
    _userType = userType;
    _facultyType = facultyType;
    _profilePic = profilePic;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _highestEducation = highestEducation;
    _collegeName = collegeName;
    _designation = designation;
    _yearsOfExperience = yearsOfExperience;
    _teachingExperience = teachingExperience;
    _industrialExperience = industrialExperience;
    _motivationForTeaching = motivationForTeaching;
    _linkedinProfileLink = linkedinProfileLink;
    _facebookProfileLink = facebookProfileLink;
    _cv = cv;
    _isActive = isActive;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _isAlumini = isAlumini;
    _paidFees = paidFees;
    _pendingFees = pendingFees;
    _isHold = isHold;
    _age = age;
    _address = address;
    _paymentMode = paymentMode;
    _paymentDetails = paymentDetails;
    // _documentSubmitted = documentSubmitted;
    _startDateCourse = startDateCourse;
    _enrolledBy = enrolledBy;
    _totalFees = totalFees;
    _aadharCard = aadharCard;
    _receipt = receipt;
    _photo = photo;
    _familyBackground = familyBackground;
    _country = country;
    _state = state;
    _city = city;
    _countryName = countryName;
    _stateName = stateName;
    _cityName = cityName;
    _hourlyRate = hourlyRate;
    _bankName = bankName;
    _accountNo = accountNo;
    _ifscCode = ifscCode;
    _about = about;
    _past = past;
    _skills = skills;
    _education = education;
    _altEmail = altEmail;
    _invoiceFile = invoiceFile;
    _paymentModeCash = paymentModeCash;
    _paymentModeCheque = paymentModeCheque;
    _paymentModeNetbanking = paymentModeNetbanking;
    _paymentModeCashAmount = paymentModeCashAmount;
    _paymentModeChequeAmount = paymentModeChequeAmount;
    _paymentModeNetbankingAmount = paymentModeNetbankingAmount;
    _holdingSeat = holdingSeat;
    _enrolledInCourse = enrolledInCourse;
    _holdingSeatDesc = holdingSeatDesc;
    _enrolledInCourseDesc = enrolledInCourseDesc;
    _panCard = panCard;
    _batchId = batchId;
    _batch = batch;
    _paymentLink = paymentLink;
    _currentBatch = currentBatch;
    _prevBatch = prevBatch;
}

  UserList.fromJson(dynamic json) {
    _id = json['id'];
    _courseId = json['course_id'];
    _isBatchAdmin = json['is_batch_admin'];
    _prefixName = json['prefix_name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _enrollmentNo = json['enrollment_no'];
    _email = json['email'];
    _contactNo = json['contact_no'];
    _userType = json['user_type'];
    _facultyType = json['faculty_type'];
    _profilePic = json['profile_pic'];
    _gender = json['gender'];
    _dateOfBirth = json['date_of_birth'];
    _highestEducation = json['highest_education'];
    _collegeName = json['college_name'];
    _designation = json['designation'];
    _yearsOfExperience = json['years_of_experience'];
    _teachingExperience = json['teaching_experience'];
    _industrialExperience = json['industrial_experience'];
    _motivationForTeaching = json['motivation_for_teaching'];
    _linkedinProfileLink = json['linkedin_profile_link'];
    _facebookProfileLink = json['facebook_profile_link'];
    _cv = json['cv'];
    _isActive = json['is_active'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _isAlumini = json['is_alumini'];
    _paidFees = json['paid_fees'];
    _pendingFees = json['pending_fees'];
    _isHold = json['is_hold'];
    _age = json['age'];
    _address = json['address'];
    _paymentMode = json['payment_mode'];
    _paymentDetails = json['payment_details'];
    // _documentSubmitted = json['document_submitted'] != null ? json['document_submitted'].cast<String>() : [];
    _startDateCourse = json['start_date_course'];
    _enrolledBy = json['enrolled_by'];
    _totalFees = json['total_fees'];
    _aadharCard = json['aadhar_card'];
    _receipt = json['receipt'];
    _photo = json['photo'];
    _familyBackground = json['family_background'];
    _country = json['country'];
    _state = json['state'];
    _city = json['city'];
    _countryName = json['country_name'];
    _stateName = json['state_name'];
    _cityName = json['city_name'];
    _hourlyRate = json['hourly_rate'];
    _bankName = json['bank_name'];
    _accountNo = json['account_no'];
    _ifscCode = json['ifsc_code'];
    _about = json['about'];
    _past = json['past'];
    _skills = json['skills'];
    _education = json['education'];
    _altEmail = json['alt_email'];
    _invoiceFile = json['invoice_file'];
    _paymentModeCash = json['payment_mode_cash'];
    _paymentModeCheque = json['payment_mode_cheque'];
    _paymentModeNetbanking = json['payment_mode_netbanking'];
    _paymentModeCashAmount = json['payment_mode_cash_amount'];
    _paymentModeChequeAmount = json['payment_mode_cheque_amount'];
    _paymentModeNetbankingAmount = json['payment_mode_netbanking_amount'];
    _holdingSeat = json['holding_seat'];
    _enrolledInCourse = json['enrolled_in_course'];
    _holdingSeatDesc = json['holding_seat_desc'];
    _enrolledInCourseDesc = json['enrolled_in_course_desc'];
    _panCard = json['pan_card'];
    _batchId = json['batch_id'];
    _batch = json['batch'] != null ? Batch.fromJson(json['batch']) : null;
    _paymentLink = json['payment_link'];
    _currentBatch = json['current_batch'];
    _prevBatch = json['prev_batch'];
  }
  String? _id;
  String? _courseId;
  String? _isBatchAdmin;
  String? _prefixName;
  String? _firstName;
  String? _lastName;
  String? _enrollmentNo;
  String? _email;
  String? _contactNo;
  String? _userType;
  String? _facultyType;
  String? _profilePic;
  String? _gender;
  String? _dateOfBirth;
  String? _highestEducation;
  String? _collegeName;
  String? _designation;
  String? _yearsOfExperience;
  String? _teachingExperience;
  String? _industrialExperience;
  String? _motivationForTeaching;
  String? _linkedinProfileLink;
  String? _facebookProfileLink;
  String? _cv;
  String? _isActive;
  String? _createdAt;
  String? _updatedAt;
  String? _deletedAt;
  String? _isAlumini;
  num? _paidFees;
  num? _pendingFees;
  String? _isHold;
  String? _age;
  String? _address;
  String? _paymentMode;
  String? _paymentDetails;
  // List<String>? _documentSubmitted;
  String? _startDateCourse;
  String? _enrolledBy;
  num? _totalFees;
  String? _aadharCard;
  String? _receipt;
  String? _photo;
  String? _familyBackground;
  String? _country;
  String? _state;
  String? _city;
  String? _countryName;
  String? _stateName;
  String? _cityName;
  String? _hourlyRate;
  String? _bankName;
  String? _accountNo;
  String? _ifscCode;
  String? _about;
  String? _past;
  String? _skills;
  String? _education;
  String? _altEmail;
  String? _invoiceFile;
  String? _paymentModeCash;
  String? _paymentModeCheque;
  String? _paymentModeNetbanking;
  String? _paymentModeCashAmount;
  String? _paymentModeChequeAmount;
  String? _paymentModeNetbankingAmount;
  String? _holdingSeat;
  String? _enrolledInCourse;
  String? _holdingSeatDesc;
  String? _enrolledInCourseDesc;
  String? _panCard;
  String? _batchId;
  Batch? _batch;
  String? _paymentLink;
  String? _currentBatch;
  String? _prevBatch;
UserList copyWith({  String? id,
  String? courseId,
  String? isBatchAdmin,
  String? prefixName,
  String? firstName,
  String? lastName,
  String? enrollmentNo,
  String? email,
  String? contactNo,
  String? userType,
  String? facultyType,
  String? profilePic,
  String? gender,
  String? dateOfBirth,
  String? highestEducation,
  String? collegeName,
  String? designation,
  String? yearsOfExperience,
  String? teachingExperience,
  String? industrialExperience,
  String? motivationForTeaching,
  String? linkedinProfileLink,
  String? facebookProfileLink,
  String? cv,
  String? isActive,
  String? createdAt,
  String? updatedAt,
  String? deletedAt,
  String? isAlumini,
  num? paidFees,
  num? pendingFees,
  String? isHold,
  String? age,
  String? address,
  String? paymentMode,
  String? paymentDetails,
  // List<String>? documentSubmitted,
  String? startDateCourse,
  String? enrolledBy,
  num? totalFees,
  String? aadharCard,
  String? receipt,
  String? photo,
  String? familyBackground,
  String? country,
  String? state,
  String? city,
  String? countryName,
  String? stateName,
  String? cityName,
  String? hourlyRate,
  String? bankName,
  String? accountNo,
  String? ifscCode,
  String? about,
  String? past,
  String? skills,
  String? education,
  String? altEmail,
  String? invoiceFile,
  String? paymentModeCash,
  String? paymentModeCheque,
  String? paymentModeNetbanking,
  String? paymentModeCashAmount,
  String? paymentModeChequeAmount,
  String? paymentModeNetbankingAmount,
  String? holdingSeat,
  String? enrolledInCourse,
  String? holdingSeatDesc,
  String? enrolledInCourseDesc,
  String? panCard,
  String? batchId,
  Batch? batch,
  String? paymentLink,
  String? currentBatch,
  String? prevBatch,
}) => UserList(  id: id ?? _id,
  courseId: courseId ?? _courseId,
  isBatchAdmin: isBatchAdmin ?? _isBatchAdmin,
  prefixName: prefixName ?? _prefixName,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  enrollmentNo: enrollmentNo ?? _enrollmentNo,
  email: email ?? _email,
  contactNo: contactNo ?? _contactNo,
  userType: userType ?? _userType,
  facultyType: facultyType ?? _facultyType,
  profilePic: profilePic ?? _profilePic,
  gender: gender ?? _gender,
  dateOfBirth: dateOfBirth ?? _dateOfBirth,
  highestEducation: highestEducation ?? _highestEducation,
  collegeName: collegeName ?? _collegeName,
  designation: designation ?? _designation,
  yearsOfExperience: yearsOfExperience ?? _yearsOfExperience,
  teachingExperience: teachingExperience ?? _teachingExperience,
  industrialExperience: industrialExperience ?? _industrialExperience,
  motivationForTeaching: motivationForTeaching ?? _motivationForTeaching,
  linkedinProfileLink: linkedinProfileLink ?? _linkedinProfileLink,
  facebookProfileLink: facebookProfileLink ?? _facebookProfileLink,
  cv: cv ?? _cv,
  isActive: isActive ?? _isActive,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  isAlumini: isAlumini ?? _isAlumini,
  paidFees: paidFees ?? _paidFees,
  pendingFees: pendingFees ?? _pendingFees,
  isHold: isHold ?? _isHold,
  age: age ?? _age,
  address: address ?? _address,
  paymentMode: paymentMode ?? _paymentMode,
  paymentDetails: paymentDetails ?? _paymentDetails,
  // documentSubmitted: documentSubmitted ?? _documentSubmitted,
  startDateCourse: startDateCourse ?? _startDateCourse,
  enrolledBy: enrolledBy ?? _enrolledBy,
  totalFees: totalFees ?? _totalFees,
  aadharCard: aadharCard ?? _aadharCard,
  receipt: receipt ?? _receipt,
  photo: photo ?? _photo,
  familyBackground: familyBackground ?? _familyBackground,
  country: country ?? _country,
  state: state ?? _state,
  city: city ?? _city,
  countryName: countryName ?? _countryName,
  stateName: stateName ?? _stateName,
  cityName: cityName ?? _cityName,
  hourlyRate: hourlyRate ?? _hourlyRate,
  bankName: bankName ?? _bankName,
  accountNo: accountNo ?? _accountNo,
  ifscCode: ifscCode ?? _ifscCode,
  about: about ?? _about,
  past: past ?? _past,
  skills: skills ?? _skills,
  education: education ?? _education,
  altEmail: altEmail ?? _altEmail,
  invoiceFile: invoiceFile ?? _invoiceFile,
  paymentModeCash: paymentModeCash ?? _paymentModeCash,
  paymentModeCheque: paymentModeCheque ?? _paymentModeCheque,
  paymentModeNetbanking: paymentModeNetbanking ?? _paymentModeNetbanking,
  paymentModeCashAmount: paymentModeCashAmount ?? _paymentModeCashAmount,
  paymentModeChequeAmount: paymentModeChequeAmount ?? _paymentModeChequeAmount,
  paymentModeNetbankingAmount: paymentModeNetbankingAmount ?? _paymentModeNetbankingAmount,
  holdingSeat: holdingSeat ?? _holdingSeat,
  enrolledInCourse: enrolledInCourse ?? _enrolledInCourse,
  holdingSeatDesc: holdingSeatDesc ?? _holdingSeatDesc,
  enrolledInCourseDesc: enrolledInCourseDesc ?? _enrolledInCourseDesc,
  panCard: panCard ?? _panCard,
  batchId: batchId ?? _batchId,
  batch: batch ?? _batch,
  paymentLink: paymentLink ?? _paymentLink,
  currentBatch: currentBatch ?? _currentBatch,
  prevBatch: prevBatch ?? _prevBatch,
);
  String? get id => _id;
  String? get courseId => _courseId;
  String? get isBatchAdmin => _isBatchAdmin;
  String? get prefixName => _prefixName;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get enrollmentNo => _enrollmentNo;
  String? get email => _email;
  String? get contactNo => _contactNo;
  String? get userType => _userType;
  String? get facultyType => _facultyType;
  String? get profilePic => _profilePic;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  String? get highestEducation => _highestEducation;
  String? get collegeName => _collegeName;
  String? get designation => _designation;
  String? get yearsOfExperience => _yearsOfExperience;
  String? get teachingExperience => _teachingExperience;
  String? get industrialExperience => _industrialExperience;
  String? get motivationForTeaching => _motivationForTeaching;
  String? get linkedinProfileLink => _linkedinProfileLink;
  String? get facebookProfileLink => _facebookProfileLink;
  String? get cv => _cv;
  String? get isActive => _isActive;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get deletedAt => _deletedAt;
  String? get isAlumini => _isAlumini;
  num? get paidFees => _paidFees;
  num? get pendingFees => _pendingFees;
  String? get isHold => _isHold;
  String? get age => _age;
  String? get address => _address;
  String? get paymentMode => _paymentMode;
  String? get paymentDetails => _paymentDetails;
  // List<String>? get documentSubmitted => _documentSubmitted;
  String? get startDateCourse => _startDateCourse;
  String? get enrolledBy => _enrolledBy;
  num? get totalFees => _totalFees;
  String? get aadharCard => _aadharCard;
  String? get receipt => _receipt;
  String? get photo => _photo;
  String? get familyBackground => _familyBackground;
  String? get country => _country;
  String? get state => _state;
  String? get city => _city;
  String? get countryName => _countryName;
  String? get stateName => _stateName;
  String? get cityName => _cityName;
  String? get hourlyRate => _hourlyRate;
  String? get bankName => _bankName;
  String? get accountNo => _accountNo;
  String? get ifscCode => _ifscCode;
  String? get about => _about;
  String? get past => _past;
  String? get skills => _skills;
  String? get education => _education;
  String? get altEmail => _altEmail;
  String? get invoiceFile => _invoiceFile;
  String? get paymentModeCash => _paymentModeCash;
  String? get paymentModeCheque => _paymentModeCheque;
  String? get paymentModeNetbanking => _paymentModeNetbanking;
  String? get paymentModeCashAmount => _paymentModeCashAmount;
  String? get paymentModeChequeAmount => _paymentModeChequeAmount;
  String? get paymentModeNetbankingAmount => _paymentModeNetbankingAmount;
  String? get holdingSeat => _holdingSeat;
  String? get enrolledInCourse => _enrolledInCourse;
  String? get holdingSeatDesc => _holdingSeatDesc;
  String? get enrolledInCourseDesc => _enrolledInCourseDesc;
  String? get panCard => _panCard;
  String? get batchId => _batchId;
  Batch? get batch => _batch;
  String? get paymentLink => _paymentLink;
  String? get currentBatch => _currentBatch;
  String? get prevBatch => _prevBatch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['course_id'] = _courseId;
    map['is_batch_admin'] = _isBatchAdmin;
    map['prefix_name'] = _prefixName;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['enrollment_no'] = _enrollmentNo;
    map['email'] = _email;
    map['contact_no'] = _contactNo;
    map['user_type'] = _userType;
    map['faculty_type'] = _facultyType;
    map['profile_pic'] = _profilePic;
    map['gender'] = _gender;
    map['date_of_birth'] = _dateOfBirth;
    map['highest_education'] = _highestEducation;
    map['college_name'] = _collegeName;
    map['designation'] = _designation;
    map['years_of_experience'] = _yearsOfExperience;
    map['teaching_experience'] = _teachingExperience;
    map['industrial_experience'] = _industrialExperience;
    map['motivation_for_teaching'] = _motivationForTeaching;
    map['linkedin_profile_link'] = _linkedinProfileLink;
    map['facebook_profile_link'] = _facebookProfileLink;
    map['cv'] = _cv;
    map['is_active'] = _isActive;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['is_alumini'] = _isAlumini;
    map['paid_fees'] = _paidFees;
    map['pending_fees'] = _pendingFees;
    map['is_hold'] = _isHold;
    map['age'] = _age;
    map['address'] = _address;
    map['payment_mode'] = _paymentMode;
    map['payment_details'] = _paymentDetails;
    // map['document_submitted'] = _documentSubmitted;
    map['start_date_course'] = _startDateCourse;
    map['enrolled_by'] = _enrolledBy;
    map['total_fees'] = _totalFees;
    map['aadhar_card'] = _aadharCard;
    map['receipt'] = _receipt;
    map['photo'] = _photo;
    map['family_background'] = _familyBackground;
    map['country'] = _country;
    map['state'] = _state;
    map['city'] = _city;
    map['country_name'] = _countryName;
    map['state_name'] = _stateName;
    map['city_name'] = _cityName;
    map['hourly_rate'] = _hourlyRate;
    map['bank_name'] = _bankName;
    map['account_no'] = _accountNo;
    map['ifsc_code'] = _ifscCode;
    map['about'] = _about;
    map['past'] = _past;
    map['skills'] = _skills;
    map['education'] = _education;
    map['alt_email'] = _altEmail;
    map['invoice_file'] = _invoiceFile;
    map['payment_mode_cash'] = _paymentModeCash;
    map['payment_mode_cheque'] = _paymentModeCheque;
    map['payment_mode_netbanking'] = _paymentModeNetbanking;
    map['payment_mode_cash_amount'] = _paymentModeCashAmount;
    map['payment_mode_cheque_amount'] = _paymentModeChequeAmount;
    map['payment_mode_netbanking_amount'] = _paymentModeNetbankingAmount;
    map['holding_seat'] = _holdingSeat;
    map['enrolled_in_course'] = _enrolledInCourse;
    map['holding_seat_desc'] = _holdingSeatDesc;
    map['enrolled_in_course_desc'] = _enrolledInCourseDesc;
    map['pan_card'] = _panCard;
    map['batch_id'] = _batchId;
    if (_batch != null) {
      map['batch'] = _batch?.toJson();
    }
    map['payment_link'] = _paymentLink;
    map['current_batch'] = _currentBatch;
    map['prev_batch'] = _prevBatch;
    return map;
  }

}

/// name : "JRE09"
/// timezone : "Afternoon"
/// duration : "1:30 PM to 4:30 PM"
/// start_date : "1st December 2023"
/// end_date : "24th January 2024"

Batch batchFromJson(String str) => Batch.fromJson(json.decode(str));
String batchToJson(Batch data) => json.encode(data.toJson());
class Batch {
  Batch({
      String? name, 
      String? timezone, 
      String? duration, 
      String? startDate, 
      String? endDate,}){
    _name = name;
    _timezone = timezone;
    _duration = duration;
    _startDate = startDate;
    _endDate = endDate;
}

  Batch.fromJson(dynamic json) {
    _name = json['name'];
    _timezone = json['timezone'];
    _duration = json['duration'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
  }
  String? _name;
  String? _timezone;
  String? _duration;
  String? _startDate;
  String? _endDate;
Batch copyWith({  String? name,
  String? timezone,
  String? duration,
  String? startDate,
  String? endDate,
}) => Batch(  name: name ?? _name,
  timezone: timezone ?? _timezone,
  duration: duration ?? _duration,
  startDate: startDate ?? _startDate,
  endDate: endDate ?? _endDate,
);
  String? get name => _name;
  String? get timezone => _timezone;
  String? get duration => _duration;
  String? get startDate => _startDate;
  String? get endDate => _endDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['timezone'] = _timezone;
    map['duration'] = _duration;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    return map;
  }

}