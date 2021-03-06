
  --update m set Mun_type_id=502
  update m set m.Prov_Id=p.Prov_Id
  --select *
from (
values('Alfred Nzo, Eastern Cape')
,('Amajuba, KwaZulu-Natal')
,('Amathole, Eastern Cape')
,('Bojanala, North West')
,('Cacadu, Eastern Cape')
,('Cape Winelands, Western Cape')
,('Capricorn, Limpopo')
,('Central Karoo, Western Cape')
,('Chris Hani, Eastern Cape')
,('Dr Kenneth Kaunda, North West')
,('Dr Ruth Segomotsi Mompati, North West')
,('Eden, Western Cape')
,('Ehlanzeni, Mpumalanga')
,('Fezile Dabi, Free State')
,('Frances Baard, Northern Cape')
,('Gert Sibande, Mpumalanga')
,('Harry Gwala, KwaZulu-Natal')
,('Joe Gqabi, Eastern Cape')
,('John Taolo Gaetsewe, Northern Cape')
,('Lejweleputswa, Free State')
,('Mopani, Limpopo')
,('Namakwa, Northern Cape')
,('Ngaka Modiri Molema, North West')
,('Nkangala, Mpumalanga')
,('O.R.Tambo, Eastern Cape')
,('Overberg, Western Cape')
,('Pixley ka Seme, Northern Cape')
,('Sedibeng, Gauteng')
,('Sekhukhune, Limpopo')
,('Thabo Mofutsanyane, Free State')
,('Ugu, KwaZulu-Natal')
,('Umgungundlovu, KwaZulu-Natal')
,('Umkhanyakude, KwaZulu-Natal')
,('Umzinyathi, KwaZulu-Natal')
,('Uthukela, KwaZulu-Natal')
,('Uthungulu, KwaZulu-Natal')
,('Vhembe, Limpopo')
,('Waterberg, Limpopo')
,('West Coast, Western Cape')
,('West Rand, Gauteng')
,('Xhariep, Free State')
,('Z F Mgcawu, Northern Cape')
,('Zululand, KwaZulu-Natal')
,('iLembe, KwaZulu-Natal')
)l(s)
inner join [Municipality] m on l.s like m.Mun_Name+'%' --like s
inner join --select * from
Province p on replace(l.s,'-',' ') like '%'+p.Prov_name