-- AD_Reference_ID 查询 zh_CN 值
SELECT rlt.AD_REF_LIST_ID,rlt.Name,rl.Value FROM AD_REF_LIST_TRL rlt INNER JOIN AD_REF_LIST rl ON(rl.AD_Ref_List_ID=rlt.AD_Ref_List_ID) WHERE rlt.AD_LANGUAGE = 'zh_CN' and rl.AD_Reference_ID = 131;
