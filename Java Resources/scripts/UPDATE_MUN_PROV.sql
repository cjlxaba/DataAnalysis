--/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT TOP 1000 [Mun_Id]
--      ,[Mun_Name]
--      ,[Mun_Dem_Code]
--      ,[Prov_Id]
--      ,[Mun_Type_Id]

--	  update n set [Mun_Type_Id]=500
--	  select *
--  FROM [RSAMUNIE_DB].[dbo].[Municipality] n
--  where mun_id in (
--  218,

 
update m set m.Prov_Id=p.Prov_Id
  from (values
  ('Buffalo City, Eastern Cape')
 ,('City of Cape Town, Western Cape')
 ,('City of Johannesburg, Gauteng')
 ,('City of Tshwane, Gauteng')
 ,('Ekurhuleni, Gauteng')
 ,('Mangaung, Free State')
 ,('Nelson Mandela Bay, Eastern Cape')
 ,('eThekwini, KwaZulu-Natal')
 )l(s)
inner join [Municipality] m on l.s like m.Mun_Name+'%' --like s
inner join --select * from
Province p on replace(l.s,'-',' ') like '%'+p.Prov_name