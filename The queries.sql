# Basic one-table queries – at least 3

# Q1: How many customers do we have ?
select count(*) count from helpdesk.customers;

# Q2: Can you specify the issues we have on tickets?
select issueType, count(*) count from helpdesk.tickets group by issuetype;

# Q3 : What type of repairs do we do?
select repairDescription, count(*) count from helpdesk.repairdetails group by repairDescription;

# Multi-table queries – at least 6

# Q1: How many tickets where created by employees who work more than 10 hours
select tickets_ticketid, employeeID
from helpdesk.employees t1
join helpdesk.ticketdetails t2 on t1.employeeID = t2.employees_employeeID
where Hours > 10;

# Q2 How many repairs were done by each employee
select employeeID, employeeFirstName, employeeLastName, repairDescription
from helpdesk.employees t1
left join helpdesk.repairdetails t2 on t1.employeeID = t2.employees_employeeID
order by employeeID;

# Q3: Tickets involving Laptop issues
select tickets_ticketid, inventoryType
from helpdesk.inventory t1
join helpdesk.ticketdetails t2 on t1.assetTag = t2.inventory_assetTag
Where inventoryType = 'Laptop';

# Q4: Tickets where inventory price is more than 0
select tickets_ticketid, inventoryPrice
from helpdesk.inventory t1
join helpdesk.ticketdetails t2 on t1.assetTag = t2.inventory_assetTag
Where inventoryPrice > 0;

# Q5: Tickets where inventory condition was good
select inventoryCondition, tickets_ticketid
from helpdesk.inventory t1
join helpdesk.ticketdetails t2 on t1.assetTag = t2.inventory_assetTag
Where inventoryCondition = 'Good';

# Q6: What repairs have warranties?
select warranty, repairType
from helpdesk.repairs t1
join helpdesk.repairdetails t2 on t1.repairsID = t2.repairs_repairsID
Where warranty = 'Yes';

# Summary queries

# Q1: How many tickets each employee created
select employeeID, employeeFirstName, employeeLastName, count(*) count
from helpdesk.employees t1
join helpdesk.ticketdetails t2 on t1.employeeID = t2.employees_employeeID
group by employeeID, employeeFirstName, employeeLastName;

# Q2 How many items have/ have not warranties?
select warranty, count(*)
from helpdesk.repairs t1
join helpdesk.repairdetails t2 on t1.repairsID = t2.repairs_repairsID
group by warranty;

# Q3 What assets types at the most issues?
select inventoryType , count(*) 
from helpdesk.inventory t1
left join helpdesk.ticketdetails t2 on t1.assetTag = t2.inventory_assetTag
group by inventoryType;

# Q4 What are the condition of the asset tags?
select inventoryCondition, count(*) 
from helpdesk.inventory t1
left join helpdesk.ticketdetails t2 on t1.assetTag = t2.inventory_assetTag
group by inventoryCondition;

# Subqueries – at least 2

# Q1: Employees who dealt with tickets with inventory of over 100
Select t1.tickets_ticketid, employeeFirstName, employeeLastName
From (

select tickets_ticketid, inventoryPrice
from helpdesk.inventory t1
join helpdesk.ticketdetails t2 on t1.assetTag = t2.inventory_assetTag
Where inventoryPrice > 0) t1

join helpdesk.ticketdetails t2 on t1.tickets_ticketid = t2.tickets_ticketid
join helpdesk.employees t3 on t3.employeeID = t2.employees_employeeID;

# Q2: Employees who dealt with tickets with inventory quality good


# Create View
drop View unresolved_tickets;
Select * From helpdesk.tickets
Where ticketActivity != 'Resolved';
Select * From unresolved_tickets;


