--summary
SELECT  
    count(t.EAI_Product_ID) count,SUM(t.LineAmt) Amt,SUM(t.Qty) Qty
    ,p.EAI_Product_ID,p.ProductName,p.MedicineName,p.ProductSpec,p.Manufacturer,p.ProductStyle,p.UOM,p.UOMNAME,p.ProductCode
    FROM EAI_TaxInvoiceLine t  
    inner join EAI_TaxInvoice o on (o.EAI_TaxInvoice_ID=t.EAI_TaxInvoice_ID) 
    inner join EAI_Bpartner b on (o.EAI_BPartner_ID=b.EAI_BPartner_ID) 
    inner join eai_product_v p on (t.EAI_Product_ID=p.EAI_Product_ID) 
    inner join EAI_ORDERLINE OL on (ol.EAI_ORDERLINE_ID=T.EAI_ORDERLINE_ID)  
    inner join EAI_ORDER OD on (OL.EAI_ORDER_ID=OD.EAI_ORDER_ID)  
    inner join AD_ORG g on (g.AD_ORG_ID=o.AD_ORG_ID) 
    WHERE o.Processed='Y' 
--    AND DateInvoiced>=? AND DateInvoiced<=? 
    AND b.EAI_BPartner_ID=1057127 
    GROUP BY p.EAI_Product_ID,p.ProductName,p.MedicineName,p.ProductSpec,p.Manufacturer,p.ProductStyle,p.UOM,p.ProductCode 
    ORDER BY amt  desc;

SELECT 
    COUNT(1),SUM(Amt) TotalAmt 
    FROM 
    (SELECT  
        count(t.EAI_Product_ID) count,p.EAI_Product_ID,p.ProductName,p.MedicineName,p.ProductSpec,p.Manufacturer,
        p.ProductStyle,p.UOM,p.UOMNAME,p.ProductCode,SUM(t.LineAmt) Amt,SUM(t.Qty) Qty 
        FROM EAI_TaxInvoiceLine t  
            inner join EAI_TaxInvoice o on (o.EAI_TaxInvoice_ID=t.EAI_TaxInvoice_ID) 
            inner join EAI_Bpartner b on (o.EAI_BPartner_ID=b.EAI_BPartner_ID) 
            inner join eai_product_v p on (t.EAI_Product_ID=p.EAI_Product_ID) 
            inner join EAI_ORDERLINE OL on (ol.EAI_ORDERLINE_ID=T.EAI_ORDERLINE_ID)  
            inner join EAI_ORDER OD on (OL.EAI_ORDER_ID=OD.EAI_ORDER_ID)  
            inner join AD_ORG g on (g.AD_ORG_ID=o.AD_ORG_ID) 
        WHERE o.Processed='Y' 
--        AND DateInvoiced>=? AND DateInvoiced<=? 
        AND b.EAI_BPartner_ID=1057127 
        GROUP BY p.EAI_Product_ID,p.ProductName,p.MedicineName,p.ProductSpec,p.Manufacturer,p.ProductStyle,p.UOM,p.ProductCode 
            ORDER BY amt  desc);
            
--summaryGroupByBPartner
SELECT  
        count(t.EAI_Product_ID) count,SUM(t.LineAmt) Amt,SUM(t.Qty) Qty 
        ,b.EAI_BPartner_ID,b.Name,b.BPartnerCode,b.Address
    FROM EAI_TaxInvoiceLine t  
        inner join EAI_TaxInvoice o on (o.EAI_TaxInvoice_ID=t.EAI_TaxInvoice_ID) 
        inner join EAI_Bpartner b on (o.EAI_BPartner_ID=b.EAI_BPartner_ID) 
        inner join eai_product_v p on (t.EAI_Product_ID=p.EAI_Product_ID) 
        inner join EAI_ORDERLINE OL on (ol.EAI_ORDERLINE_ID=T.EAI_ORDERLINE_ID)  
        inner join EAI_ORDER OD on (OL.EAI_ORDER_ID=OD.EAI_ORDER_ID)  
        inner join AD_ORG g on (g.AD_ORG_ID=o.AD_ORG_ID) 
    WHERE o.Processed='Y' 
--        AND DateInvoiced>=? AND DateInvoiced<=? 
    GROUP BY b.EAI_BPartner_ID,b.Name,b.BPartnerCode,b.Address  
    ORDER BY amt  desc;

SELECT COUNT(1),SUM(Amt) TotalAmt FROM (SELECT  count(t.EAI_Product_ID) count,b.EAI_BPartner_ID,b.Name,b.BPartnerCode,b.Address,SUM(t.LineAmt) Amt,SUM(t.Qty) Qty FROM EAI_TaxInvoiceLine t  inner join EAI_TaxInvoice o on (o.EAI_TaxInvoice_ID=t.EAI_TaxInvoice_ID) inner join EAI_Bpartner b on (o.EAI_BPartner_ID=b.EAI_BPartner_ID) inner join eai_product_v p on (t.EAI_Product_ID=p.EAI_Product_ID) inner join EAI_ORDERLINE OL on (ol.EAI_ORDERLINE_ID=T.EAI_ORDERLINE_ID)  inner join EAI_ORDER OD on (OL.EAI_ORDER_ID=OD.EAI_ORDER_ID)  inner join AD_ORG g on (g.AD_ORG_ID=o.AD_ORG_ID) WHERE o.Processed='Y' AND DateInvoiced>=? AND DateInvoiced<=? GROUP BY b.EAI_BPartner_ID,b.Name,b.BPartnerCode,b.Address  ORDER BY amt  desc);

--queryDetail
select TL.AD_ORG_ID, TL.EAI_TAXINVOICE_ID, TL.EAI_TAXINVOICELINE_ID, TL.lot, TL.GUARANTEEDATE,TL.DESCRIPTION, TL.EAI_ORDERLINE_ID, TL.Qty
        , TL.LineAmt, TL.Price
        , TI.EAI_BPARTNER_ID, TI.INVOICENO, TI.DateInvoiced, TI.DOCSTATUS
        , OL.EAI_ORDER_ID, OL.Line ,OL.EAI_ORDERLINE_ID, OL.SiteOrderLineID
        , BP.NAME BPartnerName
        , G.NAME OrgName
        , P.EAI_PRODUCT_ID, P.PRODUCTNAME, p.MedicineName, p.ProductSpec, p.Manufacturer, p.ProductStyleName, p.UOM, p.UOMName, p.ProductCode
        , O.DOCUMENTNO, O.IsRejectDoc, o.IsReturnDoc,o.IsSOTrx, O.SiteOrderID
    from EAI_TAXINVOICELINE TL 
        inner join EAI_TaxInvoice TI on (TI.EAI_TaxInvoice_ID=TL.EAI_TaxInvoice_ID) 
        inner join EAI_Bpartner BP on (TI.EAI_BPartner_ID=BP.EAI_BPartner_ID) 
        inner join AD_ORG G on (G.AD_ORG_ID=TI.AD_ORG_ID) 
        inner join EAI_ORDERLINE OL on (ol.EAI_ORDERLINE_ID=TL.EAI_ORDERLINE_ID) 
        inner join EAI_ORDER O on (ol.EAI_ORDER_ID=o.EAI_ORDER_ID) 
        inner join eai_product_v P on (TL.EAI_Product_ID=p.EAI_Product_ID) 
    where 1=1  
        AND TL.Processed='Y' 
--        AND TI.DateInvoiced>=? AND TI.DateInvoiced<=? 
        AND TI.EAI_BPARTNER_ID=1057126 
        AND P.EAI_PRODUCT_ID=1109877 
    ORDER BY lineAmt  desc;

select count(1) from EAI_TAXINVOICELINE TL inner join EAI_TaxInvoice TI on (TI.EAI_TaxInvoice_ID=TL.EAI_TaxInvoice_ID) inner join EAI_Bpartner BP on (TI.EAI_BPartner_ID=BP.EAI_BPartner_ID) inner join AD_ORG G on (G.AD_ORG_ID=TI.AD_ORG_ID) inner join EAI_ORDERLINE OL on (ol.EAI_ORDERLINE_ID=TL.EAI_ORDERLINE_ID) inner join EAI_ORDER O on (ol.EAI_ORDER_ID=o.EAI_ORDER_ID) inner join eai_product_v P on (TL.EAI_Product_ID=p.EAI_Product_ID) WHERE 1=1  AND TL.Processed='Y' AND TI.DateInvoiced>=? AND TI.DateInvoiced<=? AND TI.EAI_BPARTNER_ID=? AND P.EAI_PRODUCT_ID=?;

select * from EAI_ORDERLINE where EAI_ORDERLINE_ID=1002321;