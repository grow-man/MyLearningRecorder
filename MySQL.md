# Using unsupported buffer type  

动态库不匹配导致绑定参数失败  

问题：  

仿照工程代码中的其他数据库表增删改查写了一个对`InterlockTrainInfo`表的查询函数，表结构如下：
```
{
        TRAIN_INTERLOCK_INFO_T        *pstTable = NULL;
        FIELD_T             astField[] = {
            {"SyncFlag",                FALSE, PDBT_UINT32, sizeof(INT32),                      0xffffffff},
            {"UserID",                  TRUE,  PDBT_UINT32, sizeof(pstTable->ulUserID),                 OFFSET_OF(pstTable->ulUserID        )},
            {"RawTrainUnitID",          FALSE, PDBT_UINT32, sizeof(pstTable->ulRawTrainUnitID),         OFFSET_OF(pstTable->ulRawTrainUnitID    )},
            {"InterlockedTrainUnitID",  FALSE, PDBT_UINT32, sizeof(pstTable->ulInterlockedTrainUnitID), OFFSET_OF(pstTable->ulInterlockedTrainUnitID   )},
            {"RawTCID",                 FALSE, PDBT_UINT32, sizeof(pstTable->ulRawTCID),                OFFSET_OF(pstTable->ulRawTCID        )},
            {"InterlockedTCID",         FALSE, PDBT_UINT32, sizeof(pstTable->ulInterlockedTCID),        OFFSET_OF(pstTable->ulInterlockedTCID       )},
        };

        m_pTableTrainInterlockInfo = new PDBTable<TRAIN_INTERLOCK_INFO_T>(m_pPDBApp, "InterlockTrainInfo", astField, ARRAY_SIZE(astField));
}
```

查询操作代码如下所示：  
```
BOOL Get(VECTOR<TABLE_T> &vRec, const CHAR *szWhere="")
    {
        INT32                   iRow = 0;
        PDBRET                  enRet = PDB_CONTINUE;
        PDBRsltParam            Params;
        TABLE_T                 stRec = {0};
        FIELD_T                 *pstField;
        UINT8                   *pucRec = (UINT8*)&stRec;
        GString                 strSQL;

        vRec.clear();

        strSQL = "SELECT ";
        for (UINT32 i=0; i<m_vField.size(); i++)
        {
            pstField = &m_vField[i];

            if (!IsSyncFlagField(pstField))
            {
                Params.Bind(pstField->ulType, pucRec+pstField->ulOffset, pstField->ulLen);
                strSQL.cat_sprintf("%s%c", pstField->szFieldName, (i+1)==m_vField.size()?' ':',');
            }
        }

        if (!IS_NULL_STRING(szWhere))
        {
            strSQL.cat_sprintf("FROM %s WHERE (%s) AND SyncFlag>=0 ", m_szTableName, szWhere);
        }
        else
        {
            strSQL.cat_sprintf("FROM %s WHERE SyncFlag>=0 ", m_szTableName);
        }

        GString     strOrder;

        for (UINT32 i=0; i<m_vKeyField.size(); i++)
        {
            pstField = GetKeyField(i);

            strOrder.cat_sprintf("%s%s", i==0?"":",", pstField->szFieldName);
        }

        if (strOrder.Length() > 0)
        {
            strSQL.cat_sprintf("ORDER BY %s", (CHAR*)strOrder);
        }

        iRow = m_pPDBApp->Query(strSQL, Params); /// 此处执行失败，但是手动执行`strSQL`可以得到预期结果
        if (INVALID_ROWCOUNT == iRow)
        {
            PDBLog(LOG_ERROR, "query %s failed", m_szTableName);
            return FALSE;
        }

        memset(&stRec, 0, sizeof(stRec));
        FOR_ROW_FETCH(enRet, m_pPDBApp)
        {
            PostGetConvert(stRec);

            vRec.push_back(stRec);
            memset(&stRec, 0, sizeof(stRec));
        }

        m_pPDBApp->CloseQuery();

        return PDB_ERROR != enRet;
    }
```

执行函数`mysql_stmt_bind_result()`时报错，错误信息为：`Using unsupported buffer type: 3  (parameter: 3)`  

分析代码：  
检查代码发现新增代码与原有代码几无差别，遂将新增代码屏蔽后继续运行，得到同样的错误：`Using unsupported buffer type: 3  (parameter: 3)`，  
检查发现上述代码依赖的动态库与缺省不匹配导致，将匹配的动态库放到软件运行路径后解决。  

![libmySQL - 副本 dll](https://github.com/grow-man/MyLearningRecorder/assets/52662997/3229d57a-a700-4d15-bdba-61a0eb5996cb)
