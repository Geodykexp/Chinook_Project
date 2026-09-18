-- Analyzing the database 
select * from album;
select * from artist;
select * from customer;
select * from employee;
select * from genre;
select * from invoice;
select * from invoiceline;
select * from mediatype;
select * from playlist;
select * from playlisttrack;
select * from track;

-- Analysis
select * from artist;
select * from album;

select
* 
from
artist a
join
album b on a.ArtistId  = b.ArtistId;

select * from customer;
select * from track;
select * from invoiceline;

# Top 10 selling tracks
SELECT
	t.Name AS Track,
    SUM(il.Quantity) AS CopiesSold
FROM Invoiceline il
JOIN track t
ON il.TrackId = t.TrackId
GROUP BY t.TrackId, t.Name
ORDER BY CopiesSold DESC
LIMIT 10;

# Pairing artist to album
SELECT
ar.Name AS Artist,
al.Title AS Album
FROM Album al
JOIN Artist ar
ON ar.ArtistId = al.ArtistId
GROUP BY al.Title, ar.Name
ORDER BY al.Title;


-- Find out the media type used the most
select
m.Name AS Track_name,
COUNT(*) AS media_type_count
FROM
track t
JOIN
mediatype m
ON
m.MediaTypeId = t.MediaTypeId
GROUP BY m.Name
ORDER BY media_type_count DESC
LIMIT 20;

-- Customers who have spent the most
select
c.FirstName,
c.LastName,
SUM(i.Total) AS Total_amount_spent
from
customer c
join
invoice i
on
i.CustomerId = c.CustomerId
group by c.CustomerId, c.FirstName, c.LastName
order by Total_amount_spent DESC;

SELECT * FROM invoice; 
SELECT * FROM invoiceline;

-- Total Revenue
SELECT SUM(Total) as Total_Revenue
FROM invoice;

-- Best month
SELECT DATE_FORMAT(invoiceDate, '%Y-%m') AS month, 
	SUM(Total) AS Revenue
FROM invoice
group by month
order by Revenue DESC;

-- Top 10 customers by amount_spent
select 
c.CustomerId,
c.FirstName,
c.LastName,
SUM(i.total) AS total_spent
from customer c
join invoice i
on i.CustomerId = c.CustomerId
group by CustomerId
order by total_spent DESC
LIMIT 10;


-- Top countries by revenue
select 
c.Country,
SUM(i.total) as Total_Revenue
from
customer c
Join
invoice i on c.CustomerId = i.CustomerId
group by c.Country
order by Total_Revenue desc
limit 10;


-- Top Artist's performance (Multi-table join)
select ar.Name as artist,
	SUM(il.UnitPrice * il.Quantity) as revenue
from invoiceLine il
join track t on il.TrackId = t.TrackId
join album al on t.AlbumId = al.AlbumId
join artist ar on  al.ArtistId = ar.ArtistId
group by ar.ArtistId
order by revenue DESC;


-- Top  Genre Performance (Multi-table join)
select g.Name as genre,
	sum(il.UnitPrice * il.Quantity) as revenue
from invoiceline il
join track t on t.TrackId = il.TrackId
join genre g on g.GenreId = t.GenreId
group by genre
order by revenue desc;

select * from album;

-- Top Album sales
select
a.Title as Album_title,
sum(il.Quantity * il.UnitPrice) as Revenue
from
album a
join track t on a.AlbumId = t.AlbumId
join invoiceline il on t.TrackId = il.TrackId
group by Album_title
order by Revenue desc
limit 10;


-- Top Track performance
select 
t.name as track_name,
sum(il.UnitPrice * il.Quantity) as revenue
from 
invoiceline il
join track t on t.TrackId = il.TrackId
group by track_name
order by revenue desc
limit 10;


select * from playlist;
select * from playlisttrack;

-- most trending playlist
select
p.Name AS Playlist,
sum(il.UnitPrice * il.Quantity) as Revenue
from
playlist p
join playlisttrack pl on p.PlaylistId = pl.PlaylistId
join track t on pl.TrackId = t.TrackId
join invoiceline iL on t.TrackId = il.TrackId
group by Playlist
order by Revenue desc
limit 10;

-- Employee's performance

-- Service Surpport with highest spending customers
select
e.EmployeeId as Support_staff,
e.FirstName,
e.LastName,
SUM(i.Total) as total_revenues_from_customers
from
employee e
join customer c on c.SupportRepId = e.EmployeeId
join invoice i on c.CustomerId = i.CustomerId
group by Support_staff
order by total_revenues_from_customers desc
limit 10;

select * from employee;

-- Number of customers that employee manage
select
e.EmployeeId as Support_staff,
e.FirstName,
e.LastName,
count(c.CustomerId) AS customers_managed
from employee e
left join customer c on c.SupportRepId = e.EmployeeId
group by Support_staff
order by customers_managed desc
limit 10;

-- Pricing Analysis (avg track price)
select avg(UnitPrice) as avg_track_price
from track;

-- Purchase rate of tracks due to price
select
t.TrackId,
t.Name,
t.UnitPrice as price_per_unit,
-- sum(il.UnitPrice * il.Quantity) as sales
count(il.UnitPrice) as times_purchased
from
track t
join invoiceline il on t.TrackId = il.TrackId
group by t.TrackId
order by times_purchased desc;

-- price is not a factor here as all the prices are same

-- Top selling tracks by quantity sold
select
t.TrackId,
g.Name as genre,
SUM(il.Quantity) AS total_quantity_sold
from 
track t 
join invoiceline il on t.TrackId = il.TrackId
join genre g on t.GenreId = g.GenreId
group by il.TrackId
order by total_quantity_sold desc;

-- Top selling tracks by revenue
select
t.TrackId,
g.Name as Genre,
t.Name,
t.UnitPrice as price_per_unit,
SUM(il.Quantity) AS total_quantity_sold,
sum(il.UnitPrice * il.Quantity) as sales
-- count(il.UnitPrice) as times_purchased
from
track t
join invoiceline il on t.TrackId = il.TrackId
join genre g on g.GenreId = t.GenreId
group by il.TrackId
order by sales desc;


-- Purchase behaviour
select 
i.CustomerId,
-- count(il.Quantity * il.UnitPrice) as sales,
-- avg(il.Quantity * il.UnitPrice) as sales_average
count(il.Quantity) as total_bought,
avg(il.Quantity) as average_bought
from 
invoiceline il
join invoice i on i.InvoiceId = il.InvoiceId
group by i.CustomerId
order by average_bought desc;
 
 -- OR Alternatively
 
 -- Purchase Behaviour 2
SELECT 
    i.CustomerId,
    SUM(il.Quantity) AS total_tracks_bought,
    AVG(il.Quantity) AS avg_quantity_per_invoice_line
FROM invoiceline il
JOIN invoice i ON i.InvoiceId = il.InvoiceId
GROUP BY i.CustomerId
ORDER BY total_tracks_bought DESC;


-- Tracks the average 
select
avg(customer_total) as avg_tracks_per_customer
from(
select
i.CustomerId,
sum(il.Quantity) as customer_total
from invoiceline il
join invoice i on i.InvoiceId = il.InvoiceId
group by i.CustomerId
) as t;

-- Product Catalogue Analysis
select
a.Name as Artist,
a.ArtistId,
-- al.Title,
count(t.TrackId) as No_of_tracks_per_Artist
from artist a
join album al on a.ArtistId = al.ArtistId
join track t on al.AlbumId = t.AlbumId
group by a.ArtistId, a.Name
order by No_of_tracks_per_Artist desc
limit 10;



select * from track;
select * from album;
select * from artist;


-- Employee that generates most from Rock tracks
select
e.EmployeeId,
e.FirstName,
e.LastName,
SUM(il.UnitPrice * il.Quantity) as Revenue
from
employee e
join customer c on e.EmployeeId = c.SupportRepId
join invoice i on c.CustomerId = i.CustomerId
join invoiceline il on i.InvoiceId = il.InvoiceId
join track t on il.TrackId = t.TrackId
join genre g on t.GenreId = g.GenreId
where g.Name = "Rock"
group by  e.EmployeeId
order by Revenue desc;

select * from genre;

-- Customer spending ranked within each country
WITH customer_spending as (
	select
		c.CustomerId,
		c.FirstName,
		c.LastName,
		c.Country,
		SUM(I.Total) as total_spent
	from customer c
	join invoice i on c.CustomerId = i.CustomerId
	group by c.CustomerId
)
select
	*,
	rank() over (partition by Country order by total_spent desc) as country_rank
from customer_spending
order by country_rank desc;    -- Country, country_rank


-- Artist with highest average revenue per track sold
with track_revenue as
(
select
t.TrackId,
al.ArtistId,
SUM(il.UnitPrice * il.Quantity) as Revenue
from
track t
join album al on t.AlbumId = al.AlbumId
join invoiceline il on t.TrackId = il.TrackId
group by t.TrackId
)
select 
ar.Name as Artist,
AVG(revenue) as avg_revenue_per_track
from 
track_revenue tr
join artist ar on tr.ArtistId = ar.ArtistId
group by Artist
order by avg_revenue_per_track desc;


-- Genres that are most frequently purchased together
select
g1.Name as genre_1,
g2.Name as genre_2,
COUNT(*) AS times_bought_together
from invoiceline il1
join track t1 on il1.TrackId = t1.TrackId
join genre g1 on t1.GenreId = g1.GenreId

join invoiceLine il2
on il1.InvoiceId = il2.InvoiceId
and il1.InvoiceLineId <> il2.InvoiceLineId
join track t2 on il2.TrackId = t2.TrackId
join genre g2 on t2.GenreId = g2.GenreId

group by genre_1, genre_2
order by times_bought_together desc;


-- Genre with fastest year over year growth
with genre_year as (
select
g.Name as genre,
year(i.InvoiceDate) as year,
sum(il.UnitPrice * il.Quantity) AS revenue
from
invoice i
join invoiceline il on i.InvoiceId = il.InvoiceId
join track t on il.TrackId = t.TrackId
join genre g on t.GenreId = g.GenreId
group by g.Name, YEAR(i.InvoiceDate)
)
select
genre,
year,
revenue,
lag(revenue) over (partition by genre order by year) as prev_year_revenue,
revenue - lag(revenue) over (partition by genre order by year) as yoy_growth
from genre_year
order by yoy_growth desc;       -- OR genre, year






























    



 





