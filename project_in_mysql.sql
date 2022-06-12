# use the employee database
use employees;

#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> case 1 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################

#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Run code <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################
                                       
select * from current_dept_emp
 where ( to_date between '2000-12-31' and '9999-01-01') and (from_date <= '2000-12-31')
 ORDER BY dept_no;

select emp_no , first_name , hire_date , gender from employees where  hire_date between '1995-01-01' and '2000-12-31'  ; 

select count(IF(gender='F',1,null)), count(IF(gender='M',1,null)) from employees where hire_date > '1995-01-01'  ;
 
 select from_date,to_date,salary,emp_no from salaries
where ( to_date between '2000-12-31' and '9999-01-01') and (from_date <= '2000-12-31') ;

  select emp_no,from_date,to_date,first_name,last_name,salary,dept_name,title from titles_V111 
    group by emp_no
    order by emp_no;

#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> View sssss <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################
 
    CREATE OR REPLACE VIEW dept_employees_V AS
   SELECT d.emp_no, d.from_date, d.to_date, e.first_name, e.last_name, e.gender, e.hire_date 
   from employees e
   join dept_emp d on e.emp_no=d.emp_no;

 # run for firest view 
	select * from dept_employees_V;

# viev number two 
	CREATE OR REPLACE VIEW emp_dept_and_Sal_V AS    
    SELECT d.emp_no, e.first_name, e.last_name, e.gender, e.hire_date,s.from_date , s.to_date , s.salary 
   from employees e
   join dept_employees_v d on e.emp_no=d.emp_no
   join  salaries_v1 s ON e.emp_no = s.emp_no
   where ( s.to_date between '2000-12-31' and '9999-01-01') and (s.from_date <= '2000-12-31')
   group by e.gender, e.emp_no;

 # run for two view 
select * from emp_dept_and_Sal_V;

    select dept_name from departments;
    

   
   # viev number three
  CREATE OR REPLACE VIEW salaries_V1 AS
    select emp_no,salary,from_date,to_date from salaries
   where ( to_date between '2000-12-31' and '9999-01-01') and (from_date <= '2000-12-31') ;
   
   
   CREATE OR REPLACE VIEW titles_V111 AS
   SELECT e.emp_no, e.from_date, e.to_date, e.first_name, e.last_name, e.gender, e.hire_date,e.salary ,d.dept_no,d.dept_name,t.title 
   from emp_dept_and_Sal_V e
    join titles t on e.emp_no=t.emp_no
	join dept_emp de on e.emp_no=de.emp_no
    join departments d on de.dept_no=d.dept_no
    where (e.to_date between '2000-12-31' and '9999-01-01') and (e.from_date <= '2000-12-31');
    
       select * from titles_V111;
  
#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> query <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################

# this code for avg salary in current_dept_emp without condition

select count(e.emp_no) , de.dept_no, d.dept_name ,e.gender,e.from_date,e.to_date from emp_dept_and_Sal_V as e join current_dept_emp as de on e.emp_no = de.emp_no 
join departments as d on de.dept_no = d.dept_no 
 where e.hire_date > '1994-12-31'
group by e.gender, d.dept_name
ORDER BY de.dept_no;

/* # this code for avg salary in current_dept_emp with condition
select count(e.emp_no) , de.dept_no, d.dept_name ,e.gender , avg(s.salary) from employees as e join current_dept_emp as s on e.emp_no = s.emp_no 
join dept_emp as de on e.emp_no = de.emp_no join departments as d on de.dept_no = d.dept_no 
group by e.gender, d.dept_name 
ORDER BY de.dept_no;*/

  /*# this code for avg salary  in salaries_v1
select count(e.emp_no) , de.dept_no, d.dept_name ,e.gender , avg(s.salary) , s.to_date,s.from_date from employees as e join salaries_v1 as s on e.emp_no = s.emp_no 
join current_dept_emp as de on e.emp_no = de.emp_no join departments as d on de.dept_no = d.dept_no 
group by e.gender, d.dept_name 
ORDER BY de.dept_no;*/
#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> commint <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################
    
/*select emp_no,first_name,last_name,gender,hire_date from dept_employees_V
   where (hire_date between '1985-1-1' and '2000-12-31');
   select * from New_salaries_V ;
   select  * from dept_employees_V ;
   SELECT emp_no,first_name,gender from employees
    WHERE
    hire_date between '1985-1-1' and '2000-12-31';
    SELECT emp_no,first_name,gender,hire_date from employees
    WHERE
    hire_date between '1985-1-1' and '2000-12-31';*/
/*SELECT FLOOR(DATEDIFF(DAY, birth_date, "2000-01-01") / 365.25);

select * from employees;

INSERT INTO employees(age) SELECT FLOOR(DATEDIFF(DAY, birth_date, "2000-01-01") / 365.25); 

SELECT FLOOR(DATEDIFF(DAY, birth_date, "2000-01-01") / 365.25);
SELECT DATEDIFF(hour,@dob,GETDATE())/8766 AS AgeYearsIntTrunc */
# select count(IF(gender='F',1,null)), count(IF(gender='M',1,null)) from employees ;
#select count(emp_no)  from salaries_v;
#where ( to_date between '2000-12-31' and '9999-01-01') and (from_date <= '2000-12-31');
#GROUP BY d.dept_no;



#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> case 2 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################

# use the employee database
use employees;

select * from employees; # find how many employees in my campany
# save the info for the current employee
create view employee_now As   
select from_date , to_date  , emp_no  from 
salaries 
where (to_date between '2000-12-31' and '9999-01-01') and (from_date <= '2000-12-31');

 Select * from employee_now ;# find how many current employees
 
 # find the department no for each employee 
 create view dep_now_emp As 
 select n.from_date , n.to_date , n.emp_no , dep.dept_no from 
 employee_now n
 join
 dept_emp dep on dep.emp_no = n.emp_no
 group by n.emp_no;
 
 select * from dep_now_emp;# test
 select * from dep_now_emp group by emp_no; # that mean there are such as employee how work in many department 

CREATE OR REPLACE VIEW current_employees As 
 SELECT de.emp_no, de.dept_no , de.from_date , de.to_date ,e.first_name , e.last_name FROM 
 dep_now_emp de
 left join
 employees e on e.emp_no = de.emp_no
 union
 SELECT de.emp_no, de.dept_no , de.from_date , de.to_date ,e.first_name , e.last_name FROM 
 dep_now_emp de
 right join
 employees e on e.emp_no = de.emp_no
 group by de.emp_no;
  # create view for save the current employee
 
select * from current_employees; # for test 

# find out the total amount of the salaries for each department  
# find out the current employee with related department and creat the view
create view current_emp_dept As
select ce.emp_no, ce.dept_no , ce.from_date , ce.to_date , ce.first_name , ce.last_name , d.dept_name  from
    current_employees ce
 left join
	departments d on d.dept_no = ce.dept_no
 union 
 
 select ce.emp_no, ce.dept_no , ce.from_date , ce.to_date , ce.first_name , ce.last_name , d.dept_name  from
    current_employees ce
 right join
	departments d on d.dept_no = ce.dept_no
    group by ce.emp_no;
    
select * from current_emp_dept;

# find out the salary for each current employee and i will create view for it 
create  view s_emp As
select ced.emp_no, ced.dept_no , ced.from_date , ced.to_date, ced.dept_name , ced.first_name , ced.last_name, s.salary from
  current_emp_dept ced
  left join 
  salaries s on s.emp_no = ced.emp_no
  union
  select ced.emp_no, ced.dept_no , ced.from_date , ced.to_date, ced.dept_name , ced.first_name , ced.last_name, s.salary from
  current_emp_dept ced
  left join 
  salaries s on s.emp_no = ced.emp_no
  group by ced.emp_no;
  
select * from s_emp;#test # there is duplacit because the employee work in many department

# sum the  salary for each departments and the last salary of each employee
create view Current_emp_dept_salary As
select first_name , last_name , dept_name , dept_no , from_date , to_date , emp_no , sum(salary) as sal
from s_emp 
group by dept_name
having sum(salary) = (
select max(salary) from s_emp 
group by emp_no
);

select * from Current_emp_dept_salary where to_date between '1999-01-01' and '1999-12-31'; # for test 

 
# the total salary of all employee in 1999 
select sal from Current_emp_dept_salary where to_date between '1999-01-01' and '1999-12-31';# for test

select distinct title from titles group by title; # find the type of titles for check = 7 type of title

# find the title and the other information employee in 1999 --- create view
create view Current_emp_dept_salary As
select c.emp_no , c.first_name , c.last_name , c.dept_no , c.from_date , c.to_date , c.dept_name , c.sal , t.title from
Current_emp_dept_salary c
left join
titles t on t.emp_no = c.emp_no
union
select c.emp_no , c.first_name , c.last_name , c.dept_no , c.from_date , c.to_date , c.dept_name , c.sal , t.title from
Current_emp_dept_salary c
right join
titles t on t.emp_no = c.emp_no
where c.to_date between '1999-01-01' and '1999-12-31';

select * from Current_emp_dept_salary;


#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> case 3 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################
# use the employee database
use employee;

select emp_no, to_date,salary from dsemp
where
to_date between '2000-12-31'and'2001-02-01'
group by emp_no;

#####################################################################################################
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> View sssss <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< */
#####################################################################################################
create or replace view DSEmp as 
select dept_emp.emp_no, dept_emp.to_date, salaries.salary
from dept_emp
inner join salaries
on dept_emp.emp_no=salaries.emp_no;

CREATE OR REPLACE VIEW current_emp_V AS 
Select * from salaries
where ( to_date between '2000-12-31' and '9999-01-01') and (from_date <= '2000-12-31');

select * from current_emp_V;

Select * from current_emp_V v
Join employees e
on e.emp_no = v.emp_no
where (hire_date between '1985-01-01' and '1985-12-31')
and (to_date >= '2001-02-01');

Select * from current_emp_V v
Join employees e
on e.emp_no = v.emp_no
where (hire_date between '1986-01-01' and '1986-12-31')
and (to_date >= '2001-02-01');

Select * from current_emp_V v
Join employees e
on e.emp_no = v.emp_no
where (hire_date between '1987-01-01' and '1987-12-31')
and (to_date >= '2001-02-01');

Select * from current_emp_V v
Join employees e
on e.emp_no = v.emp_no
where (hire_date between '1988-01-01' and '1988-12-31')
and (to_date >= '2001-02-01');

Select * from current_emp_V v
Join employees e
on e.emp_no = v.emp_no
where (hire_date between '1989-01-01' and '1989-12-31')
and (to_date >= '2001-02-01');

Select * from current_emp_V v
Join employees e
on e.emp_no = v.emp_no
where (hire_date between '1990-01-01' and '1990-12-31')
and (to_date >= '2001-02-01');


