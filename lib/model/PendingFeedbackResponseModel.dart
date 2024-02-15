import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
/// success : "1"
/// message : "success"
/// records : [{"class_id":"62","module_name":"Marketing, branding and Sales","topics":" Elevator Pitch, Qualities of Sales Man","class_no":"JRE10-class39","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"57","module_name":"Finance and Taxation","topics":"Time value for money, Valuation  & Capital markets ","class_no":"JRE10-class34","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"125","module_name":"Project Design, Planning and Viability","topics":"Policies : Hotel, Hospitality, Case Studies \t\t\t","class_no":"JRE11-class19","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"369","module_name":"Marketing, branding and Sales","topics":"Use of AI in RE Sales & Marketing","class_no":"JRE10-class41","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"124","module_name":"Project Design, Planning and Viability","topics":" Design of Real Estate, Site Planning & Unit Planning Builtup calculations CC to BU Process\"\t\t\t\t","class_no":"JRE11-class18","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"61","module_name":"Marketing, branding and Sales","topics":"Digital Marketing, Social Media & Sales\t\t","class_no":"JRE10-class38","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"123","module_name":"Project Design, Planning and Viability","topics":" GDCR- Byelaws, Building Height, Gamthal, Zones\t\t","class_no":"JRE11-class17","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"60","module_name":"Marketing, branding and Sales","topics":"Branding & Marketing on RE projects\t","class_no":"JRE10-class37","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"122","module_name":"Finance and Taxation","topics":" Case studies on JV, JD & IRR","class_no":"JRE11-class16","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"58","module_name":"Finance and Taxation","topics":" Accounting & Auditing practices in RE","class_no":"JRE10-class35","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"121","module_name":"Finance and Taxation","topics":" Intro, PV, FV, oppt. cost & leaverage","class_no":"JRE11-class15","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"111","module_name":"Land Planning and Development ","topics":"\"Dr. Jigar Pandya JV-JD-Models TPS Case Studies TDR \"\t\t\t\t","class_no":"JRE11-class14","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"56","module_name":"RERA","topics":"Litigations & RERA case studies\t\t\t","class_no":"JRE10-class33","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"55","module_name":"RERA","topics":"Gift City Planning & RERA litigitations\t\t","class_no":"JRE10-class32","lecture_type":"Guest","feedback_form_id":"4","feedback_form_data":{"form_id":"4","form_name":"Guest Session Feedback Form","form_type":"feedback","questions":[{"question_id":"5","form_id":"4","title":"How useful was the guest session on Mr. Manan  Doshi ?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"6","options":"Very useful","correct_answer":""},{"opt_id":"7","options":"Fairly useful","correct_answer":""}]},{"question_id":"6","form_id":"4","title":"Feedback note","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"21","module_name":"Legal and Documentation","topics":"Transfer of Property Act, Land Tenancy Act, Land Revenue Code","class_no":"JRE11-class13","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"54","module_name":"Finance and Taxation","topics":" Direct Taxes, Accounting & Forms of Ownership","class_no":"JRE10-class31","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"20","module_name":"Legal and Documentation","topics":"Contract Act, Bailment Case Studies","class_no":"JRE11-class12","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"19","module_name":"Land and Revenue ","topics":"Industrial Land/Logistics & Case Studies","class_no":"JRE11-class11","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"53","module_name":"RERA","topics":"RERA Project Costing and Auditing,Customer documentation","class_no":"JRE10-class30","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"52","module_name":"RERA","topics":"RERA Functions of Promotor,Complancies & Case Studies","class_no":"JRE10-class29","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"51","module_name":"RERA","topics":"RERA Introduction and Basic Concept\"\t\t\t\t","class_no":"JRE10-class28","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"16","module_name":"Entrepreneurship in Real Estate","topics":"Proptech & Trends in Entrepreneurship","class_no":"JRE11-class8","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"50","module_name":"Project Design, Planning and Viability","topics":"Project Activity","class_no":"JRE10-class27","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"15","module_name":"Land and Revenue ","topics":"Agricultral Land, NA","class_no":"JRE11-class7","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"14","module_name":"Land Planning and Development ","topics":"Development Plan & Zones- FSI Carpet Area,  Superbuilt up Area","class_no":"JRE11-class6","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"49","module_name":"Construction Management","topics":"Site execution, Finance and Monitoring with advance Technology","class_no":"JRE10-class26","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"48","module_name":"Construction Management","topics":"Site Visit","class_no":"JRE10-class25","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"47","module_name":"Construction Management","topics":"  Cost Estimation & activity planning\t\t\t","class_no":"JRE10-class24","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"12","module_name":"Project Review and Jury Presentation","topics":"Groups formation, Location Analysis, Market Cycle","class_no":"JRE11-class13","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"46","module_name":"Construction Management","topics":"CM Stake Holder & their roles,Site Planning","class_no":"JRE10-class23","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"11","module_name":"Introduction to Real Estate","topics":"Project cycle,  Case Studies","class_no":"JRE11-class4","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"45","module_name":"Marketing, branding and Sales","topics":"Sales & CP Strategy for developers Mr. Bhavesh Pandya\"","class_no":"JRE10-class22","lecture_type":"Guest","feedback_form_id":"4","feedback_form_data":{"form_id":"4","form_name":"Guest Session Feedback Form","form_type":"feedback","questions":[{"question_id":"5","form_id":"4","title":"How useful was the guest session on Mr. Jay Purohit ?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"6","options":"Very useful","correct_answer":""},{"opt_id":"7","options":"Fairly useful","correct_answer":""}]},{"question_id":"6","form_id":"4","title":"Feedback note","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"10","module_name":"Introduction to Real Estate","topics":"History, Trends & Asset Classes","class_no":"JRE11-class2","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"43","module_name":"Project Design, Planning and Viability","topics":"Green Building ","class_no":"JRE10-class20","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"44","module_name":"Project Design, Planning and Viability","topics":"MEPF","class_no":"JRE10-class21","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"42","module_name":"Project Design, Planning and Viability","topics":"Project Viability - project Launch to IRR calculations ","class_no":"JRE10-class19","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"41","module_name":"Project Design, Planning and Viability","topics":"Policies : Hotel, Hospitality, Case Studies  \t\t\t","class_no":"JRE10-class18","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"40","module_name":"Project Design, Planning and Viability","topics":"Design of Real Estate SIte Planning & Unit Planning Builtup calculations CC to BU Process ","class_no":"JRE10-class17","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"39","module_name":"Project Design, Planning and Viability","topics":"\"GDCR- Byelaws, Building Height, Gamthal, Zones ","class_no":"JRE10-class16","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"38","module_name":"Land Planning and Development ","topics":"Negotiations Buyer & Seller Group Activity  ","class_no":"JRE10-class15","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"37","module_name":"Entrepreneurship in Real Estate","topics":"\"Alternate Real Estate Presentation Learner's Group  Presentations ","class_no":"JRE10-class14","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"36","module_name":"Land Planning and Development ","topics":"AUDA SITE VISIT","class_no":"JRE10-class13","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"35","module_name":"Legal and Documentation","topics":" Legal Transfer of Property Act, Land Tenancy Act, Land Revenue Code \t\t\t","class_no":"JRE10-class12","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"34","module_name":"Legal and Documentation","topics":"Legal Contract Act, Bailment Case Studies\"","class_no":"JRE10-class11","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"33","module_name":"Entrepreneurship in Real Estate","topics":"Mega Trends Problem Identification\"","class_no":"JRE10-class10","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"32","module_name":"Land Planning and Development ","topics":" JV-JD-Models Sale, Lease, Mortgage, TItle ","class_no":"JRE10-class9","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"31","module_name":"Land Planning and Development ","topics":" Micro PlanningTP Schemes  Other State Models","class_no":"JRE10-class8","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"30","module_name":"Land Planning and Development ","topics":" Development Plan & Zones- FSI","class_no":"JRE10-class7","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"29","module_name":"Land and Revenue ","topics":"Land and Revenue","class_no":"JRE10-class6","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"28","module_name":"Land and Revenue ","topics":"Land and Revenue","class_no":"JRE10-class5","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"27","module_name":"Land and Revenue ","topics":"Land and Revenue","class_no":"JRE10-class4","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"26","module_name":"Introduction to Real Estate","topics":"Intro to RE","class_no":"JRE10-class3","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}},{"class_id":"25","module_name":"Introduction to Real Estate","topics":"Intro to RE","class_no":"JRE10-class2","lecture_type":"Normal","feedback_form_id":"1","feedback_form_data":{"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}}]
/// total_records : "54"

PendingFeedbackResponseModel pendingFeedbackResponseModelFromJson(String str) => PendingFeedbackResponseModel.fromJson(json.decode(str));
String pendingFeedbackResponseModelToJson(PendingFeedbackResponseModel data) => json.encode(data.toJson());
class PendingFeedbackResponseModel {
  PendingFeedbackResponseModel({
      String? success, 
      String? message, 
      List<Records>? records, 
      String? totalRecords,}){
    _success = success;
    _message = message;
    _records = records;
    _totalRecords = totalRecords;
}

  PendingFeedbackResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['records'] != null) {
      _records = [];
      json['records'].forEach((v) {
        _records?.add(Records.fromJson(v));
      });
    }
    _totalRecords = json['total_records'];
  }
  String? _success;
  String? _message;
  List<Records>? _records;
  String? _totalRecords;
PendingFeedbackResponseModel copyWith({  String? success,
  String? message,
  List<Records>? records,
  String? totalRecords,
}) => PendingFeedbackResponseModel(  success: success ?? _success,
  message: message ?? _message,
  records: records ?? _records,
  totalRecords: totalRecords ?? _totalRecords,
);
  String? get success => _success;
  String? get message => _message;
  List<Records>? get records => _records;
  String? get totalRecords => _totalRecords;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_records != null) {
      map['records'] = _records?.map((v) => v.toJson()).toList();
    }
    map['total_records'] = _totalRecords;
    return map;
  }

}

/// class_id : "62"
/// module_name : "Marketing, branding and Sales"
/// topics : " Elevator Pitch, Qualities of Sales Man"
/// class_no : "JRE10-class39"
/// lecture_type : "Normal"
/// feedback_form_id : "1"
/// feedback_form_data : {"form_id":"1","form_name":"Session Feedback Form","form_type":"feedback","questions":[{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]}

Records recordsFromJson(String str) => Records.fromJson(json.decode(str));
String recordsToJson(Records data) => json.encode(data.toJson());
class Records {
  Records({
      String? classId, 
      String? moduleName, 
      String? facultyName,
      String? topics,
      String? classNo, 
      String? lectureType, 
      String? feedbackFormId, 
      FeedbackFormData? feedbackFormData,}){
    _classId = classId;
    _moduleName = moduleName;
    _facultyName = facultyName;
    _topics = topics;
    _classNo = classNo;
    _lectureType = lectureType;
    _feedbackFormId = feedbackFormId;
    _feedbackFormData = feedbackFormData;
}

  Records.fromJson(dynamic json) {
    _classId = json['class_id'];
    _moduleName = json['module_name'];
    _facultyName = json['faculty_name'];
    _topics = json['topics'];
    _classNo = json['class_no'];
    _lectureType = json['lecture_type'];
    _feedbackFormId = json['feedback_form_id'];
    _feedbackFormData = json['feedback_form_data'] != null ? FeedbackFormData.fromJson(json['feedback_form_data']) : null;
  }
  String? _classId;
  String? _moduleName;
  String? _facultyName;
  String? _topics;
  String? _classNo;
  String? _lectureType;
  String? _feedbackFormId;
  FeedbackFormData? _feedbackFormData;
Records copyWith({  String? classId,
  String? moduleName,
  String? facultyName,
  String? topics,
  String? classNo,
  String? lectureType,
  String? feedbackFormId,
  FeedbackFormData? feedbackFormData,
}) => Records(  classId: classId ?? _classId,
  moduleName: moduleName ?? _moduleName,
  facultyName: facultyName ?? _facultyName,
  topics: topics ?? _topics,
  classNo: classNo ?? _classNo,
  lectureType: lectureType ?? _lectureType,
  feedbackFormId: feedbackFormId ?? _feedbackFormId,
  feedbackFormData: feedbackFormData ?? _feedbackFormData,
);
  String? get classId => _classId;
  String? get moduleName => _moduleName;
  String? get facultyName => _facultyName;
  String? get topics => _topics;
  String? get classNo => _classNo;
  String? get lectureType => _lectureType;
  String? get feedbackFormId => _feedbackFormId;
  FeedbackFormData? get feedbackFormData => _feedbackFormData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['class_id'] = _classId;
    map['module_name'] = _moduleName;
    map['topics'] = _topics;
    map['class_no'] = _classNo;
    map['lecture_type'] = _lectureType;
    map['feedback_form_id'] = _feedbackFormId;
    if (_feedbackFormData != null) {
      map['feedback_form_data'] = _feedbackFormData?.toJson();
    }
    return map;
  }

}

/// form_id : "1"
/// form_name : "Session Feedback Form"
/// form_type : "feedback"
/// questions : [{"question_id":"1","form_id":"1","title":"How did you find today's session?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]},{"question_id":"2","form_id":"1","title":"How did you find today's faculty?","input_id":"2","input_name":"radio","no_lines":"","status":"1","options":[{"opt_id":"4","options":"Excellent","correct_answer":""},{"opt_id":"5","options":"Could be better","correct_answer":""}]},{"question_id":"3","form_id":"1","title":"What are your key take away from today's session?","input_id":"4","input_name":"textarea","no_lines":"","status":"1","options":[]}]

FeedbackFormData feedbackFormDataFromJson(String str) => FeedbackFormData.fromJson(json.decode(str));
String feedbackFormDataToJson(FeedbackFormData data) => json.encode(data.toJson());
class FeedbackFormData {
  FeedbackFormData({
      String? formId, 
      String? formName, 
      String? formType, 
      List<Questions>? questions,}){
    _formId = formId;
    _formName = formName;
    _formType = formType;
    _questions = questions;
}

  FeedbackFormData.fromJson(dynamic json) {
    _formId = json['form_id'];
    _formName = json['form_name'];
    _formType = json['form_type'];
    if (json['questions'] != null) {
      _questions = [];
      json['questions'].forEach((v) {
        _questions?.add(Questions.fromJson(v));
      });
    }
  }
  String? _formId;
  String? _formName;
  String? _formType;
  List<Questions>? _questions;
FeedbackFormData copyWith({  String? formId,
  String? formName,
  String? formType,
  List<Questions>? questions,
}) => FeedbackFormData(  formId: formId ?? _formId,
  formName: formName ?? _formName,
  formType: formType ?? _formType,
  questions: questions ?? _questions,
);
  String? get formId => _formId;
  String? get formName => _formName;
  String? get formType => _formType;
  List<Questions>? get questions => _questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['form_id'] = _formId;
    map['form_name'] = _formName;
    map['form_type'] = _formType;
    if (_questions != null) {
      map['questions'] = _questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// question_id : "1"
/// form_id : "1"
/// title : "How did you find today's session?"
/// input_id : "2"
/// input_name : "radio"
/// no_lines : ""
/// status : "1"
/// options : [{"opt_id":"1","options":"Excellent","correct_answer":""},{"opt_id":"2","options":"Helpful","correct_answer":""},{"opt_id":"3","options":"Could be better","correct_answer":""}]

Questions questionsFromJson(String str) => Questions.fromJson(json.decode(str));
String questionsToJson(Questions data) => json.encode(data.toJson());
class Questions {
  Questions({
    String? questionId,
    String? formId,
    String? title,
    String? inputId,
    String? inputName,
    String? noLines,
    String? status,
    bool isOpen = false,
    List<Options>? options,}){
    _questionId = questionId;
    _formId = formId;
    _title = title;
    _inputId = inputId;
    _inputName = inputName;
    _noLines = noLines;
    _status = status;
    _isOpen = isOpen;
    _options = options;
  }

  Questions.fromJson(dynamic json) {
    _questionId = json['question_id'];
    _formId = json['form_id'];
    _title = json['title'];
    _inputId = json['input_id'];
    _inputName = json['input_name'];
    _noLines = json['no_lines'];
    _status = json['status'];
    if (json['options'] != null) {
      _options = [];
      json['options'].forEach((v) {
        _options?.add(Options.fromJson(v));
      });
    }
  }
  String? _questionId;
  String? _formId;
  String? _title;
  String? _inputId;
  String? _inputName;
  String? _noLines;
  String? _status;
  bool _isOpen = false;
  List<Options>? _options;
  Questions copyWith({  String? questionId,
    String? formId,
    String? title,
    String? inputId,
    String? inputName,
    String? noLines,
    String? status,
    bool isOpen = false,
    List<Options>? options,
  }) => Questions(  questionId: questionId ?? _questionId,
    formId: formId ?? _formId,
    title: title ?? _title,
    inputId: inputId ?? _inputId,
    inputName: inputName ?? _inputName,
    noLines: noLines ?? _noLines,
    status: status ?? _status,
    isOpen: isOpen ?? _isOpen,
    options: options ?? _options,
  );
  String? get questionId => _questionId;
  String? get formId => _formId;
  String? get title => _title;
  String? get inputId => _inputId;
  String? get inputName => _inputName;
  String? get noLines => _noLines;
  String? get status => _status;
  bool get isOpen => _isOpen;
  late AnimationController animationController;

  set isOpen(bool value) {
    _isOpen = value;
  }

  List<Options>? get options => _options;
  TextEditingController controller = TextEditingController();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question_id'] = _questionId;
    map['form_id'] = _formId;
    map['title'] = _title;
    map['input_id'] = _inputId;
    map['input_name'] = _inputName;
    map['no_lines'] = _noLines;
    map['status'] = _status;
    if (_options != null) {
      map['options'] = _options?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// opt_id : "1"
/// options : "Excellent"
/// correct_answer : ""

Options optionsFromJson(String str) => Options.fromJson(json.decode(str));
String optionsToJson(Options data) => json.encode(data.toJson());
class Options {
  Options({
    String? optId,
    String? options,
    bool isSelected = false,
    String? correctAnswer,}){
    _optId = optId;
    _options = options;
    _isSelected = isSelected;
    _correctAnswer = correctAnswer;
  }

  Options.fromJson(dynamic json) {
    _optId = json['opt_id'];
    _options = json['options'];
    _correctAnswer = json['correct_answer'];
  }
  String? _optId;
  String? _options;
  bool _isSelected = false;
  String? _correctAnswer;
  Options copyWith({  String? optId,
    String? options,
    bool isSelected = false,
    String? correctAnswer,
  }) => Options(  optId: optId ?? _optId,
    options: options ?? _options,
    isSelected: isSelected ?? _isSelected,
    correctAnswer: correctAnswer ?? _correctAnswer,
  );
  String? get optId => _optId;
  String? get options => _options;
  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }

  String? get correctAnswer => _correctAnswer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['opt_id'] = _optId;
    map['options'] = _options;
    map['isSelected'] = _isSelected;
    map['correct_answer'] = _correctAnswer;
    return map;
  }

}