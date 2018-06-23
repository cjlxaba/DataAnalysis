--select *
  --update m set Mun_type_id=500
update m set m.Prov_Id=p.Prov_Id
--select *
--update m set Mun_type_id=500
from (values
('Buffalo City, Eastern Cape'),
('City of Cape Town, Western Cape'),
('City of Johannesburg, Gauteng'),
('City of Tshwane, Gauteng'),
('Ekurhuleni, Gauteng'),
('Mangaung, Free State'),
('Nelson Mandela Bay, Eastern Cape'),
('eThekwini, KwaZulu-Natal')
)l(s)
inner join [Municipality] m on l.s like m.Mun_Name+'%' --like s
inner join --select * from
Province p on replace(l.s,'-',' ') like '%'+p.Prov_name


select *
from Municipality
where Mun_Type_Id=500