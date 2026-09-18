# Chinook Database Project

This sample project contains the Chinook sample database, a cpmmon relational database designed to model a digital music store. It is commonly used for SQL learning, data analysis, and practicing business intelligence queries.


## Overview

The Chinook database represents a fictional music retailer that sells tracks, albums, and media files. It includes customers, employees, invoices, and playlist data, making it suitable for exploring sales, customer behavior, artist performance, and revenue trends.

The data model is structured around the core entities of a music business:

- Artists and albums
- Tracks and media types
- Genres and playlists
- Customers and support staff
- Invoices and invoice lines


## Included Files

- `Chinook_MySql.sql` — MySQL schema and sample data
- `Chinook_Database.sql` — dataset exploration and SQL analysis examples
- `Chinook_Database.twb` — Tableau workbook for visual analysis
- `Chinook_ERD.pdf` — entity relationship diagram
- `Tables/` — CSV exports for the database tables


## Main Tables

| Table | Description |
| --- | --- |
| `Artist` | Stores artist names and metadata |
| `Album` | Stores album titles associated with artists |
| `Track` | Stores individual songs, pricing, duration, and media information |
| `Genre` | Defines music categories such as Rock, Jazz, Metal, Pop, and more |
| `MediaType` | Describes the file format used for the track |
| `Customer` | Stores customer information and support representative assignments |
| `Employee` | Represents staff members, including support reps and managers |
| `Invoice` | Records a customer purchase with billing details and total amount |
| `InvoiceLine` | Lists the individual tracks included in each invoice |
| `Playlist` | Stores user-created or curated playlists |
| `PlaylistTrack` | Links playlists to the tracks they contain |


## Relationship Highlights

The database follows a typical music-store schema:

- An `Artist` has many `Album` records
- An `Album` contains many `Track` records
- A `Track` belongs to a `Genre` and a `MediaType`
- A `Customer` can place many `Invoice` records
- Each `Invoice` contains multiple `InvoiceLine` entries
- A `Playlist` can contain many `Track` records through `PlaylistTrack`
- `Customer` records may be assigned to a support employee in `Employee`


## Business Questions This Database Can Answer

This dataset is useful for answering questions such as:

- Which artists or albums generate the most revenue?
- Which customers spend the most money?
- Which genres are the most popular by quantity or sales value?
- Which tracks are sold most frequently?
- Which countries produce the highest invoice totals?
- Which employees support the most customers?


## Example SQL Use Cases

The SQL scripts included in this project demonstrate:

- Top-selling tracks and albums
- Revenue by genre and artist
- Customer spending analysis
- Country-based revenue summaries
- Playlist performance analysis
- Employee support-performance analysis


## License and Source

The Chinook database is based on the open-source Chinook sample database created by Luis Rocha and is widely used in SQL and analytics training.
