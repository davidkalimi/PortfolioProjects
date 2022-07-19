--create database CustomrSales

--create schema sales 
--create schema person
--create schema purchasing

--create table SalesOrderDetail(
--SalesOrderID int constraint soiPK not null,
--SalesOrderDetailID int constraint sodPK  not null,
--CarrierTrackingNumber nvarchar(25),
--OrderQty smallint not null,
--ProductID int not null,
--SpecialOfferID int not null,
--UnitPrice money not null,
--UnitPriceDiscount money not null,
--LineTotal as ((isnull(([UnitPrice]*((1.0)-[UnitPriceDiscount]))*[OrderQty],(0.0)))),
--rowguid uniqueidentifier not null,
--ModifiedDate datetime
--primary key(SalesOrderID, SalesOrderDetailID)
--)

 
--create table sales.SalesOrderHeader( 
--SalesOrderID int constraint soiPK  not null,
--RevisionNumber tinyint not null,
--OrderDate datetime not null,
--DueDate datetime not null,
--ShipDate datetime,
--Status tinyint not null,
--OnlineOrderFlag bit not null,
--SalesOrderNumber as (isnull(N'SO'+CONVERT([nvarchar](23),[SalesOrderID]),N'*** ERROR ***')),
--PurchaseOrderNumber nvarchar(25),
--AccountNumber nvarchar (25),
--CustomerID int not null,
--SalesPersonID int,
--Territory int,
--BillToAdressID int not null,
--ShipToAdressID int not null,
--ShipMethodID int not null,
--CreditCardID int,
--CreditCardApproveCode varchar(15),
--CurrencyRateID int, 
--SubTotal money not null,
--TaxAmt money not null,
--Freight money not null
--primary key (SalesOrderID)
--)

--create table person.Address(
--AddressID int constraint aPK not null,
--AddressLine1 nvarchar (60) not null,
--AddreesLine2 nvarchar (60),
--City nvarchar (60) not null,
--StateProvinceID int not null,
--PostalCode nvarchar(15) not null,
--SpatialLocation geography,
--rowguid uniqueidentifier not null,
--ModifiedDate datetime not null
--primary key (AddressID)
--)

--create table purchasing.ShipMethod
--(
--ShipMethodID int constraint smPK not null,
--Name nvarchar (50) not null,
--ShupBase money not null,
--SHipRate money not null,
--rowguid uniqueidentifier not null,
--ModifiedDate datetime not null
--primary key (ShipMethodID)
--)

--create table sales.CurrencyRate (
--CurrencyRateID int constraint crPK not null,
--CurrencyRateDate datetime not null,
--FromCurrencyCode nchar(3) not null,
--ToCurrencyCode nchar(3) not null,
--AvarageRate money not null,
--EndOfDayRate money not null,
--ModifiedDate datetime not null
--primary key (CurrencyRateID)
--)

--create table sales.SpecialOfferProduct(
--SpecialOfferID int constraint soPK not null,
--ProductID int constraint pPK not null,
--rowguid uniqueidentifier not null,
--ModifiedDate datetime not null
--primary key (SpecialOfferID, ProductID) 
-- )

--create table sales.CreditCard(
--CreditCardID int constraint ccPK not null,
--CardType nvarchar (50) not null,
--CardNumber nvarchar (25) not null,
--ExpMonth tinyint not null,
--ExpYear smallint not null,
--ModifiedDate datetime not null
--primary key (CreditCardID)
--)

--create table sales.SalesPerson(
--BusinessEntityID int constraint bePK not null,
--TerittoryID int,
--SalesQuota money,
--Bonus money not null,
--CommissionPct smallmoney not null,
--SalesYTD money not null,
--SalesLastYear money not null,
--rowguid uniqueidentifier not null,
--ModifiedDate datetime not null
--primary key (BusinessEntityID)
--)

--create table sales.SalesTerritory(
--TerritoryID int constraint tPK not null,
--Name nvarchar(50) not null,
--CountryRegionCode nvarchar(3) not null,
--[Group] nvarchar(50) not null,
--SalesYTD money not null,
--SalesLastYear money not null,
--CostYTD money not null,
--CostLastYear money not null,
--rowguid uniqueidentifier not null,
--ModifiedDate datetime not null
--primary key (TerritoryID)
--)

--create table sales.Customer(
--CustomerID int constraint cID not null,
--PersonID int,
--StoreID int,
--TerritoryID int,
--AccountNumber nvarchar(50),
--rowguid uniqueidentifier not null,
--ModifiedDate datetime not null
--primary key (CustomerID)
--)

--alter table sales.SalesOrderHeader add constraint crPK  
--foreign key (CurrencyRateID) references sales.CurrencyRate(CurrencyRateID)

--alter table sales.SalesOrderHeader add constraint crPK  
--foreign key (ShipMethodID) references purchasing.ShipMethod(ShipMethodID)

--alter table sales.SalesOrderHeader add constraint cID  
--foreign key (CustomerID) references sales.Customer(CustomerID)

--alter table sales.SalesOrderHeader add constraint tPK  
--foreign key (Territory) references sales.SalesTerritory(TerritoryID)

--alter table sales.SalesOrderHeader add constraint ccPK  
--foreign key (CreditCardID) references sales.CreditCard(CreditCardID)

--alter table sales.SalesOrderHeader add constraint smPK  
--foreign key (ShipMethodID) references purchasing.ShipMethod(ShipMethodID)

--alter table sales.SalesOrderHeader add constraint aPK  
--foreign key (ShipToAdressID) references person.Address(AddressID)
--alter table sales.SalesPerson add constraint spPK
--foreign key (TerittoryID) references sales.SalesTerritory(TerritoryID)

// הוספת יוניק
--alter table sales.SalesPerson add constraint unique_territoryid unique (TerittoryID)

--alter table sales.SalesOrderHeader add constraint sohPK  
--foreign key (Territory) references sales.SalesPerson(TerittoryID)


--alter table sales.Customer add foreign key (TerritoryID) references sales.SalesTrritory (TerritoryID)

--alter table dbo.SalesOrderDetail add constraint soPK  
--foreign key (SpecialOfferID, ProductID) references sales.SpecialOfferProduct(SpecialOfferID, ProductID)

--SpecialOfferID int constraint soPK not null,
--ProductID int constraint pPK not null,


--insert into dbo.SalesOrderDetail (SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, rowguid, ModifiedDate)  
--select SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, rowguid, ModifiedDate
--from AdventureWorks2016.Sales.SalesOrderDetail

--insert into sales.SalesTerritory (TerritoryID ,[Name] ,CountryRegionCode,[Group], salesytd, SalesLastYear, CostYTD, CostLastYear, rowguid, ModifiedDate)
--select TerritoryID, [name],CountryRegionCode,[group], salesytd, SalesLastYear, CostYTD, CostLastYear, rowguid, ModifiedDate
--from AdventureWorks2016.Sales.SalesTerritory

insert into sales.SalesPerson (BusinessEntityID,SalesQuota,Bonus,CommissionPct, SalesYTD,SalesLastYear,rowguid,ModifiedDate)
select BusinessEntityID,SalesQuota,Bonus,CommissionPct, SalesYTD,SalesLastYear,rowguid,ModifiedDate
from AdventureWorks2016.sales.SalesPerson

--insert into sales.Customer
--select CustomerID, PersonID, StoreID, TerritoryID, AccountNumber, rowguid, ModifiedDate
--from AdventureWorks2016.Sales.Customer

--insert into sales.CurrencyRate
--select CurrencyRateID, CurrencyRateDate, FromCurrencyCode, ToCurrencyCode, AverageRate,EndOfDayRate, ModifiedDate
--from AdventureWorks2016.Sales.CurrencyRate

--insert into sales.CreditCard
--select CreditCardID, CardType, CardNumber,ExpMonth,ExpYear,ModifiedDate
--from AdventureWorks2016.Sales.CreditCard

--insert into purchasing.ShipMethod
--select ShipMethodID,[Name], ShipBase,ShipRate,rowguid,ModifiedDate
--from AdventureWorks2016.Purchasing.ShipMethod

--insert into person.Address
--select AddressID, AddressLine1, AddressLine2, City, StateProvinceID, PostalCode, SpatialLocation, rowguid, ModifiedDate
--from AdventureWorks2016.Person.Address

--insert into sales.SalesOrderHeader (SalesOrderID, RevisionNumber, OrderDate, DueDate, ShipDate, Status, OnlineOrderFlag, PurchaseOrderNumber, AccountNumber, CustomerID, SalesPersonID, BillToAdressID, ShipToAdressID, ShipMethodID, CreditCardID,CreditCardApproveCode, CurrencyRateID, SubTotal, TaxAmt, Freight)
--select SalesOrderID, RevisionNumber, OrderDate, DueDate, ShipDate, Status, OnlineOrderFlag, PurchaseOrderNumber, AccountNumber, CustomerID, SalesPersonID, BillToAddressID, ShipToAddressID, ShipMethodID, CreditCardID,CreditCardApprovalCode, CurrencyRateID, SubTotal, TaxAmt, Freight
--from AdventureWorks2016.sales.SalesOrderHeader


