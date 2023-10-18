SELECT * FROM projects.patient_details;
desc patient_details;
---------Count the total number of patients in the dataset.-----------
select count(*) from patient_details;

--------Retrieve medical history of patients by gender Female------------
select sex,fname,medical_history
from patient_details
where sex='F';

--------Retrieve medical history of patients by gender Male------------
select sex,fname,medical_history
from patient_details
where sex='M';

--------Which medical history female have diagonised more ?---------
SELECT sex,medical_history, COUNT(*) AS term_count
FROM patient_details
where sex='F'
GROUP BY medical_history;

--------Which medical history male have diagonised more ?---------
SELECT sex,medical_history, COUNT(*) AS term_count
FROM patient_details
where sex='M'
GROUP BY medical_history;

---------Duration of patients in hospital--------------
set sql_safe_updates=0;

update patient_details
set admit_date=case
when admit_date like '%/%' 
then date_format(str_to_date(admit_date,'%m/%d/%Y'),'%Y-%m-%d')
when admit_date like '%-%'
then date_format(str_to_date(admit_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;

alter table patient_details
modify column admit_date date;

update patient_details
set discharge_date=case
when discharge_date like '%/%' 
then date_format(str_to_date(discharge_date,'%m/%d/%Y'),'%Y-%m-%d')
when discharge_date like '%-%'
then date_format(str_to_date(discharge_date,'%m-%d-%Y'),'%Y-%m-%d')
else null
end;

alter table patient_details
modify column discharge_date date;

select fname, datediff (discharge_date , admit_date) as duration
from patient_details;

-------------Patients of both gender having diabetes---------- 
select medical_history,sex,count(*) as count
from patient_details
where medical_history='diabetes'
group by sex;

--------------Count of patients by diagnosis--------------
select medical_history,count(medical_history) as count
from patient_details
group by  medical_history;

--------------which diagonised patients stayed longer duration in hospital----------------
select fname, medical_history,datediff (discharge_date , admit_date) as duration 
from patient_details
where datediff (discharge_date , admit_date)>=1
group by  medical_history,fname,duration;

