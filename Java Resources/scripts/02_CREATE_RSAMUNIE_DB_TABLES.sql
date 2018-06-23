USE [RSAMUNIE_DB]
GO


CREATE TABLE Municipality_Type (
	 Mun_Type_Id int identity(500,1) not null primary key
	,Mun_Type_Cat varchar(1) not null unique
	,Mun_Type_Desc varchar(255) not null 
)
GO

CREATE TABLE Reporting_Period (
	 Rep_Per_Id int identity(100,1) not null primary key
	,Rep_Year int not null unique
)
GO

CREATE TABLE Category_Type (
	 Cat_Type_Id int identity(100,1) not null primary key
	,Cat_Type_Desc varchar(255) not null --unique
)
GO

 CREATE TABLE Category (
	  Cat_Id int identity(100,1) not null primary key
	 ,Cat_Type_Id int not null foreign key references Category_Type(Cat_Type_Id)
	 ,Cat_Code varchar(4) not null unique
	 ,Cat_Desc varchar(255) not null --unique
)
GO

 CREATE TABLE Province (
	  Prov_Id int identity(100,1) not null primary key
	 ,Prov_Name varchar(255) not null
	 ,Prov_Code varchar(5) not null unique
)
GO

CREATE TABLE Municipality (
	  Mun_Id int identity(100,1) not null primary key
	 ,Mun_Name varchar(255) not null
	 ,Mun_Dem_Code varchar(5) not null unique
	 ,Prov_Id int not null foreign key references Province(Prov_Id)
	 ,Mun_Type_Id int not null foreign key references Municipality_Type(Mun_Type_Id)
)
GO


CREATE TABLE Transcation(
	Tran_Id int identity(100,1) not null primary key
	,Mun_Id int not null foreign key references Municipality(Mun_Id)
	,Rep_Per_Id int not null foreign key references Reporting_Period(Rep_Per_Id)
	,Cat_Id int not null foreign key references Category(Cat_Id)
	,Amount money not null default(0)
	,UNIQUE NONCLUSTERED 
	(
		Mun_Id ASC, Rep_Per_Id ASC, Cat_Id ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

)

GO
ALTER TABLE Municipality ALTER COLUMN Mun_Dem_Code VARCHAR(10) not null 
GO