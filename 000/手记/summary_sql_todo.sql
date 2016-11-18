SELECT  
    count(t.EAI_Product_ID) count,SUM(t.LineAmt) Amt,SUM(t.Qty) Qty 
    ,b.EAI_BPartner_ID,b.Name,b.BPartnerCode,b.Address
    ,o.DocStatus,getreflisttrl(131,o.DocStatus) DocStatusName
    ,g.Name OrgName,g.Ad_Org_Id
    FROM EAI_TaxInvoiceLine t  
        inner join EAI_TaxInvoice o on (o.EAI_TaxInvoice_ID=t.EAI_TaxInvoice_ID) 
        inner join EAI_Bpartner b on (o.EAI_BPartner_ID=b.EAI_BPartner_ID) 
        inner join eai_product_v p on (t.EAI_Product_ID=p.EAI_Product_ID) 
        inner join EAI_ORDERLINE OL on (ol.EAI_ORDERLINE_ID=T.EAI_ORDERLINE_ID)  
        inner join EAI_ORDER OD on (OL.EAI_ORDER_ID=OD.EAI_ORDER_ID)  
        inner join AD_ORG g on (g.AD_ORG_ID=o.AD_ORG_ID) 
    where 1=1 AND o.IsActive='Y' AND o.DocStatus !='VO' AND  b.Ad_OrgBp_ID = 1000188  
--        AND DateInvoiced>=? AND DateInvoiced<=? 
    GROUP BY b.EAI_BPartner_ID,b.Name,b.BPartnerCode,b.Address,o.DocStatus
                ,g.Name,g.Ad_Org_Id
    ORDER BY amt  desc;
    
select * from ad_org;