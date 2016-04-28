trigger updateQuoteItems on Quote_RE__c (after update) {
    if(RecursiveTriggerHandler.isFirstTimeUpdated){
        if(RecursiveTriggerHandler.insertNotDone){
             //system.debug('************************************************* Is First time?====' + RecursiveTriggerHandler.isFirstTimeUpdated);
             RecursiveTriggerHandler.isFirstTimeUpdated = false;
             for(Quote_RE__c quote : Trigger.new){
                if(quote.Job_Type__c == 'Crude'){
                    Decimal tankDiameter = quote.Tank_Diameter__c;
                    LIST<Quote_Line_Item__c> quoteLineItem = ([SELECT id, Name__c, Quote__c FROM Quote_Line_Item__c WHERE Quote__c =: quote.id ]);
            
                    REFERENCE__c baseReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'BASE')]);
                    REFERENCE__c middleReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'MID')]);
                    REFERENCE__c topReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'TOP')]);         
//Equipment data
                    FX5__Price_Book_Item__c tankSweepData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'ANCN_180_8IN']);       
                    FX5__Price_Book_Item__c sigsData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'SLDG_INJ_GLND']);             
                    FX5__Price_Book_Item__c pWasherData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '2.5K_PRSS_WSHR_3GPM']);        
                    FX5__Price_Book_Item__c pWaterHoseData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'HGH_PRSS_DSCHRG_HSE_50']);                
                    FX5__Price_Book_Item__c minsData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'MNWY_INJ_NZZL']);                
                    FX5__Price_Book_Item__c rmcData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'MNWY_CN_RMT']);        
                    FX5__Price_Book_Item__c lvsData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'LVS_DGAS_SYSTM']);        
                    FX5__Price_Book_Item__c trashPumpData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '6_TRSH_PMP']);               
                    FX5__Price_Book_Item__c jetPumpData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'JT_PMP']);        
                    FX5__Price_Book_Item__c flangeHoseData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '4_FLNG_HSE_HMMR_UNN_25']);        
                    FX5__Price_Book_Item__c truckData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'CRW_CB']);       
                    FX5__Price_Book_Item__c supTruckData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PCKUP_TRCK']);        
                    FX5__Price_Book_Item__c one85AcData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '185_AIR_CMP']);        
                    FX5__Price_Book_Item__c three75AcData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '375_AIR_CMP']);        
                    FX5__Price_Book_Item__c hotGMData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '4GAS_MTR_MNTR']);        
                    FX5__Price_Book_Item__c freshAirData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'FRSH_AIR_SETUP_4MSK']);        
                    FX5__Price_Book_Item__c airHoseData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'AIR_HSE_50']);        
                    FX5__Price_Book_Item__c groundCableData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'GRND_CBL']);        
                    FX5__Price_Book_Item__c gasMeterData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '4GAS_MTR_MNTR']);               
                    FX5__Price_Book_Item__c vacHoseData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'VAC_HSE']);        
                    FX5__Price_Book_Item__c waterHoseData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'WTR_HSE_50']);        
                    FX5__Price_Book_Item__c cp20Data = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'CP20_CPPS_BLWR']);        
                    FX5__Price_Book_Item__c tankLightData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'LRG_TNK_LGHT_EP']);        
                    FX5__Price_Book_Item__c flashLightData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'FLSHLGHT_EXP_PRF']);       
                    FX5__Price_Book_Item__c persH2sData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PERS_H2S_MTR_MNTR']);        
                    FX5__Price_Book_Item__c m15Data = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'M15_PMP']);        
                    FX5__Price_Book_Item__c m30Data = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'M30_PMP']);        
                    FX5__Price_Book_Item__c sidewayCannonData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'MNWAY_CN_SD']);       
                    FX5__Price_Book_Item__c vacumTrucksData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '120BBL_VAC_TRCK']);       
                    FX5__Price_Book_Item__c vacTruckGasMeterData = ([SELECT id, FX5__Catalog_Item_Code__c, Hourly__c, Hourly_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '4GAS_MTR_MNTR']);               
//Cleaning Labor data
                    FX5__Price_Book_Item__c superVData = ([SELECT id, FX5__Catalog_Item_Code__c, Standard_Time__c,Over_Time__c,Standard_Time_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'SPVSR']);        
                    FX5__Price_Book_Item__c foremenData = ([SELECT id, FX5__Catalog_Item_Code__c, Standard_Time__c,Over_Time__c,Standard_Time_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'FOREMAN']);        
                    FX5__Price_Book_Item__c equipmentOpData = ([SELECT id, FX5__Catalog_Item_Code__c, Standard_Time__c,Over_Time__c,Standard_Time_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'EQUP_OPER']);        
                    FX5__Price_Book_Item__c laborData = ([SELECT id, FX5__Catalog_Item_Code__c, Standard_Time__c,Over_Time__c,Standard_Time_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'LBR_TECH']);        
                    FX5__Price_Book_Item__c driverData = ([SELECT id, FX5__Catalog_Item_Code__c, Standard_Time__c,Over_Time__c,Standard_Time_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'CL_A_DRV']);                                        
//Materials data
                    FX5__Price_Book_Item__c tyvekData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'TYVEK']);        
                    FX5__Price_Book_Item__c plasticData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '20_VSQN_PLSTC_RLL_100']);        
                    FX5__Price_Book_Item__c respData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'RESP_FLL_FAC']);        
                    FX5__Price_Book_Item__c glovesData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PVC_GLV']);        
                    FX5__Price_Book_Item__c PlugsData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'EAR_PLG_FM']);        
                    FX5__Price_Book_Item__c waterData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'DRNK_WTR']);        
                    FX5__Price_Book_Item__c poolData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'DCN_LG_POOL']);        
                    FX5__Price_Book_Item__c bagsData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PLSTC_BG_30X40']);        
                    FX5__Price_Book_Item__c cleanData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'HND_CLNR']);       
                    FX5__Price_Book_Item__c tapeData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'DUCT_TAPE']);        
                    FX5__Price_Book_Item__c hornData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PRTBL_AIR_HRN']);        
                    FX5__Price_Book_Item__c ragsData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'RAGS_BX']);        
                    FX5__Price_Book_Item__c rgData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'RN_GR_FRC']);        
                    FX5__Price_Book_Item__c cblockData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'CRIB_BLCKS']);       
                    FX5__Price_Book_Item__c respCartData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'RESP_RPLC_CART']);       
                    FX5__Price_Book_Item__c vtruckWashData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'HT_WTR_WSHOUT']);

                    For ( Quote_Line_Item__c qli : quoteLineItem){
                            //system.debug('2  *********************************************************base drain hours=' + quote.Base_Drain_Hours__c + 'non-drain hours=== ' + quote.Non_Drain_Hours__c);
                            IF (qli.Name__c == 'Tank Sweep'){
                                qli.CP__c = tankSweepData.Hourly_Cost__c; 
                                qli.BP__c = tankSweepData.Hourly__c;              
                                qli.B_QTY__c = baseReference.TANKSWEEP__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.TANKSWEEP__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.TANKSWEEP__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Sigs'){
                                qli.CP__c = sigsData.Hourly_Cost__c; 
                                qli.BP__c = sigsData.Hourly__c;               
                                qli.B_QTY__c = baseReference.SIGS__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.SIGS__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.SIGS__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Pressure Washer'){
                                qli.CP__c = pWasherData.Hourly_Cost__c; 
                                qli.BP__c = pWasherData.Hourly__c;               
                                qli.B_QTY__c = baseReference.PW__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.PW__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.PW__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Pressure Washer Hose'){
                                qli.CP__c = pWaterHoseData.Hourly_Cost__c; 
                                qli.BP__c = pWaterHoseData.Hourly__c;               
                                qli.B_QTY__c = baseReference.PWHOSE__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.PWHOSE__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.PWHOSE__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }    
                            IF (qli.Name__c == 'Mins'){
                                qli.CP__c = minsData.Hourly_Cost__c; 
                                qli.BP__c = minsData.Hourly__c;               
                                qli.B_QTY__c = baseReference.MINS__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.MINS__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.MINS__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF(qli.Name__c == 'RMC'){
                                qli.CP__c = rmcData.Hourly_Cost__c; 
                                qli.BP__c = rmcData.Hourly__c;               
                                qli.B_QTY__c = baseReference.rmc__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.rmc__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.rmc__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'LVS'){
                                qli.CP__c = lvsData.Hourly_Cost__c; 
                                qli.BP__c = lvsData.Hourly__c;               
                                qli.B_QTY__c = baseReference.lvs__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.lvs__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.lvs__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Trash Pump'){
                                qli.CP__c = trashPumpData.Hourly_Cost__c; 
                                qli.BP__c = trashPumpData.Hourly__c;               
                                qli.B_QTY__c = baseReference.trashPump__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.trashPump__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.trashPump__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Jet Pump'){
                                qli.CP__c = jetPumpData.Hourly_Cost__c; 
                                qli.BP__c = jetPumpData.Hourly__c;               
                                qli.B_QTY__c = baseReference.jetPump__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.jetPump__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.jetPump__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Flange Hose'){
                                qli.CP__c = flangeHoseData.Hourly_Cost__c; 
                                qli.BP__c = flangeHoseData.Hourly__c;               
                                qli.B_QTY__c = baseReference.flangeHose__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.flangeHose__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.flangeHose__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Truck'){
                                qli.CP__c = truckData.Hourly_Cost__c; 
                                qli.BP__c = truckData.Hourly__c;               
                                qli.B_QTY__c = baseReference.truck__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.truck__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.truck__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF(qli.Name__c == 'Sup Truck'){
                                qli.CP__c = supTruckData.Hourly_Cost__c; 
                                qli.BP__c = supTruckData.Hourly__c;               
                                qli.B_QTY__c = baseReference.supTruck__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.supTruck__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.supTruck__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == '185 Air Compressor'){
                                qli.CP__c = one85AcData.Hourly_Cost__c; 
                                qli.BP__c = one85AcData.Hourly__c;               
                                qli.B_QTY__c = baseReference.X185Ac__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.X185Ac__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.X185Ac__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == '375 Air Compressor'){
                                qli.CP__c = three75AcData.Hourly_Cost__c; 
                                qli.BP__c = three75AcData.Hourly__c;               
                                qli.B_QTY__c = baseReference.X375Ac__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.X375Ac__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.X375Ac__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF(qli.Name__c == 'Hot GM'){
                                qli.CP__c = hotGMData.Hourly_Cost__c; 
                                qli.BP__c = hotGMData.Hourly__c;                 
                                qli.B_QTY__c = baseReference.hotGM__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.hotGM__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.hotGM__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Fresh Air'){
                                qli.CP__c = freshAirData.Hourly_Cost__c; 
                                qli.BP__c = freshAirData.Hourly__c;               
                                qli.B_QTY__c = baseReference.Fresh__c;
                                qli.B_HRS_QTY__c = quote.Fresh_Air_Hours__c;
                                qli.M_QTY__c = 0;
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Fresh_Air_Hours__c;
                                qli.T_QTY__c = 0;           
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Air Hose'){
                                qli.CP__c = airHoseData.Hourly_Cost__c; 
                                qli.BP__c = airHoseData.Hourly__c;               
                                qli.B_QTY__c = baseReference.AHose__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.AHose__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.AHose__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Ground Cable'){
                                qli.CP__c = groundCableData.Hourly_Cost__c; 
                                qli.BP__c = groundCableData.Hourly__c;               
                                qli.B_QTY__c = baseReference.ground__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.ground__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.ground__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Gas Meter'){
                                qli.CP__c = gasMeterData.Hourly_Cost__c; 
                                qli.BP__c = gasMeterData.Hourly__c;               
                                qli.B_QTY__c = baseReference.gasMeter__c;
                                IF (quote.Gas_Meters__c == True){
                                    qli.B_HRS_QTY__c = qli.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
                                }
                                ELSE{
                                    qli.B_HRS_QTY__c = 0;
                                }
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.gasMeter__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                IF (quote.Gas_Meters__c == TRUE){
                                    qli.M_HRS_QTY__c = quote.Middle_Drain_Hours__c * qli.M_QTY__c;
                                }
                                ELSE{
                                    qli.M_HRS_QTY__c = 0;
                                }
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.gasMeter__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                IF (quote.Gas_Meters__c == TRUE){
                                    qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                                }
                                ELSE{
                                    qli.T_HRS_QTY__c = 0;
                                }
                            }
                            IF (qli.Name__c == 'Vac Hose'){
                                qli.CP__c = vacHoseData.Hourly_Cost__c; 
                                qli.BP__c = vacHoseData.Hourly__c;               
                                qli.B_QTY__c = baseReference.vacHose__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.vacHose__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.vacHose__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Water Hose'){
                                qli.CP__c = waterHoseData.Hourly_Cost__c; 
                                qli.BP__c = waterHoseData.Hourly__c;               
                                qli.B_QTY__c = baseReference.WHose__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.WHose__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.WHose__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'CP20'){
                                qli.CP__c = cp20Data.Hourly_Cost__c; 
                                qli.BP__c = cp20Data.Hourly__c;               
                                qli.B_QTY__c = baseReference.cp20__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.cp20__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.cp20__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Tank Light'){
                                qli.CP__c = tankLightData.Hourly_Cost__c; 
                                qli.BP__c = tankLightData.Hourly__c;               
                                qli.B_QTY__c = baseReference.TLight__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.TLight__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.TLight__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Flash Light'){
                                qli.CP__c = flashLightData.Hourly_Cost__c; 
                                qli.BP__c = flashLightData.Hourly__c;               
                                qli.B_QTY__c = baseReference.FLight__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.FLight__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.FLight__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Personell H2S'){
                                qli.CP__c = persH2sData.Hourly_Cost__c; 
                                qli.BP__c = persH2sData.Hourly__c;               
                                qli.B_QTY__c = baseReference.H2s__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.H2s__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.H2s__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'M15'){
                                qli.CP__c = m15Data.Hourly_Cost__c; 
                                qli.BP__c = m15Data.Hourly__c;               
                                qli.B_QTY__c = baseReference.m15__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.m15__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.m15__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'M30'){
                                qli.CP__c = m30Data.Hourly_Cost__c; 
                                qli.BP__c = m30Data.Hourly__c;               
                                qli.B_QTY__c = baseReference.m30__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.m30__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.m30__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Sideway Cannon'){
                                qli.CP__c = sidewayCannonData.Hourly_Cost__c; 
                                qli.BP__c = sidewayCannonData.Hourly__c;               
                                qli.B_QTY__c = baseReference.SCanon__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Base_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.SCanon__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Middle_Drain_Hours__c;
                                IF(quote.Total_Inches_Remain__c >= 67){
                                    qli.T_QTY__c = topReference.SCanon__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_HRS_QTY__c = qli.T_QTY__c * quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Vacum Trucks'){
                                qli.CP__c = vacumTrucksData.Hourly_Cost__c; 
                                qli.BP__c = vacumTrucksData.Hourly__c;               
                                qli.B_QTY__c = quote.Vacum_Trucks__c;
                                qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Vac_Truck_Hours__c;
                                qli.M_QTY__c = quote.Vacum_Trucks__c;
                                qli.M_HRS_QTY__c = qli.M_QTY__c * quote.Vac_Truck_Hours__c;
                                qli.T_QTY__c = quote.Vacum_Trucks__c;           
                            }
                            IF (qli.Name__c == 'Vac Truck Gas Meter'){
                                qli.CP__c = vacTruckGasMeterData.Hourly_Cost__c; 
                                qli.BP__c = vacTruckGasMeterData.Hourly__c;               
                                qli.B_QTY__c = quote.Vacum_Trucks__c;
                                IF (quote.Gas_Meters__c == TRUE){
                                    qli.B_HRS_QTY__c = qli.B_QTY__c * quote.Vac_Truck_Hours__c;
                                }
                                ELSE{
                                    qli.B_HRS_QTY__c = 0;
                                }            
                                qli.M_QTY__c = quote.Vacum_Trucks__c;
                                qli.M_HRS_QTY__c = 0;
                                qli.T_QTY__c = quote.Vacum_Trucks__c;
                                qli.T_HRS_QTY__c = 0;
                            }                   
           //materials                          
                            IF (qli.Name__c == 'Tyvek'){
                                qli.CP__c = tyvekData.FX5__Catalog_Cost__c; 
                                qli.BP__c = tyvekData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.TYVEK__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.TYVEK__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.TYVEK__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }
                            IF (qli.Name__c == 'Plastic'){
                                qli.CP__c = plasticData.FX5__Catalog_Cost__c; 
                                qli.BP__c = plasticData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.PLASTIC__c;
                                qli.B_Job_QTY__c = baseReference.PLASTIC__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.PLASTIC__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                IF(quote.Total_Inches_Remain__c>19){
                                    qli.M_Job_QTY__c = middleReference.PLASTIC__c;
                                }
                                ELSE{
                                    qli.M_Job_QTY__c = 0;
                                }           
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.PLASTIC__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_Job_QTY__c = topReference.PLASTIC__c;
                                }
                                ELSE{
                                    qli.T_Job_QTY__c = 0;
                                }
                            }        
                            IF (qli.Name__c == 'Respirators'){
                                qli.CP__c = respData.FX5__Catalog_Cost__c; 
                                qli.BP__c = respData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.resp__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c * quote.Base_Shifts__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.resp__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.resp__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }    
                            IF (qli.Name__c == 'Gloves'){
                                qli.CP__c = glovesData.FX5__Catalog_Cost__c; 
                                qli.BP__c = glovesData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.gloves__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.gloves__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.gloves__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }    
                            IF (qli.Name__c == 'Ear Plugs'){
                                qli.CP__c = plugsData.FX5__Catalog_Cost__c; 
                                qli.BP__c = plugsData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.plugs__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.plugs__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.plugs__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }     
                            IF (qli.Name__c == 'Water'){
                                qli.CP__c = waterData.FX5__Catalog_Cost__c; 
                                qli.BP__c = waterData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.water__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.water__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.water__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }     
                            IF (qli.Name__c == 'Kitty Pools'){
                                qli.CP__c = poolData.FX5__Catalog_Cost__c; 
                                qli.BP__c = poolData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.pool__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c * quote.Base_Shifts__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.pool__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.pool__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }      
                            IF (qli.Name__c == 'Plastic Bags'){
                                qli.CP__c = bagsData.FX5__Catalog_Cost__c; 
                                qli.BP__c = bagsData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.bags__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c * quote.Base_Shifts__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.bags__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.bags__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c =qli.T_QTY__c * quote.Top_Shifts__c;
                            }     
                            IF (qli.Name__c == 'Hand Cleaner'){
                                qli.CP__c = cleanData.FX5__Catalog_Cost__c; 
                                qli.BP__c = cleanData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.clean__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.clean__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.clean__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }   
                            IF (qli.Name__c == 'Duct Tape'){
                                qli.CP__c = tapeData.FX5__Catalog_Cost__c; 
                                qli.BP__c = tapeData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.tape__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.tape__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.tape__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }        
                            IF (qli.Name__c == 'Air Horn'){
                                qli.CP__c = hornData.FX5__Catalog_Cost__c; 
                                qli.BP__c = hornData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.horn__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c * quote.Base_Shifts__c ;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.horn__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.horn__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }
                            IF (qli.Name__c == 'Rags'){
                                qli.CP__c = ragsData.FX5__Catalog_Cost__c; 
                                qli.BP__c = ragsData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.rags__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c * quote.Base_Shifts__c ;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.rags__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.rags__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }
                            IF (qli.Name__c == 'Rain Gear'){
                                qli.CP__c = rgData.FX5__Catalog_Cost__c; 
                                qli.BP__c = rgData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.rg__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c * quote.Base_Shifts__c ;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.rg__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.rg__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            }
                            IF (qli.Name__c == 'Cribbing Blocks'){
                                qli.CP__c = cblockData.FX5__Catalog_Cost__c; 
                                qli.BP__c = cblockData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.cblock__c * 28;
                                qli.B_Job_QTY__c = baseReference.cblock__c * 28;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.cblock__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                IF(quote.Total_Inches_Remain__c>19){
                                    qli.M_Job_QTY__c = middleReference.cblock__c * 28;
                                }
                                ELSE{
                                    qli.M_Job_QTY__c = 0;
                                }           
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.cblock__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_Job_QTY__c = topReference.cblock__c*28;
                                }
                                ELSE{
                                    qli.T_Job_QTY__c = 0;
                                }
                            } 
                            IF (qli.Name__c == 'Respirator Cartridge'){
                                qli.CP__c = respCartData.FX5__Catalog_Cost__c; 
                                qli.BP__c = respCartData.FX5__Price__c;               
                                qli.B_QTY__c = baseReference.resp__c;
                                qli.B_Job_QTY__c = qli.B_QTY__c * quote.Base_Shifts__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = middleReference.resp__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = qli.M_QTY__c * quote.Middle_Shifts__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = topReference.resp__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = qli.T_QTY__c * quote.Top_Shifts__c;
                            } 
                            IF (qli.Name__c == 'Vac Truck Wash'){
                                qli.CP__c = vtruckWashData.FX5__Catalog_Cost__c; 
                                qli.BP__c = vtruckWashData.FX5__Price__c;               
                                qli.B_QTY__c = quote.Vacum_Trucks__c;
                                qli.B_Job_QTY__c = quote.Vacum_Trucks__c;
                                IF(quote.Total_Inches_Remain__c >= 19){
                                    qli.M_QTY__c = quote.Vacum_Trucks__c;
                                }
                                ELSE{
                                    qli.M_QTY__c = 0;
                                }
                                qli.M_Job_QTY__c = quote.Vacum_Trucks__c;
                                IF(quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c = quote.Vacum_Trucks__c;
                                }
                                ELSE{
                                    qli.T_QTY__c = 0;
                                }
                                qli.T_Job_QTY__c = quote.Vacum_Trucks__c;
                            }                   
        //labor                             
                            IF (qli.Name__c == 'Cleaning Supervisor'){
                                system.debug('cleanup supervisor  *********************************************************base drain hours=' + quote.Base_Drain_Hours__c + 'non-drain hours=== ' + quote.Non_Drain_Hours__c);
                                qli.CP__c = superVData.Standard_Time_Cost__c; 
                                qli.BP__c = superVData.Standard_Time__c; 
                                qli.B_QTY__c = baseReference.CLEANUP_SUP__c;
                                qli.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>19){
                                    qli.M_QTY__c= middleReference.cleanup_Sup__c;
                                }
                                ELSE{
                                    qli.M_QTY__c= 0;
                                }
                                qli.M_Hours__c  = quote.Middle_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c= topReference.cleanup_Sup__c;
                                }
                                ELSE{
                                    qli.T_QTY__c= 0;
                                }
                                qli.T_Hours__c = quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Cleanup Foremen'){
                                system.debug('cleanup foremen*********************************************************base drain hours=' + quote.Base_Drain_Hours__c + 'non-drain hours=== ' + quote.Non_Drain_Hours__c);
                                qli.CP__c = foremenData.Standard_Time_Cost__c; 
                                qli.BP__c = foremenData.Standard_Time__c; 
                                qli.B_QTY__c = baseReference.CLEANUP_FOREMEN__c;
                                qli.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>19){
                                    qli.M_QTY__c= middleReference.cleanup_FOREMEN__c;
                                }
                                ELSE{
                                    qli.M_QTY__c= 0;
                                }
                                qli.M_Hours__c  = quote.Middle_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c= topReference.cleanup_FOREMEN__c;
                                }
                                ELSE{
                                    qli.T_QTY__c= 0;
                                }
                                qli.T_Hours__c = quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Cleanup Equipment Op'){
                                system.debug('cleanup equip op*********************************************************base drain hours=' + quote.Base_Drain_Hours__c + 'non-drain hours=== ' + quote.Non_Drain_Hours__c);
                                qli.CP__c = equipmentOpData.Standard_Time_Cost__c; 
                                qli.BP__c = equipmentOpData.Standard_Time__c; 
                                qli.B_QTY__c = baseReference.CLEANUP_eo__c;
                                qli.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>19){
                                    qli.M_QTY__c= middleReference.cleanup_eo__c;
                                }
                                ELSE{
                                    qli.M_QTY__c= 0;
                                }
                                qli.M_Hours__c  = quote.Middle_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c= topReference.cleanup_eo__c;
                                }
                                ELSE{
                                    qli.T_QTY__c= 0;
                                }
                                qli.T_Hours__c = quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Cleanup Labor'){
                                system.debug('cleanup labor *********************************************************base drain hours=' + quote.Base_Drain_Hours__c + 'non-drain hours=== ' + quote.Non_Drain_Hours__c);
                                qli.CP__c = laborData.Standard_Time_Cost__c; 
                                qli.BP__c = laborData.Standard_Time__c; 
                                qli.B_QTY__c = baseReference.CLEANUP_labor__c;
                                qli.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>19){
                                    qli.M_QTY__c= middleReference.cleanup_labor__c;
                                }
                                ELSE{
                                    qli.M_QTY__c= 0;
                                }
                                qli.M_Hours__c  = quote.Middle_Drain_Hours__c;
                                IF (quote.Total_Inches_Remain__c>67){
                                    qli.T_QTY__c= topReference.cleanup_labor__c;
                                }
                                ELSE{
                                    qli.T_QTY__c= 0;
                                }
                                qli.T_Hours__c = quote.Top_Drain_Hours__c;
                            }
                            IF (qli.Name__c == 'Cleanup Driver'){
                                qli.CP__c = driverData.Standard_Time_Cost__c; 
                                qli.BP__c = driverData.Standard_Time__c; 
                                qli.B_QTY__c = quote.Vacum_Trucks__c;              
                                qli.B_Hours__c = quote.Vac_Truck_Hours__c;            
                                qli.M_QTY__c = 0;
                                qli.T_QTY__c = 0;
                            }  
                    }//end for each qli quote item updates
                    update quoteLineItem; 
                }//end if crude tool             
    //begin refine tool
                else{
                    Decimal tankDiameter = quote.Tank_Diameter__c;
                    LIST<Quote_Line_Item__c> quoteLineItem = ([SELECT id, Name__c, Quote__c, Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quote.id ]);
                    LIST<Quote_Line_Item__c> quoteLineItem2 = ([SELECT id, Name__c, Quote__c, Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quote.id ]);
                    //LIST<Quote_Line_Item__c> quoteLineItem = new LIST<Quote_Line_Item__c>();
                    String locationEntered = quote.Location__c; 
                    String quoteID = quote.Id;
                    REFERENCE__c refinedReference = ([SELECT id,TYPE__C,DS__c,DE__c,TECHS__C,PTFIXED__C,PTRING__C,PTDECK__C,WASH__C,TRUCK__C,X185AC__C,X375AC__C,
                        HOTWASH__C,HOTEO__C,HOTGM__C,FRESH__C,AHOSE__C,GROUND__C,GASMETER__C,VACHOSE__C,WHOSE__C,JETPUMP__C,    GAMAJ__C,CP20__C,TLIGHT__C,FLIGHT__C,
                        H2S__C,M15__C,RG__C,PLASTIC__C,RESP__C,GLOVES__C,PLUGS__C,  WATER__C,POOL__C,BAGS__C,CLEAN__C,TAPE__C,HORN__C,STEM__C,MOB__C,WASHRATE__C,LEGCREW__C,
                        SETLEGS__C,CRIBHOURS__C,CRIBTOWERS__C FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'Refined')]);
                    LOCATION__c location = ([SELECT id, Name, BOTTLEWASH__C, FRESHAIR_REFINED__C, GasMeter_Loc__c, M30__c, MOB_HOURS__C, WASH__C, HOLEWATCH__C, GASMETERQTY__C, PERDIEM__c, TRAVELTIME__c, FRESHAIR__c, GASMETERS__c FROM LOCATION__c WHERE Name =: locationEntered]);           
//Equipment data                    
                    FX5__Price_Book_Item__c gamaJetData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'GAMA_JET']);       
                    FX5__Price_Book_Item__c cartData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'RESP_RPLC_CART']);             
                    FX5__Price_Book_Item__c hotPWasherData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '2.5K_PRSS_WSHR_3GPM']);        
                    FX5__Price_Book_Item__c jetPumpData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'JT_PMP']);        
                    FX5__Price_Book_Item__c gearTruckData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'CRW_CB']);       
                    FX5__Price_Book_Item__c one85AcData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '185_AIR_CMP']);        
                    FX5__Price_Book_Item__c three75AcData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '375_AIR_CMP']);        
                    FX5__Price_Book_Item__c freshAirData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'FRSH_AIR_SETUP_4MSK']);        
                    FX5__Price_Book_Item__c airHoseData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'AIR_HSE_50']);        
                    FX5__Price_Book_Item__c groundCableData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'GRND_CBL']);        
                    FX5__Price_Book_Item__c gasMeterData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '4GAS_MTR_MNTR']);               
                    FX5__Price_Book_Item__c vacHoseData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '4_CMLCK_VAC_HSE_20']);        
                    FX5__Price_Book_Item__c waterHoseData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'WTR_HSE_50']);        
                    FX5__Price_Book_Item__c cp20Data = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'CP20_CPPS_BLWR']);        
                    FX5__Price_Book_Item__c tankLightData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'LRG_TNK_LGHT_EP']);        
                    FX5__Price_Book_Item__c flashLightData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'FLSHLGHT_EXP_PRF']);       
                    FX5__Price_Book_Item__c persH2sData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PERS_H2S_MTR_MNTR']);        
                    FX5__Price_Book_Item__c m15Data = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'M15_PMP']);        
                    FX5__Price_Book_Item__c m30Data = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'M30_PMP']);        
                    FX5__Price_Book_Item__c vacumTrucksData = ([SELECT id, FX5__Catalog_Item_Code__c,Hourly_Cost__c, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '120BBL_VAC_TRCK']);       
//Materials data
                    FX5__Price_Book_Item__c tyvekData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'TYVEK']);        
                    FX5__Price_Book_Item__c plasticData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '20_VSQN_PLSTC_RLL_100']);        
                    FX5__Price_Book_Item__c respData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: '1/2_RESP_FAC']);        
                    FX5__Price_Book_Item__c glovesData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PVC_GLV']);        
                    FX5__Price_Book_Item__c earPlugsData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'EAR_PLG_FM']);        
                    FX5__Price_Book_Item__c waterData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'DRNK_WTR']);        
                    FX5__Price_Book_Item__c poolData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'DCN_LG_POOL']);        
                    FX5__Price_Book_Item__c bagsData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PLSTC_BG_30X40']);        
                    FX5__Price_Book_Item__c cleanData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'HND_CLNR']);       
                    FX5__Price_Book_Item__c tapeData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'DUCT_TAPE']);        
                    FX5__Price_Book_Item__c hornData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'PRTBL_AIR_HRN']);        
                    FX5__Price_Book_Item__c cblockData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'CRIB_BLCKS']);       
                    FX5__Price_Book_Item__c respCartData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'RESP_RPLC_CART']);       
                    FX5__Price_Book_Item__c vtruckWashData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'HT_WTR_WSHOUT']);
                    FX5__Price_Book_Item__c rgData = ([SELECT id, FX5__Catalog_Item_Code__c, FX5__Price__c,FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'RN_GR_FRC']);        
//Labor data
                    FX5__Price_Book_Item__c mrateData = ([SELECT id, Hourly__c, Hourly_Cost__c,Over_Time__c,Standard_Time__c, Standard_Time_Cost__c,Over_Time_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'mrate']);
                                        
                    For ( Quote_Line_Item__c qli : quoteLineItem){
                    //equipment calculations
                        IF (qli.Name__c == 'Gear Trucks'){
                            qli.CP__c = gearTruckData.Hourly_Cost__c; 
                            qli.PPE__c = gearTruckData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.Truck__c;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;    
                        }           
                        IF (qli.Name__c == '185 Air Compressor'){
                            qli.CP__c = one85AcData.Hourly_Cost__c; 
                            qli.PPE__c = one85AcData.Hourly__c; //billing figure                            
                            qli.B_QTY__c = refinedReference.X185AC__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c; 
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == '375 Air Compressor'){
                            qli.CP__c = three75AcData.Hourly_Cost__c; 
                            qli.PPE__c = three75AcData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.X375AC__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Gas Meter'){
                            qli.CP__c = gasMeterData.Hourly_Cost__c; 
                            qli.PPE__c = gasMeterData.Hourly__c; //billing figure                           
                            if(quote.Location__c == 'Wilmington'){
                                qli.B_QTY__c = 0;
                            }
                            else if(quote.Location__c == 'Carson'){
                                qli.B_QTY__c = 0;
                            }
                            else{
                                qli.B_QTY__c = quote.GasMeters_Hotwash__c + quote.GasMeters_Tank__c + location.GasMeter_Loc__c + quote.GasMeters_Vac_Truck__c;
                            }                               
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;    
                        }
                        IF (qli.Name__c == 'CP-20'){
                            qli.CP__c = cp20Data.Hourly_Cost__c; 
                            qli.PPE__c = cp20Data.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.CP20__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Personell H2s'){
                            qli.CP__c = persH2sData.Hourly_Cost__c; 
                            qli.PPE__c = persH2sData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.H2S__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'M-15s'){
                            qli.CP__c = m15Data.Hourly_Cost__c; 
                            qli.PPE__c = m15Data.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.M15__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Ground Cable'){
                            qli.CP__c = groundCableData.Hourly_Cost__c; 
                            qli.PPE__c = groundCableData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.GROUND__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Vac Hoses'){
                            qli.CP__c = vacHoseData.Hourly_Cost__c; 
                            qli.PPE__c = vacHoseData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.VACHOSE__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Water Hoses'){
                            qli.CP__c = waterHoseData.Hourly_Cost__c; 
                            qli.PPE__c = waterHoseData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.WHOSE__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;    
                        }
                        IF (qli.Name__c == 'Jet Pump'){
                            qli.CP__c = jetPumpData.Hourly_Cost__c; 
                            qli.PPE__c = jetPumpData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.JETPUMP__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Gama Jet'){
                            qli.CP__c = gamaJetData.Hourly_Cost__c; 
                            qli.PPE__c = gamaJetData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.GAMAJ__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;            
                        }
                        IF (qli.Name__c == 'M30'){
                            qli.CP__c = m30Data.Hourly_Cost__c; 
                            qli.PPE__c = m30Data.Hourly__c; //billing figure
                            qli.B_Qty__c = location.M30__c;              
                            //qli.B_QTY__c = refinedReference.TRUCK__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Flash Lights'){
                            qli.CP__c = flashLightData.Hourly_Cost__c; //cost figure
                            qli.PPE__c = flashLightData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.FLIGHT__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Tank Lights'){
                            qli.CP__c = tankLightData.Hourly_Cost__c; 
                            qli.PPE__c = tankLightData.Hourly__c; //billing figure
                            qli.B_QTY__c = refinedReference.JETPUMP__C;  //this is what is referred to in excel calculators            
                            //qli.B_QTY__c = refinedReference.TLIGHT__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Vacuum Trucks'){
                            qli.CP__c = vacumTrucksData.Hourly_Cost__c; 
                            qli.PPE__c = vacumTrucksData.Hourly__c; //billing figure              
                            qli.B_QTY__c = quote.Vacum_Trucks__c;
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Fresh Air'){
                            qli.CP__c = freshAirData.Hourly_Cost__c; 
                            qli.PPE__c = freshAirData.Hourly__c; //billing figure 
                            if(quote.Fresh_Air_Needed__c == false){
                                qli.B_QTY__c = 0;
                            }             
                            else{
                                qli.B_QTY__c = 1;
                            }
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.EXT__c * quote.Fresh_Air_Hours_Refined__c * quote.Techs__c;
                        }
                        IF (qli.Name__c == 'Air Hose'){
                            qli.CP__c = airHoseData.Hourly_Cost__c; 
                            qli.PPE__c = airHoseData.Hourly__c; //billing figure              
                            qli.B_QTY__c = refinedReference.AHOSE__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Hot Pressure Washer'){
                            qli.CP__c = hotPWasherData.Hourly_Cost__c; 
                            qli.PPE__c = hotPWasherData.Hourly__c; //billing figure              
                            if(quote.Wash_Type__c == 'Hot'){
                                qli.B_QTY__c = refinedReference.HOTWASH__C;//using base quantity in quote line item 
                            }
                            else{
                                qli.B_QTY__c = 0;//using base quantity in quote line item
                            }
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                            qli.Per_Shift__c = qli.Ext__c * quote.Hours_In_Shift__c; 
                        }

    //labor calculations    
                        
                        IF (qli.Name__c == 'Pontoon Labor'){
                            /*Integer pontoonOverTimeHours;
                            Integer pontoonStandardTimeHours;
                            if (quote.Hours_In_Shifts__c == 10){
                                pontoonOverTimeHours = (quote.Pontoon_Hours__c/quote.Total_Shifts__c) * 2;
                                pontoonStandardTimeHours = quote.Pontoon_Hours__c - pontoonOverTimeHours;
                                pontoonLabor.Total__c = (pontoonOverTimeHours * pontoonData.Over_Time__c) + (pontoonStandardTimeHours * pontoonData.Standard_Time__c);
                            }
                            else if (quote.Hours_In_Shifts__c == 12){
                                pontoonOverTimeHours = (quote.Pontoon_Hours__c/quote.Total_Shifts__c) * 4;
                                pontoonStandardTimeHours = quote.Pontoon_Hours__c - pontoonOverTimeHours;
                                pontoonLabor.Total__c = (pontoonOverTimeHours * pontoonData.Over_Time__c) + (pontoonStandardTimeHours * pontoonData.Standard_Time__c);
                            }
                            else if (quote.Hours_In_Shifts__c == 08){
                                pontoonLabor.Total__c = quote.Pontoon_Crew__c * quote.Pontoon_Hours__c;
                            }*/
                            qli.Total__c = quote.Pontoon_Crew__c * quote.Pontoon_Hours__c * mrateData.Hourly__c;                                
                        }
                        IF (qli.Name__c == 'Wash Labor'){
                            qli.Total__c = quote.Wash_Crew__c * quote.Wash_Hours__c *mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'HotWash Labor'){
                            qli.Total__c = quote.HotWash_Crew__c * quote.HotWash_Hours__c * mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'MOB Labor'){
                            qli.Total__c = quote.MOB_Crew__c * quote.MOB_Hours__c * 44;
                        }
                        IF (qli.Name__c == 'DeMOB Labor'){
                            qli.Total__c = quote.DeMOB_Crew__c * quote.DeMOB_Hours__c * mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'Drain Labor'){
                            qli.Total__c = quote.Drain_Crew__c * quote.Drain_Hours__c * mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'Scale Labor'){
                            qli.Total__c = quote.Scale_Crew__c * quote.Scale_Hours__c * mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'Legs Labor'){
                            qli.Total__c = quote.Legs_Crew__c * quote.Legs_Hours__c * mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'Cribbing Labor'){
                            qli.Total__c = quote.Cribbing_Crew__c * quote.Cribbing_Hours__c * mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'Vacuum Labor'){
                            qli.Total__c = quote.Vac_Truck_Crew__c * quote.Vac_Truck_Hours_Refined__c * mrateData.Hourly__c;
                        }
                        IF (qli.Name__c == 'BottleWash Labor'){
                            qli.Total__c = quote.BottleWash_Crew__c * quote.Fresh_Air_Hours_Refined__c * mrateData.Hourly__c;
                        }
                                
//Materials
                        
                        IF (qli.Name__c == 'Rain Gear'){
                            qli.CP__c = rgData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = rgData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.RG__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                        }
                        IF (qli.Name__c == 'Plastic'){
                            qli.CP__c = plasticData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = plasticData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.PLASTIC__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Respirators'){
                            qli.CP__c = respData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = respData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.RESP__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Gloves'){
                            qli.CP__c = glovesData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = glovesData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.GLOVES__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Ear Plugs'){
                            qli.CP__c = earPlugsData.FX5__Catalog_Cost__c;
                            qli.PPE__c = earPlugsData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.PLUGS__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Water'){
                            qli.CP__c = waterData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = waterData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.WATER__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Kitty Pools'){
                            qli.CP__c = poolData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = poolData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.POOL__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Plastic Bags'){
                            qli.CP__c = bagsData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = bagsData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.BAGS__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Hand Cleaner'){
                            qli.CP__c = cleanData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = cleanData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.CLEAN__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Duct Tape'){
                            qli.CP__c = tapeData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = tapeData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.TAPE__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                       }
                        IF (qli.Name__c == 'Air Horn'){
                            qli.CP__c = hornData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = hornData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.HORN__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                        }
                        IF (qli.Name__c == 'Respirator Cart'){
                            qli.CP__c = respCartData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = respCartData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.RESP__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                        }
                        IF (qli.Name__c == 'Cribbing Towers'){
                            qli.CP__c = cblockData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = cblockData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = quote.Cribbing_Towers__c * 28;
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                        }
                        IF (qli.Name__c == 'Vac Truck Wash'){
                            qli.CP__c = vtruckWashData.FX5__Catalog_Cost__c;
                            qli.PPE__c = vtruckWashData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = quote.Vacum_Trucks__c;
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                        }
                        IF (qli.Name__c == 'Tyvek'){
                            qli.CP__c = tyvekData.FX5__Catalog_Cost__c; 
                            qli.PPE__c = tyvekData.FX5__Price__c; //billing figure              
                            qli.B_QTY__c = refinedReference.RG__C;//using base quantity in quote line item
                            qli.Ext__c = qli.PPE__c * qli.B_QTY__c;
                        }
                        //Mat shifts
                       
                        IF (qli.Name__c == 'Pontoon MatShifts'){
                            qli.Total__c = quote.Pontoon_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Wash MatShifts'){
                            qli.Total__c = quote.Wash_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'HotWash MatShifts'){
                            qli.Total__c = quote.HotWash_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'MOB MatShifts'){
                            qli.Total__c = quote.MOB_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'DeMOB MatShifts'){
                            qli.Total__c = quote.DeMOB_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Drain MatShifts'){
                            qli.Total__c = quote.Drain_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Scale MatShifts'){
                            qli.Total__c = quote.Scale_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Legs MatShifts'){
                            qli.Total__c = quote.Legs_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Cribbing MatShifts'){
                            qli.Total__c = quote.Cribbing_Hours__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'Vacuum MatShifts'){
                            qli.Total__c = quote.Vac_Truck_Hours_Refined__c/quote.Hours_In_Shift__c;
                        }
                        IF (qli.Name__c == 'BottleWash MatShifts'){
                            qli.Total__c = quote.Fresh_Air_Hours_Refined__c/quote.Hours_In_Shift__c;                            
                        }
                    }
                    update quoteLineItem;
                    //materials
                    Quote_Line_Item__c rainGear = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Rain Gear'];
                    Quote_Line_Item__c plastic = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Plastic'];
                    Quote_Line_Item__c resp = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Respirators'];
                    Quote_Line_Item__c gloves = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Gloves'];
                    Quote_Line_Item__c earPlugs = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Ear Plugs'];
                    Quote_Line_Item__c water = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Water'];
                    Quote_Line_Item__c pool = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Kitty Pools'];
                    Quote_Line_Item__c bags = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Plastic Bags'];
                    Quote_Line_Item__c clean = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Hand Cleaner'];
                    Quote_Line_Item__c tape = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Duct Tape'];
                    Quote_Line_Item__c horn = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Air Horn'];
                    Quote_Line_Item__c respCart = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Respirator Cart'];
                    Quote_Line_Item__c cblock = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Cribbing Blocks'];
                    Quote_Line_Item__c vtruckWash = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Vac Truck Wash'];
                    Quote_Line_Item__c tyvek = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Tyvek'];
                    //equipment
                    Quote_Line_Item__c gearTrucks = [SELECT id,Name__c, Ext__c, PPE__c,B_QTY__c,Quote__c, Per_Shift__c,CP__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Gear Trucks'];   
                    Quote_Line_Item__c one85Ac = [SELECT  id,Name__c, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: '185 Air Compressor'];
                    Quote_Line_Item__c three85Ac = [SELECT  id,Name__c, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: '375 Air Compressor'];
                    Quote_Line_Item__c gasMeter = [SELECT id,Name__c, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Gas Meter'];
                    Quote_Line_Item__c cp20 = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'CP-20'];
                    Quote_Line_Item__c persH2s = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Personell H2s'];
                    Quote_Line_Item__c m15 = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'M-15s'];
                    Quote_Line_Item__c groundCable = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Ground Cable'];
                    Quote_Line_Item__c vacHose = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Vac Hoses'];
                    Quote_Line_Item__c waterHose = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Water Hoses'];
                    Quote_Line_Item__c jetPump = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Jet Pump'];
                    Quote_Line_Item__c gamaJet = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Gama Jet'];
                    Quote_Line_Item__c M30 = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'M30'];
                    Quote_Line_Item__c flashLight = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Flash Lights'];
                    Quote_Line_Item__c tankLight = [SELECT id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Tank Lights'];
                    Quote_Line_Item__c vacumTrucks = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Vacuum Trucks'];
                    Quote_Line_Item__c freshAir = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Fresh Air'];
                    Quote_Line_Item__c airHose = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Air Hose'];
                    Quote_Line_Item__c hotPWasher = [SELECT  id,Name, Ext__c, PPE__c,B_QTY__c, Per_Shift__c,CP__c  FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Hot Pressure Washer'];
                    //shifts
                    Quote_Line_Item__c pontoonMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Pontoon MatShifts'];
                    Quote_Line_Item__c washMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Wash MatShifts'];
                    Quote_Line_Item__c hotWashMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'HotWash MatShifts'];
                    Quote_Line_Item__c MOBMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'MOB MatShifts'];
                    Quote_Line_Item__c DeMOBMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'DeMOB MatShifts'];
                    Quote_Line_Item__c drainMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Drain MatShifts'];
                    Quote_Line_Item__c scaleMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Scale MatShifts'];
                    Quote_Line_Item__c legsMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Legs MatShifts'];
                    Quote_Line_Item__c cribbingMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Cribbing MatShifts'];
                    Quote_Line_Item__c vacuumMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'Vacuum MatShifts'];
                    Quote_Line_Item__c bottleWashMatShift = [SELECT id,Name, Ext__c, PPE__c,Total__c FROM Quote_Line_Item__c WHERE Quote__c =: quoteId AND Name__c =: 'BottleWash MatShifts'];
                                        
                    For ( Quote_Line_Item__c qli2 : quoteLineItem2){
                        //Materials totals by type                           
                        IF (qli2.Name__c == 'Pontoon Crew Materials'){
                            qli2.Total__c = (resp.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + pool.Ext__c + bags.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c + respCart.Ext__c + tyvek.Ext__c) * pontoonMatShift.Total__c;                          
                        }
                        IF (qli2.Name__c == 'Wash Crew Materials'){
                            qli2.Total__c = (rainGear.Ext__c  + resp.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + pool.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c + respCart.Ext__c ) * washMatShift.Total__c + plastic.Ext__c;                         
                        }
                        IF (qli2.Name__c == 'MOB Crew Materials'){
                            qli2.Total__c = (gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c  + tyvek.Ext__c) * MOBMatShift.Total__c;                         
                        }
                        IF (qli2.Name__c == 'DeMOB Crew Materials'){
                            qli2.Total__c = (rainGear.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c  + bags.Ext__c + clean.Ext__c + tape.Ext__c ) * DeMOBMatShift.Total__c;
                        }
                        IF (qli2.Name__c == 'Drain Crew Materials'){
                            qli2.Total__c = (gloves.Ext__c + earPlugs.Ext__c) * drainMatShift.Total__c;
                        }
                        IF (qli2.Name__c == 'Scale Crew Materials'){
                            qli2.Total__c = (rainGear.Ext__c + resp.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + pool.Ext__c + bags.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c) * scaleMatShift.Total__c;
                        }
                        IF (qli2.Name__c == 'Legs Crew Materials'){
                            qli2.Total__c = (gloves.Ext__c + earPlugs.Ext__c + water.Ext__c  + clean.Ext__c + tyvek.Ext__c) * legsMatShift.Total__c;
                        }
                        IF (qli2.Name__c == 'Cribbing Crew Materials'){
                            qli2.Total__c = (rainGear.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c) * cribbingMatShift.Total__c + cblock.Ext__c;
                        }
                        IF (qli2.Name__c == 'Vacuum Crew Materials'){
                            qli2.Total__c = (gloves.Ext__c + water.Ext__c) * vacuumMatShift.Total__c + vtruckWash.Ext__c;
                        }
                        //dependent on equipment                        
                        IF (qli2.Name__c == 'Pontoon Crew Equipment'){
                            qli2.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.PPE__c + flashLight.PPE__c + persH2s.Ext__c + m15.Ext__c) * quote.Pontoon_Hours__c;                                    
                        }
                        IF (qli2.Name__c == 'Wash Crew Equipment'){
                            qli2.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + 92 + M30.Ext__c + groundCable.Ext__c + gasMeter.Ext__c + vacHose.Ext__c + waterHose.Ext__c + jetPump.Ext__c + gamaJet.Ext__c + cp20.Ext__c + tankLight.Ext__c + flashLight.Ext__c + persH2s.Ext__c + m15.Ext__c) * quote.Wash_Hours__c;
                        }
                        IF (qli2.Name__c == 'HotWash Crew Equipment'){
                            qli2.Total__c =  hotPWasher.Ext__c * quote.HotWash_Hours__c; 
                        }
                        IF (qli2.Name__c == 'MOB Crew Equipment'){
                            qli2.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.Ext__c + tankLight.Ext__c + persH2s.Ext__c) * quote.MOB_Hours__c;
                        }
                        IF (qli2.Name__c == 'DeMOB Crew Equipment'){
                            qli2.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__C + cp20.Ext__c + tankLight.Ext__c + persH2s.Ext__c) * quote.DeMOB_Hours__c;
                        }
                        IF (qli2.Name__c == 'Drain Crew Equipment'){
                            qli2.Total__c = vacumTrucks.Ext__c * quote.Drain_Hours__c;
                        }
                        IF (qli2.Name__c == 'Scale Crew Equipment'){
                            qli2.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.Ext__c + tankLight.Ext__c + flashLight.Ext__c + persH2s.Ext__c) * quote.Scale_Hours__c;
                        }
                        IF (qli2.Name__c == 'Legs Crew Equipment'){
                            qli2.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.PPE__c + tankLight.Ext__c + flashLight.Ext__c + persH2s.Ext__c) * quote.Legs_Hours__c;
                        }
                        IF (qli2.Name__c == 'Cribbing Crew Equipment'){
                            qli2.Total__c = (one85Ac.Ext__c + three85Ac.Ext__c + M30.Ext__c + gasMeter.PPE__c + vacHose.PPE__c + tankLight.Ext__c + flashLight.PPE__c + persH2s.Ext__c + m15.Ext__c) * quote.Cribbing_Hours__c;                  
                        }
                        IF (qli2.Name__c == 'Vacuum Crew Equipment'){
                            qli2.Total__c = vacumTrucks.Ext__c * quote.Vac_Truck_Hours_Refined__c;                  
                        }
                        IF (qli2.Name__c == 'Bottle Wash Crew Equipment'){
                            qli2.Total__c = ((quote.Wash_Crew__c/2) * quote.Fresh_Air_Hours_Refined__c) * freshAir.Ext__c; 
                        }
                    }
                    update quoteLineItem2;
        
                }//end else refined
            }// end for(Quote_RE__c quote : Trigger.new)
            /*Quote_RE__c q = [SELECT id,Job_Type__c, Lump_Sum_Total__c,Total_Equipment_Billing__c,Total_Materials_Billing__c,
                Total_Labor_Billing__c,Rescue_Billing__c,Total_Tech_PerDiem__c,Rescue_PerDiem__c,Equipment_Hourly__c,
                Materials_Job__c,Refined_Labor__c,Degas_Support_Refined__c 
                FROM Quote_RE__c WHERE Id IN :Trigger.new];
            if(q.Job_Type__c == 'Crude'){
                q.Lump_Sum_Total__c = q.Total_Equipment_Billing__c +  q.Total_Materials_Billing__c +  q.Total_Labor_Billing__c +  q.Rescue_Billing__c + q.Total_Tech_PerDiem__c +  q.Rescue_PerDiem__c;
            }
            else{
                 q.Lump_Sum_Total__c = q.Equipment_Hourly__c +  q.Materials_Job__c +  q.Refined_Labor__c + q.Rescue_Billing__c + q.Total_Tech_PerDiem__c  + q.Degas_Support_Refined__c;          
            }
            update q;*/        
        }// endif(RecursiveTriggerHandler.insertNotDone)    
        ELSE{
            system.debug('first time run-dont need update');
        }  // end esle insert not done
    }// end  if(RecursiveTriggerHandler.isFirstTimeUpdated)
    ELSE{
        system.debug('already ran update quote items');

        return; 
    }// end else first time updated
}//end trigger