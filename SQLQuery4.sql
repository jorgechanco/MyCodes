-- First

create table #students (
    id INTEGER PRIMARY KEY,
    firstName VARCHAR(30) NOT NULL,
    lastName VARCHAR(30) NOT NULL
	)

insert into #students values (1, 'John','Smith')
insert into #students values (2, 'John','Smith')
insert into #students values (3, 'Adam','King')

select count(*) from #students where firstname = 'John'

-------------------------------------------
-- Second
Create TABLE #enrollments (
    id INTEGER NOT NULL PRIMARY KEY
   ,year INTEGER NOT NULL
   ,studentId INTEGER NOT NULL
   )

insert into #enrollments values (1,2001,111)
insert into #enrollments values (2,2002,112)
insert into #enrollments values (3,2003,113)
insert into #enrollments values (20,2003,114)
insert into #enrollments values (21,2003,115)
insert into #enrollments values (100,2003,116)

select * from #enrollments

select * from #enrollments where id between 20 and 100

update #enrollments set year = 2015 where id between 20 and 100

-------------------------------------------
-- third
 CREATE TABLE #dogs (
   id INTEGER NOT NULL PRIMARY KEY,
   name VARCHAR(50) NOT NULL
 );

 CREATE TABLE #cats (
   id INTEGER NOT NULL PRIMARY KEY,
   name VARCHAR(50) NOT NULL
 );

 INSERT INTO #dogs(id, name) values(1, 'Lola');
 INSERT INTO #dogs(id, name) values(2, 'Bella');
 INSERT INTO #cats(id, name) values(1, 'Lola');
 INSERT INTO #cats(id, name) values(2, 'Kitty');

 select name from #dogs
 union
 select name from #cats

 -------------------------------------------
 -- 4th
  CREATE TABLE #sessions (
   id INTEGER NOT NULL PRIMARY KEY,
   userId INTEGER NOT NULL,
   duration DECIMAL NOT NULL
 );

 INSERT INTO #sessions(id, userId, duration) VALUES(1, 1, 10);
 INSERT INTO #sessions(id, userId, duration) VALUES(2, 2, 18);
 INSERT INTO #sessions(id, userId, duration) VALUES(3, 1, 14);

 select * from #sessions

 select 
   userid as UserId
 , avg(duration) as AverageDuration 
 from #sessions  
 Group by userID
 having (count(id) > 1)

 -------------------------------------------
-- 5th
drop table xSellers
drop table xiTEMS

 CREATE TABLE Xsellers (
   id INTEGER NOT NULL PRIMARY KEY,
   name VARCHAR(30) NOT NULL,
   rating INTEGER NOT NULL
 );

 CREATE TABLE Xitems (
   id INTEGER NOT NULL PRIMARY KEY,
   name VARCHAR(30) NOT NULL,
   sellerId INTEGER REFERENCES Xsellers(id)
 );

 INSERT INTO Xsellers(id, name, rating) VALUES(1, 'Roger', 3);
 INSERT INTO Xsellers(id, name, rating) VALUES(2, 'Penny', 5);

 INSERT INTO Xitems(id, name, sellerId) VALUES(1, 'Notebook', 2);
 INSERT INTO Xitems(id, name, sellerId) VALUES(2, 'Stapler', 1);
 INSERT INTO Xitems(id, name, sellerId) VALUES(3, 'Pencil', 2);

 -- Write a query that selects the item name and the name of its seller for each item that belongs to a seller with a rating greater than 4.

 select * from Xsellers
 select * from Xitems


 select I.name as "Item Name", S.name as "Seller Name"
 from Xitems I
 join Xsellers S on S.id = i.sellerId
					and s.rating > 4

-------------------------------------------
--6th
drop table Xemployees

 CREATE TABLE Xemployees (
   id INTEGER NOT NULL PRIMARY KEY,
   managerId INTEGER REFERENCES Xemployees(id),
   name VARCHAR(30) NOT NULL
 );

 INSERT INTO Xemployees(id, managerId, name) VALUES(1, NULL, 'John');
 INSERT INTO Xemployees(id, managerId, name) VALUES(2, 1, 'Mike');


 select * from xEmployees
 -- Write a query that selects the names of employees who are not managers.
 select name
 from Xemployees
 where id not in ( select x2.managerId 
					from xEmployees x2 
					where x2.managerId is not null)

-------------------------------------------
--7th
drop table xusers
drop table xroles

 CREATE TABLE Xusers (
   id INTEGER NOT NULL PRIMARY KEY,
   userName VARCHAR(50) NOT NULL
 );

 CREATE TABLE Xroles (
   id INTEGER NOT NULL PRIMARY KEY,
   role VARCHAR(20) NOT NULL
 );

 INSERT INTO Xusers(id, userName) VALUES(1, 'Steven Smith');
 INSERT INTO Xusers(id, userName) VALUES(2, 'Brian Burns');

 INSERT INTO Xroles(id, role) VALUES(1, 'Project Manager');
 INSERT INTO Xroles(id, role) VALUES(2, 'Solution Architect');

 -- Improve the create table statement below:
 CREATE TABLE users_roles (
   userId INTEGER,
   roleId INTEGER
 );

 -- Modify the provided SQLite create table statement so that:
--
--     Only users from the users table can exist within users_roles.
--     Only roles from the roles table can exist within users_roles.
--     A user can only have a specific role once.

select * from XUsers
select * from xroles



 -- Improve the create table statement below:
 CREATE TABLE Xusers_roles (
   userId INTEGER not null,
   roleId INTEGER not null,
   foreign key (UserID) references xUsers(id),
   foreign key (roleID) references xRoles(id),
   unique(userID, RoleID)
 );


  -- The statements below should pass.
 INSERT INTO xusers_roles(userId, roleId) VALUES(1, 1);
 INSERT INTO xusers_roles(userId, roleId) VALUES(1, 2);
 INSERT INTO xusers_roles(userId, roleId) VALUES(2, 2);

 -- The statement below should fail.
 INSERT INTO xusers_roles(userId, roleId) VALUES(2, NULL);


 --- xtra 1
create table #Users (
    id INTEGER PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Sex VARCHAR(1) 
	)


create table #Friends (
User1 INTEGER not null,
User2 Int not null
)


insert into #Users values (1,'ann',null)
insert into #Users values (2,'steve','m')
insert into #Users values (3,'mary','f')
insert into #Users values (4,'brenda','f')

insert into #friends values (1,2)
insert into #friends values (1,3)
insert into #friends values (2,3)


SELECT #users.name, COUNT(*) as count FROM #users
LEFT JOIN #friends
ON #users.id = #friends.user1 OR #users.id = #friends.user2
WHERE #users.sex = 'f'
GROUP BY #users.id,#users.name;

-- xtra 2
-- Example case create statement:
CREATE TABLE Xregions(
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);
CREATE TABLE Xstates(
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  regionId INTEGER NOT NULL REFERENCES Xregions(id)
); 

DROP TABLe xEmployees
CREATE TABLE Xemployees (
  id INTEGER PRIMARY KEY,
  name VARCHAR(50) NOT NULL, 
  stateId INTEGER NOT NULL REFERENCES Xstates(id)
);
CREATE TABLE Xsales (
  id INTEGER PRIMARY KEY,
  amount INTEGER NOT NULL,
  employeeId INTEGER NOT NULL REFERENCES Xemployees(id)
);

INSERT INTO Xregions(id, name) VALUES(1, 'North');
INSERT INTO Xregions(id, name) VALUES(2, 'South');
INSERT INTO Xregions(id, name) VALUES(3, 'East');
INSERT INTO Xregions(id, name) VALUES(4, 'West');
INSERT INTO Xregions(id, name) VALUES(5, 'Midwest');
INSERT INTO Xstates(id, name, regionId) VALUES(1, 'Minnesota', 1);
INSERT INTO Xstates(id, name, regionId) VALUES(2, 'Texas', 2);
INSERT INTO Xstates(id, name, regionId) VALUES(3, 'California', 3);
INSERT INTO Xstates(id, name, regionId) VALUES(4, 'Columbia', 4);
INSERT INTO Xstates(id, name, regionId) VALUES(5, 'Indiana', 5);
INSERT INTO Xemployees(id, name, stateId) VALUES(1, 'Jaden', 1);
INSERT INTO Xemployees(id, name, stateId) VALUES(2, 'Abby', 1);
INSERT INTO Xemployees(id, name, stateId) VALUES(3, 'Amaya', 2);
INSERT INTO Xemployees(id, name, stateId) VALUES(4, 'Robert', 3);
INSERT INTO Xemployees(id, name, stateId) VALUES(5, 'Tom', 4);
INSERT INTO Xemployees(id, name, stateId) VALUES(6, 'William', 5);
INSERT INTO Xsales(id, amount, employeeId) VALUES(1, 2000, 1);
INSERT INTO Xsales(id, amount, employeeId) VALUES(2, 3000, 2);
INSERT INTO Xsales(id, amount, employeeId) VALUES(3, 4000, 3);
INSERT INTO Xsales(id, amount, employeeId) VALUES(4, 1200, 4);
INSERT INTO Xsales(id, amount, employeeId) VALUES(5, 2400, 5);

--1. The region name.
--2. Average sales per employee for the region (Average sales = Total sales made for the region / Number of employees in the region).
--3. The difference between the average sales of the region with the highest average sales, and the average sales per employee 
--for the region (average sales to be calculated as explained above).
--Employees can have multiple sales. A region with no sales should be also returned. 
--Use 0 for average sales per employee for such a region when calculating the 2nd and the 3rd column.

-- use temp table
--create table #WorkingData (
-- name varchar(50)
--,average integer
--)

--select * into #WorkingData as

drop table #WorkingData


select 
 R.name
,isnull(avg(SL.amount),0) as Average
into #WorkingData
from Xregions R
left join Xstates S on s.regionId = R.id
left join Xemployees E on E.stateId = S.id
left join Xsales SL on SL.employeeId = E.id
Group by
R.Name

select 
name
,Average
,((select max(W.Average) from #WorkingData W) - Average) as Diff
from #WorkingData

