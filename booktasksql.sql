create database Bookshop

USE Bookshop

create table Authors(
Id int primary key identity,
Name nvarchar(25) not null,
Surname nvarchar(25)

)

create table Books(
Id int primary key identity,
Name nvarchar(100),
AuthorsId int foreign key references Authors(Id),
PageCount int check(PageCount>=10)
)

insert into Authors
values('Hasan','Nuruzade'),
('Lala','Guliyeva'),
('Nurlan','Mammadli')

insert into Books(Name,PageCount,AuthorsId)
values('Hasanin gunlugu',140,1),
('Hasanin turkiye maceralari',500,1),
('So cute',80,2),
('Aztv',230,2),
('Story of coder girl',300,2),
('One day in mkr',440,3),
('Being best dev in the world',310,3)


create view vw_BookDetails
as
select b.Id,b.Name,b.PageCount,(a.Name + ' ' + a.Surname) as 'AuthorFullName' from Books b
join Authors a
on b.AuthorsId=a.Id

select * from vw_BookDetails


create procedure ups_search
@Name nvarchar(100)
as
select * from vw_BookDetails
where Name like '%' + @Name + '%' or AuthorFullName like '%' + @Name + '%'

exec ups_search 'guliyeva'


create procedure ups_insert
@Name nvarchar(100),
@AuthorsId int,
@PageCount int
as
insert into Books
values(@Name,@AuthorsId,@PageCount)


create procedure ups_update
@Id int,
@Name nvarchar(100),
@AuthorsId int,
@PageCount int
as
update Books
set Name=@Name,PageCount=@PageCount,AuthorsId=@AuthorsId
where Id = @Id

create procedure ups_delete
@Id int
as
DELETE FROM Books
where Id = @Id

exec ups_insert 'Psix',3,1000

exec ups_update 7,'test update',2,311
 exec ups_delete 8


 create view vw_authorDetails
 as
 select a.Id,(a.Name + '' + a.Surname) as 'Fullname',count(b.Id) as 'Bookcount',max(b.PageCount) as 'MaxPageCount' from Books b
 join Authors a
on a.Id = b.AuthorsId
group by a.Id,a.Name,a.Surname

select * from vw_authorDetails
 