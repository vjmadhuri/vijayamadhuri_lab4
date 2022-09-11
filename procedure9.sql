CREATE DEFINER=`root`@`localhost` PROCEDURE `procedure9`()
BEGIN
select report.supp_id,report.supp_name,report.average,
 CASE
 when report.average=5 then 'Excelent Service'
 when report.average>4 then 'Good Servce'
 when report.average>2 then 'Average Service'
 else
 'Poor service'
 end as type_of_service from 
 (select final.supp_id,supplier.supp_name,final.average from 
 (select test2.supp_id,sum(test2.rat_ratstars)/count(test2.rat_ratstars) as Average from
 (select supplier_pricing.supp_id,test.ord_id,test.rat_ratstars from supplier_pricing
 inner join
 (select `order`.pricing_id,rating.ord_id,rating.rat_ratstars from `order`
 inner join
 rating on rating.ord_id=`order`.ord_id) as test
 on test.pricing_id=supplier_pricing.pricing_id) as test2 group by
 supplier_pricing.supp_id) as final 
 inner join
 supplier where final.supp_id=supplier.SUPP_ID ) as report;
END