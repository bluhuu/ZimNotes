-------------------------------------------chcit.EAI_DELIVERYLINE--------------------------------------------------------------
DROP TABLE IF EXISTS chcit.EAI_DELIVERYLINE;
CREATE EXTERNAL TABLE IF NOT EXISTS chcit.EAI_DELIVERYLINE
(AD_CLIENT_ID STRING, AD_ORG_ID STRING, CREATED STRING, CREATEDBY STRING, UPDATED STRING, UPDATEDBY STRING, ISACTIVE STRING, GUARANTEEDATE STRING, LOT STRING, QTY DOUBLE, UOM STRING, EAI_DELIVERYLINE_ID FLOAT, EAI_DELIVERY_ID FLOAT, EAI_PRODUCT_ID STRING, INVOICENO STRING, INVOICETYPENO STRING, DESCRIPTION STRING, LINE STRING, PRICE DOUBLE, LINEAMT DOUBLE, SITEDELIVERYLINEID STRING, SITEINVOICEID STRING, SITEINVOICELINEID STRING, PROCESSED STRING, VERSIONSTAMP STRING, PACKAGENO STRING, PRODUCTIONDATE STRING, SITEORDERID STRING, SITEORDERLINEID STRING, EAI_ORDERLINE_ID FLOAT, ISODDPACKAGE STRING, DELIVERYNO STRING, PACKAGESEQNO STRING, ISPRINTED STRING, PRINTCOUNT STRING, LASTPRINTTIME STRING, EAI_ORDER_ID FLOAT, VENDOR_PRODUCT_ID STRING, VENDOR_QTY DOUBLE, VENDOR_PRICE DOUBLE, VENDOR_UOM STRING, MULTIPLYRATE DOUBLE, DIVIDERATE DOUBLE, QTYRECEIVED DOUBLE, QTYREJECTED DOUBLE, L_BUNDLE_QTY DOUBLE, M_BUNDLE_QTY DOUBLE, VENDOR_QTYRECEIVED DOUBLE, VENDOR_QTYREJECTED DOUBLE, PRODUCTAREA STRING)
COMMENT 'EAI_DELIVERYLINE details'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\;'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;
LOAD DATA INPATH '/user/data/EAI_DELIVERYLINE.txt' OVERWRITE INTO TABLE chcit.EAI_DELIVERYLINE;


select CH_INVOICELINE.AD_ORG_ID,CH_INVOICELINE.M_PRODUCT_ID,CH_ORG.NAME,SUM(QTY),SUM(LINEAMT)
from CH_INVOICELINE
inner CH_ORG on CH_ORG.AD_ORG_ID = CH_INVOICELINE.AD_ORG_ID
group by CH_INVOICELINE.AD_ORG_ID,CH_INVOICELINE.M_PRODUCT_ID,CH_ORG.NAME

select count(1) from (select CH_INVOICELINE.AD_ORG_ID,CH_ORG.NAME,CH_INVOICELINE.M_PRODUCT_ID,SUM(QTY),SUM(LINEAMT) from CH_INVOICELINE inner join CH_ORG on CH_INVOICELINE.AD_ORG_ID=CH_ORG.AD_ORG_ID group by CH_INVOICELINE.AD_ORG_ID,CH_INVOICELINE.M_PRODUCT_ID,CH_ORG.NAME)
