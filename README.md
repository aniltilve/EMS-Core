# EMS-Core

An ambulance agency data capture and reporting tool implemented as a web application via ASP.NET Core 2.0.

## Solution Structure Description

### EMS.Business

Constructs SQL queries from entities and passes them to the Data Acess tier.

### EMS.DbSchema

Import of the SQL Server database used by this application. Contains tables and stored procedures.

### EMS.DataAccess

Contains a generic data repository that interfaces with the SQL Server database.

### EMS.Entity

Contains entity defintions of SQL tables for object-relational mapping.

### EMS.WebAPI

Middleman between the Web Portal and Business tier.

### EMS.WebPortal

Angular front-end which serves as an entry point to the application. 

### Test

For testing SQL queries. Not a part of the application.
