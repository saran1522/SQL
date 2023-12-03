--Simple queries
--1.0 Display count of rows in bookings, members and facilities
--For bookings
Select COUNT(*) from cd.bookings;
--For members
Select COUNT(*) from cd.members;
--For facilities
Select COUNT(*) from cd.facilities;

--2.0 Display bookings in descending sorted order of data

SELECT * FROM cd.bookings
order by bookid desc;

--3.0 Display distinct facilities

select DISTINCT facilities.name from cd.facilities;

--4.0 Get top 3 facilities with highest member cost

Select * from cd.facilities
order by membercost desc
LIMIT 3;

--5.0 Get top 1 facilities with least montly maintenance

Select * from cd.facilities
order by monthlymaintenance
LIMIT 1;

--6.0 Get members who share same surname.

select distinct * from cd.members
order by members.surname,members.memid;

--7.0 Get members who stay in same City. If they have Boston in Address then they are in same city.

Select * from cd.members
order by split_part(members.address,',',2),members.memid;

--8.0 Get members whos surname starts with 'Sm' or 'Tr' or ends with "ll" or "ew"

Select * from cd.members
where members.surname like 'Sm%'
or members.surname like 'Tr%'
or members.surname like '%ll'
or members.surname like '%ew';


--Join Queries
--1.0 Display members who have booked facilities

Select distinct  members.memid, members.firstname,members.surname from cd.bookings
join cd.facilities
on facilities.facid = bookings.facid
join cd.members
on bookings.memid = members.memid;

--2.0 Display facilities that have been booked.

select * from cd.facilities
join cd.bookings
on bookings.facid = facilities.facid;

--3.0 Display members who have not booked facilities.

select * from cd.members
left join cd.bookings
on members.memid = bookings.memid
where bookings.memid is null;

--4.0 Display facilities that have not been booked by members.

select bookings.bookid,facilities.facid,facilities.name,bookings.memid from cd.facilities
right join cd.bookings
on facilities.facid = bookings.facid
where facilities.facid is null or bookings.memid=0;

--5.0 Display bookings with no facilities and members.

select bookings.bookid,facilities.facid,facilities.name,bookings.memid from cd.bookings
left join cd.members
on members.memid = bookings.memid
left join cd.facilities
on bookings.facid=facilities.facid
where bookings.bookid is null and bookings.facid is null;


--Aggregate Queries
--1.0 Display Total facilities usage by type (booking table)
select facilities.name,sum(bookings.slots) from cd.facilities
join cd.bookings
on bookings.facid = facilities.facid
group by facilities.name;

--2.0 Display members with total slots booked for each facility type.

select bookings.memid,facilities.facid,facilities.name,sum(bookings.slots)
from cd.bookings
join cd.facilities
on facilities.facid = bookings.facid
group by bookings.memid,facilities.facid
order by memid;

--3.0 Display top 3 members with maximum faciliy usage (in terms of slots)

select bookings.memid,sum(bookings.slots) from cd.bookings
group by bookings.memid
order by sum(bookings.slots) desc
limit 3;

--4.0 Display facilities booked sorted by slots descending

select facilities.facid,facilities.name,sum(bookings.slots)
from cd.bookings
join cd.facilities
on facilities.facid = bookings.facid
group by facilities.facid
order by sum(bookings.slots) desc;

--5.0 Display top 3 booked facilities with maximum earnings.

select facilities.facid,facilities.name,sum(slots)*membercost as memberearnings
from cd.facilities
join cd.bookings
on bookings.facid = facilities.facid
where bookings.memid<>0
group by facilities.facid
order by memberearnings desc
limit 3

select facilities.facid,facilities.name,sum(slots)*guestcost as guestearnings
from cd.facilities
join cd.bookings
on bookings.facid=facilities.facid
where bookings.memid = 0
group by facilities.facid
order by guestearnings desc
limit 3;


--6.0 Display top 3 referred members based on booking total slots.

select members.memid,members.firstname,members.surname,sum(bookings.slots) as slotsbooked
from cd.bookings
join cd.members
on bookings.memid = members.memid
where members.recommendedby >0
group by members.memid
order by sum(bookings.slots) desc
limit 3;


--7.0 Display members based on count of usage ot Tennis (could be tennis or table tennis).

select members.memid,members.firstname,members.surname,sum(bookings.slots) as tennisslotsbooked
from cd.bookings
join cd.members
on members.memid = bookings.bookid
join cd.facilities
on facilities.facid = bookings.facid
where facilities.name like '%Tennis%'
group by members.memid
order by sum(bookings.slots) desc;