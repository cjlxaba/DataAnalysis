

select *
--update n set [Mun_Name]=replace(replace([Mun_Name],'/',''),'!','')
from [dbo].[Municipality] n
where ([Mun_Name] like '/%' or [Mun_Name] like '!%')