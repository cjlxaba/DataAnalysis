
/*
declare @xls_data_soure varchar(1024)=
	'D:\WITS\2018\ELEN7046\GroupProject\Dropbox\ProjectFiles\MunicipalDataset\incexp_aggregate_2009_2017.XLSX'
declare @XLS_Sheet varchar(40)='data'

	declare @sql varchar(3000)='
	SELECT *
	into ##data_dump
	FROM 
	OPENROWSET(
		 ''Microsoft.ACE.OLEDB.12.0'' 
		,''Excel 8.0;Database='+@xls_data_soure+';'' 
		,''SELECT * FROM ['+@XLS_Sheet+'$]''
	)
	'
	PRINT @SQL

	EXEC(@SQL)
	*/

	select *
	from  ##data_dump

	--populate reporting Period
	--INSERT INTO Reporting_Period(Rep_Year)
	SELECT DISTINCT [financial_period#period]
	from  ##data_dump
	ORDER BY [financial_period#period] ASC

	SELECT * FROM Reporting_Period

	--populate Province
	--INSERT INTO Province([Prov_Name],[Prov_Code])
	SELECT Prov_Name,Prov_Code
	FROM  (
	VALUES
	 ('Gauteng','GP'),('Eastern Cape','EC'),('KwaZulu Natal','KZN')
	,('Limpopo','LP'),('Northern Cape','NC'),('Western Cape','WC')
	,('Mpumalanga','MP'),('North West','NW'),('Free State','FS')
	)l(Prov_Name,Prov_Code)
	ORDER BY Prov_Name ASC

	SELECT * FROM Province

	--populate Municipality_Type
	--INSERT INTO Municipality_Type(Mun_Type_Cat,Mun_Type_Desc)
	SELECT Mun_Type_Cat,Mun_Type_Desc
	FROM  (
	VALUES
	  ('A','Metro'),('B','Local')
	 ,('D','Municipality'),('C','District')
	)l(Mun_Type_Cat,Mun_Type_Desc)
	ORDER BY Mun_Type_Cat

	SELECT * FROM Municipality_Type

		--populate Municipality
	--INSERT INTO Municipality(Mun_Name,Mun_Dem_Code,Prov_Id,Mun_Type_Id)

	SELECT DISTINCT [demarcation#label] AS Mun_Name,[demarcation#code] AS Mun_Dem_Code
	,(select top 1 Prov_ID from Province where Prov_code='GP') AS Prov_Id
	,(select top 1 Mun_Type_ID from Municipality_Type where Mun_Type_Desc='Municipality') AS Mun_Type_Id
	--select max(len([demarcation#code]))
	from  ##data_dump
	order by  [demarcation#code],[demarcation#label]

	SELECT * FROM Municipality


	--populate Municipality_Type
	--DELETE FROM Category_Type
	--INSERT INTO Category_Type(Cat_Type_Desc)
	SELECT Cat_Type_Desc
	FROM  (
	--VALUES
	--('Operating Revenue Generated'),
	--('Operating Expenditure'),
	--('Operating Surplus'),
	--('OTHER ADJUSTMENTS AND TRANSFERS')
	select distinct replace([item#label],' – ',' - ') AS Cat_Type_Desc--  --INTERNAL TRANSFERS - (must net out with corresp. items under
	from  ##data_dump
	where [item#return_form_structure]='heading'

	)l(Cat_Type_Desc)
	ORDER BY Cat_Type_Desc

	SELECT * FROM  Category_Type


	--INSERT INTO Category([Cat_Desc],[Cat_Type_Id],Cat_code)
	SELECT DISTINCT [item#label] AS [Cat_Desc]
	,(select top 1 [Cat_Type_Id] from [dbo].[Category_Type] where [Cat_Type_Desc]='OTHER ADJUSTMENTS AND TRANSFERS') AS [Cat_Type_Id]
	,[item#code] AS Cat_code
	--select top 90 *
	from  ##data_dump
	where [item#return_form_structure]='line_item'
	order by  [item#code],[item#label]

	SELECT * FROM  Category


	INSERT INTO [Transcation](Rep_Per_Id,Cat_Id,Mun_Id,Amount)
	select /**
	,*/p.Rep_Per_Id
	,c.Cat_Id
	,m.Mun_Id
	,r.[amount#sum]
	--select top 90 *
	from  ##data_dump AS r
	inner join [dbo].[Reporting_Period] AS p ON p.Rep_Year=r.[financial_period#period]
	inner join Category AS c ON c.Cat_Code=r.[item#code]
	inner join Municipality AS m On m.Mun_Dem_Code=r.[demarcation#code] --and [de
	where r.[item#return_form_structure]='line_item'
	and [amount#sum] is not null


	SELECT * FROM [Transcation]
