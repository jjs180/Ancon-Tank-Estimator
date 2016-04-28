trigger insertQuoteItems on Quote_RE__c (after insert ) {
    //update and insert quote line item values from custom setting
    LIST<Quote_Line_Item__c> newQuoteLineItem = new LIST<Quote_Line_Item__c>();
     for(Quote_RE__c quote : Trigger.new){
        Map<string, FX5__Price_Book_Item__c> list_PriceBookItems = new Map<string, FX5__Price_Book_Item__c>();
        for(FX5__Price_Book_Item__c pBI: [SELECT FX5__Catalog_Item_Code__c, id, Hourly__c, Hourly_Cost__c, Standard_Time__c,Over_Time__c,Standard_Time_Cost__c, FX5__Price__c, FX5__Catalog_Cost__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c]){
           list_PriceBookItems.put(pBI.FX5__Catalog_Item_Code__c, pBI);
        }
     	if(quote.Job_Type__c == 'Crude'){
	     	RecursiveTriggerHandler.insertNotDone = false;
	        //system.debug('******************************************************************************************insert done' + RecursiveTriggerHandler.insertNotDone);
	        Decimal tankDiameter = quote.Tank_Diameter__c;
	        //String locationEntered = quote.Location__c;
	       // FX5__Price_Book__c priceBook = [SELECT id, Name FROM FX5__Price_Book__c WHERE Id =: q.Price_Book__c];
	
	        REFERENCE__c baseReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'BASE')]);
	        REFERENCE__c middleReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'MID')]);
	        REFERENCE__c topReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'TOP')]);
	        //LOCATION__c location = ([SELECT id, Name, PERDIEM__c, TRAVELTIME__c, FRESHAIR__c, GASMETERS__c FROM LOCATION__c WHERE Name =: locationEntered]);
	        //Equipment data
	        
	        FX5__Price_Book_Item__c tankSweepData = list_PriceBookItems.get('ANCN_180_8IN');       
	        FX5__Price_Book_Item__c sigsData = list_PriceBookItems.get('SLDG_INJ_GLND');             
	        FX5__Price_Book_Item__c pWasherData = list_PriceBookItems.get('2.5K_PRSS_WSHR_3GPM');        
	        FX5__Price_Book_Item__c pWaterHoseData = list_PriceBookItems.get('HGH_PRSS_DSCHRG_HSE_50');                
	        FX5__Price_Book_Item__c minsData = list_PriceBookItems.get('MNWY_INJ_NZZL');                
	        FX5__Price_Book_Item__c rmcData = list_PriceBookItems.get('MNWY_CN_RMT');        
	        FX5__Price_Book_Item__c lvsData = list_PriceBookItems.get('LVS_DGAS_SYSTM');        
	        FX5__Price_Book_Item__c trashPumpData = list_PriceBookItems.get('6_TRSH_PMP');               
	        FX5__Price_Book_Item__c jetPumpData = list_PriceBookItems.get('JT_PMP');        
	        FX5__Price_Book_Item__c flangeHoseData = list_PriceBookItems.get('4_FLNG_HSE_HMMR_UNN_25');        
	        FX5__Price_Book_Item__c truckData = list_PriceBookItems.get('CRW_CB');       
	        FX5__Price_Book_Item__c supTruckData = list_PriceBookItems.get('PCKUP_TRCK');        
	        FX5__Price_Book_Item__c one85AcData = list_PriceBookItems.get('185_AIR_CMP');        
	        FX5__Price_Book_Item__c three75AcData = list_PriceBookItems.get('375_AIR_CMP');        
	        FX5__Price_Book_Item__c hotGMData = list_PriceBookItems.get('4GAS_MTR_MNTR');        
	        FX5__Price_Book_Item__c freshAirData = list_PriceBookItems.get('FRSH_AIR_SETUP_4MSK');        
	        FX5__Price_Book_Item__c airHoseData = list_PriceBookItems.get('AIR_HSE_50');        
	        FX5__Price_Book_Item__c groundCableData = list_PriceBookItems.get('GRND_CBL');        
	        FX5__Price_Book_Item__c gasMeterData = list_PriceBookItems.get('4GAS_MTR_MNTR');               
	        FX5__Price_Book_Item__c vacHoseData = list_PriceBookItems.get('VAC_HSE');        
	        FX5__Price_Book_Item__c waterHoseData = list_PriceBookItems.get('WTR_HSE_50');        
	        FX5__Price_Book_Item__c cp20Data = list_PriceBookItems.get('CP20_CPPS_BLWR');        
	        FX5__Price_Book_Item__c tankLightData = list_PriceBookItems.get('LRG_TNK_LGHT_EP');        
	        FX5__Price_Book_Item__c flashLightData = list_PriceBookItems.get('FLSHLGHT_EXP_PRF');       
	        FX5__Price_Book_Item__c persH2sData = list_PriceBookItems.get('PERS_H2S_MTR_MNTR');        
	        FX5__Price_Book_Item__c m15Data = list_PriceBookItems.get('M15_PMP');        
	        FX5__Price_Book_Item__c m30Data = list_PriceBookItems.get('M30_PMP');        
	        FX5__Price_Book_Item__c sidewayCannonData = list_PriceBookItems.get('MNWAY_CN_SD');       
	        FX5__Price_Book_Item__c vacumTrucksData = list_PriceBookItems.get('120BBL_VAC_TRCK');       
	        FX5__Price_Book_Item__c vacTruckGasMeterData = list_PriceBookItems.get('4GAS_MTR_MNTR');        
	        //system.debug('1  *********************************************************base drain hours=' + quote.Base_Drain_Hours__c + 'non-drain hours=== ' + quote.Non_Drain_Hours__c);
	            
	        Quote_Line_Item__c tankSweep = new Quote_Line_Item__c();
	            tankSweep.Quote__c = quote.id;
	            tankSweep.Name__c = 'Tank Sweep';
	            tankSweep.CP__c = tankSweepData.Hourly_Cost__c; 
	            tankSweep.BP__c = tankSweepData.Hourly__c;               
	            tankSweep.B_QTY__c = baseReference.TANKSWEEP__c;
	            tankSweep.B_HRS_QTY__c = tankSweep.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                tankSweep.M_QTY__c = middleReference.TANKSWEEP__c;
	            }
	            ELSE{
	                tankSweep.M_QTY__c = 0;
	            }
	            tankSweep.M_HRS_QTY__c = tankSweep.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                tankSweep.T_QTY__c = topReference.TANKSWEEP__c;
	            }
	            ELSE{
	                tankSweep.T_QTY__c = 0;
	            }
	            tankSweep.T_HRS_QTY__c = tankSweep.T_QTY__c * quote.Top_Drain_Hours__c;
	            tankSweep.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(tankSweep);
	         Quote_Line_Item__c sigs = new Quote_Line_Item__c();
	            sigs.Quote__c = quote.id;
	            sigs.Name__c = 'Sigs';   
	            sigs.CP__c = sigsData.Hourly_Cost__c;            
	            sigs.BP__c = sigsData.Hourly__c;              
	            sigs.B_QTY__c = baseReference.SIGS__c;
	            sigs.B_HRS_QTY__c = sigs.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                sigs.M_QTY__c = middleReference.SIGS__c;
	            }
	            ELSE{
	                sigs.M_QTY__c = 0;
	            }
	            sigs.M_HRS_QTY__c = sigs.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                sigs.T_QTY__c = topReference.SIGS__c;
	            }
	            ELSE{
	                sigs.T_QTY__c = 0;
	            }
	            sigs.T_HRS_QTY__c = sigs.T_QTY__c * quote.Top_Drain_Hours__c;
	            sigs.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(sigs);
	         Quote_Line_Item__c pWasher = new Quote_Line_Item__c();
	            pWasher.Quote__c = quote.id;
	            pWasher.Name__c = 'Pressure Washer';
	            pWasher.CP__c = pWasherData.Hourly_Cost__c; 
	            pWasher.BP__c = pWasherData.Hourly__c;               
	            pWasher.B_QTY__c = baseReference.PW__c;
	            pWasher.B_HRS_QTY__c = pWasher.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                pWasher.M_QTY__c = middleReference.PW__c;
	            }
	            ELSE{
	                pWasher.M_QTY__c = 0;
	            }
	            pWasher.M_HRS_QTY__c = pWasher.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                pWasher.T_QTY__c = topReference.PW__c;
	            }
	            ELSE{
	                pWasher.T_QTY__c = 0;
	            }
	            pWasher.T_HRS_QTY__c = pWasher.T_QTY__c * quote.Top_Drain_Hours__c;
	            pWasher.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(pWasher);           
	        Quote_Line_Item__c pWasherHose = new Quote_Line_Item__c();
	            pWasherHose.Quote__c = quote.id;
	            pWasherHose.Name__c = 'Pressure Washer Hose';
	            pWasherHose.CP__c = pWaterHoseData.Hourly_Cost__c;           
	            pWasherHose.BP__c = pWaterHoseData.Hourly__c;               
	            pWasherHose.B_QTY__c = baseReference.PWHOSE__c;
	            pWasherHose.B_HRS_QTY__c = pWasherHose.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                pWasherHose.M_QTY__c = middleReference.PWHOSE__c;
	            }
	            ELSE{
	                pWasherHose.M_QTY__c = 0;
	            }
	            pWasherHose.M_HRS_QTY__c = pWasher.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                pWasherHose.T_QTY__c = topReference.PWHOSE__c;
	            }
	            ELSE{
	                pWasherHose.T_QTY__c = 0;
	            }
	            pWasherHose.T_HRS_QTY__c = pWasherHose.T_QTY__c * quote.Top_Drain_Hours__c;
	            pWasherHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(pWasherHose);     
	       Quote_Line_Item__c mins = new Quote_Line_Item__c();
	            mins.Quote__c = quote.id;
	            mins.Name__c = 'Mins';
	            mins.CP__c = minsData.Hourly_Cost__c;                         
	            mins.BP__c = minsData.Hourly__c;               
	            mins.B_QTY__c = baseReference.MINS__c;
	            mins.B_HRS_QTY__c = mins.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                mins.M_QTY__c = middleReference.MINS__c;
	            }
	            ELSE{
	                mins.M_QTY__c = 0;
	            }
	            mins.M_HRS_QTY__c = mins.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                mins.T_QTY__c = topReference.MINS__c;
	            }
	            ELSE{
	                mins.T_QTY__c = 0;
	            }
	            mins.T_HRS_QTY__c = mins.T_QTY__c * quote.Top_Drain_Hours__c;
	            mins.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(mins);
	      Quote_Line_Item__c rmc = new Quote_Line_Item__c();
	            rmc.Quote__c = quote.id;
	            rmc.Name__c = 'RMC';
	            rmc.CP__c = rmcData.Hourly_Cost__c;  
	            rmc.BP__c = rmcData.Hourly__c;             
	            rmc.B_QTY__c = baseReference.rmc__c;
	            rmc.B_HRS_QTY__c = rmc.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                rmc.M_QTY__c = middleReference.rmc__c;
	            }
	            ELSE{
	                rmc.M_QTY__c = 0;
	            }
	            rmc.M_HRS_QTY__c = rmc.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                rmc.T_QTY__c = topReference.rmc__c;
	            }
	            ELSE{
	                rmc.T_QTY__c = 0;
	            }
	            rmc.T_HRS_QTY__c = rmc.T_QTY__c * quote.Top_Drain_Hours__c;
	            rmc.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(rmc);
	      Quote_Line_Item__c lvs = new Quote_Line_Item__c();
	            lvs.Quote__c = quote.id;
	            lvs.Name__c = 'LVS';
	            lvs.CP__c = lvsData.Hourly_Cost__c;  
	            lvs.BP__c = lvsData.Hourly__c;              
	            lvs.B_QTY__c = baseReference.lvs__c;
	            lvs.B_HRS_QTY__c = lvs.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                lvs.M_QTY__c = middleReference.lvs__c;
	            }
	            ELSE{
	                lvs.M_QTY__c = 0;
	            }
	            lvs.M_HRS_QTY__c = lvs.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                lvs.T_QTY__c = topReference.lvs__c;
	            }
	            ELSE{
	                lvs.T_QTY__c = 0;
	            }
	            lvs.T_HRS_QTY__c = lvs.T_QTY__c * quote.Top_Drain_Hours__c;
	            lvs.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(lvs);
	      Quote_Line_Item__c trashPump = new Quote_Line_Item__c();
	            trashPump.Quote__c = quote.id;
	            trashPump.Name__c = 'Trash Pump';
	            trashPump.CP__c = trashPumpData.Hourly_Cost__c; 	      
	            trashPump.BP__c = trashPumpData.Hourly__c;              
	            trashPump.B_QTY__c = baseReference.trashPump__c;
	            trashPump.B_HRS_QTY__c = trashPump.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                trashPump.M_QTY__c = middleReference.trashPump__c;
	            }
	            ELSE{
	                trashPump.M_QTY__c = 0;
	            }
	            trashPump.M_HRS_QTY__c = trashPump.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                trashPump.T_QTY__c = topReference.trashPump__c;
	            }
	            ELSE{
	                trashPump.T_QTY__c = 0;
	            }
	            trashPump.T_HRS_QTY__c = trashPump.T_QTY__c * quote.Top_Drain_Hours__c;
	            trashPump.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(trashPump);
	       Quote_Line_Item__c jetPump = new Quote_Line_Item__c();
	            jetPump.Quote__c = quote.id;
	            jetPump.Name__c = 'Jet Pump';
	            jetPump.CP__c = jetPumpData.Hourly_Cost__c;  
	            jetPump.BP__c = jetPumpData.Hourly__c;               
	            jetPump.B_QTY__c = baseReference.jetPump__c;
	            jetPump.B_HRS_QTY__c = jetPump.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                jetPump.M_QTY__c = middleReference.jetPump__c;
	            }
	            ELSE{
	                jetPump.M_QTY__c = 0;
	            }
	            jetPump.M_HRS_QTY__c = jetPump.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                jetPump.T_QTY__c = topReference.jetPump__c;
	            }
	            ELSE{
	                jetPump.T_QTY__c = 0;
	            }
	            jetPump.T_HRS_QTY__c = jetPump.T_QTY__c * quote.Top_Drain_Hours__c;
	            jetPump.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(jetPump);
	      Quote_Line_Item__c flangeHose = new Quote_Line_Item__c();
	            flangeHose.Quote__c = quote.id;
	            flangeHose.Name__c = 'Flange Hose';
	            flangeHose.CP__c = flangeHoseData.Hourly_Cost__c; 
	            flangeHose.BP__c = flangeHoseData.Hourly__c;               
	            flangeHose.B_QTY__c = baseReference.flangeHose__c;
	            flangeHose.B_HRS_QTY__c = flangeHose.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                flangeHose.M_QTY__c = middleReference.flangeHose__c;
	            }
	            ELSE{
	                flangeHose.M_QTY__c = 0;
	            }
	            flangeHose.M_HRS_QTY__c = flangeHose.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                flangeHose.T_QTY__c = topReference.flangeHose__c;
	            }
	            ELSE{
	                flangeHose.T_QTY__c = 0;
	            }
	            flangeHose.T_HRS_QTY__c = flangeHose.T_QTY__c * quote.Top_Drain_Hours__c;
	            flangeHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(flangeHose);
	       Quote_Line_Item__c truck = new Quote_Line_Item__c();
	            truck.Quote__c = quote.id;
	            truck.Name__c = 'Truck';
	            truck.CP__c = truckData.Hourly_Cost__c; 
	            truck.BP__c = truckData.Hourly__c;               
	            truck.B_QTY__c = baseReference.truck__c;
	            truck.B_HRS_QTY__c = truck.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                truck.M_QTY__c = middleReference.truck__c;
	            }
	            ELSE{
	                truck.M_QTY__c = 0;
	            }
	            truck.M_HRS_QTY__c = truck.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                truck.T_QTY__c = topReference.truck__c;
	            }
	            ELSE{
	                truck.T_QTY__c = 0;
	            }
	            truck.T_HRS_QTY__c = truck.T_QTY__c * quote.Top_Drain_Hours__c;
	            truck.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(truck);
	       Quote_Line_Item__c supTruck = new Quote_Line_Item__c();
	            supTruck.Quote__c = quote.id;
	            supTruck.Name__c = 'Sup Truck';
	            supTruck.CP__c = supTruckData.Hourly_Cost__c; 
	            supTruck.BP__c = supTruckData.Hourly__c;              
	            supTruck.B_QTY__c = baseReference.supTruck__c;
	            supTruck.B_HRS_QTY__c = supTruck.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                supTruck.M_QTY__c = middleReference.supTruck__c;
	            }
	            ELSE{
	                supTruck.M_QTY__c = 0;
	            }
	            supTruck.M_HRS_QTY__c = supTruck.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                supTruck.T_QTY__c = topReference.supTruck__c;
	            }
	            ELSE{
	                supTruck.T_QTY__c = 0;
	            }
	            supTruck.T_HRS_QTY__c = supTruck.T_QTY__c * quote.Top_Drain_Hours__c;
	            supTruck.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(supTruck);
	        Quote_Line_Item__c one85Ac = new Quote_Line_Item__c();
	            one85Ac.Quote__c = quote.id;
	            one85Ac.Name__c = '185 Air Compressor';
	            one85Ac.CP__c = one85AcData.Hourly_Cost__c; 
	            one85Ac.BP__c = one85AcData.Hourly__c;                
	            one85Ac.B_QTY__c = baseReference.X185Ac__c;
	            one85Ac.B_HRS_QTY__c = one85AC.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                one85Ac.M_QTY__c = middleReference.X185Ac__c;
	            }
	            ELSE{
	                one85Ac.M_QTY__c = 0;
	            }
	            one85Ac.M_HRS_QTY__c = one85AC.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                one85Ac.T_QTY__c = topReference.X185Ac__c;
	            }
	            ELSE{
	                one85Ac.T_QTY__c = 0;
	            }
	            one85Ac.T_HRS_QTY__c = one85Ac.T_QTY__c * quote.Top_Drain_Hours__c;
	            one85Ac.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(one85Ac);
	        Quote_Line_Item__c three75Ac = new Quote_Line_Item__c();
	            three75Ac.Quote__c = quote.id;
	            three75Ac.Name__c = '375 Air Compressor';
	            three75Ac.CP__c = three75AcData.Hourly_Cost__c;  
	            three75Ac.BP__c = three75AcData.Hourly__c;              
	            three75Ac.B_QTY__c = baseReference.X375Ac__c;
	            three75Ac.B_HRS_QTY__c = three75Ac.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                three75Ac.M_QTY__c = middleReference.X375Ac__c;
	            }
	            ELSE{
	                three75Ac.M_QTY__c = 0;
	            }
	            three75Ac.M_HRS_QTY__c = three75Ac.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                three75Ac.T_QTY__c = topReference.X375Ac__c;
	            }
	            ELSE{
	                three75Ac.T_QTY__c = 0;
	            }
	            three75Ac.T_HRS_QTY__c = three75Ac.T_QTY__c * quote.Top_Drain_Hours__c;
	            three75Ac.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(three75Ac);
	        Quote_Line_Item__c hotGM = new Quote_Line_Item__c();
	            hotGM.Quote__c = quote.id;
	            hotGM.Name__c = 'Hot GM';
	            hotGM.CP__c = hotGMData.Hourly_Cost__c; 
	            hotGM.BP__c = hotGMData.Hourly__c;               
	            hotGM.B_QTY__c = baseReference.hotGM__c;
	            hotGM.B_HRS_QTY__c = hotGM.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                hotGM.M_QTY__c = middleReference.hotGM__c;
	            }
	            ELSE{
	                hotGM.M_QTY__c = 0;
	            }
	            hotGM.M_HRS_QTY__c = hotGM.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                hotGM.T_QTY__c = topReference.hotGM__c;
	            }
	            ELSE{
	                hotGM.T_QTY__c = 0;
	            }
	            hotGM.T_HRS_QTY__c = hotGM.T_QTY__c * quote.Top_Drain_Hours__c;
	            hotGM.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(hotGM);
	        Quote_Line_Item__c freshAir = new Quote_Line_Item__c();
	            freshAir.Quote__c = quote.id;
	            freshAir.Name__c = 'Fresh Air';
	            freshAir.CP__c = freshAirData.Hourly_Cost__c; 
	            freshAir.BP__c = freshAirData.Hourly__c;               
	            freshAir.B_QTY__c = baseReference.Fresh__c;
	            freshAir.B_HRS_QTY__c = quote.Fresh_Air_Hours__c;
	            freshAir.M_QTY__c = 0;
	            freshAir.M_HRS_QTY__c = freshAir.M_QTY__c * quote.Fresh_Air_Hours__c;
	            freshAir.T_QTY__c = 0;           
	            freshAir.T_HRS_QTY__c = freshAir.T_QTY__c * quote.Top_Drain_Hours__c;
	            freshAir.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(freshAir);
	       Quote_Line_Item__c airHose = new Quote_Line_Item__c();
	            airHose.Quote__c = quote.id;
	            airHose.Name__c = 'Air Hose';
	            airHose.CP__c = airHoseData.Hourly_Cost__c;  
	            airHose.BP__c = airHoseData.Hourly__c;               
	            airHose.B_QTY__c = baseReference.AHose__c;
	            airHose.B_HRS_QTY__c = airHose.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                airHose.M_QTY__c = middleReference.AHose__c;
	            }
	            ELSE{
	                airHose.M_QTY__c = 0;
	            }
	            airHose.M_HRS_QTY__c = airHose.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                airHose.T_QTY__c = topReference.AHose__c;
	            }
	            ELSE{
	                airHose.T_QTY__c = 0;
	            }
	            airHose.T_HRS_QTY__c = airHose.T_QTY__c * quote.Top_Drain_Hours__c;
	            airHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(airHose);
	        Quote_Line_Item__c groundCable = new Quote_Line_Item__c();
	            groundCable.Quote__c = quote.id;
	            groundCable.Name__c = 'Ground Cable';
	            groundCable.CP__c = groundCableData.Hourly_Cost__c;  
	            groundCable.BP__c = groundCableData.Hourly__c;             
	            groundCable.B_QTY__c = baseReference.ground__c;
	            groundCable.B_HRS_QTY__c = groundCable.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                groundCable.M_QTY__c = middleReference.ground__c;
	            }
	            ELSE{
	                groundCable.M_QTY__c = 0;
	            }
	            groundCable.M_HRS_QTY__c = groundCable.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                groundCable.T_QTY__c = topReference.ground__c;
	            }
	            ELSE{
	                groundCable.T_QTY__c = 0;
	            }
	            groundCable.T_HRS_QTY__c = groundCable.T_QTY__c * quote.Top_Drain_Hours__c;
	            groundCable.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(groundCable);
	        Quote_Line_Item__c gasMeter = new Quote_Line_Item__c();
	            gasMeter.Quote__c = quote.id;
	            gasMeter.Name__c = 'Gas Meter';
	            gasMeter.CP__c = gasMeterData.Hourly_Cost__c;  
	            gasMeter.BP__c = gasMeterData.Hourly__c;                
	            gasMeter.B_QTY__c = baseReference.gasMeter__c;
	            IF (quote.Gas_Meters__c == True){
	            	gasMeter.B_HRS_QTY__c = gasMeter.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
	            }
	            ELSE{
	            	gasMeter.B_HRS_QTY__c = 0;
	            }
	            IF(quote.Total_Inches_Remain__c >= 19){
	                gasMeter.M_QTY__c = middleReference.gasMeter__c;
	            }
	            ELSE{
	                gasMeter.M_QTY__c = 0;
	            }
	            IF (quote.Gas_Meters__c == TRUE){
	            	gasMeter.M_HRS_QTY__c = quote.Middle_Drain_Hours__c * gasMeter.M_QTY__c;
	            }
	            ELSE{
	            	gasMeter.M_HRS_QTY__c = 0;
	            }
	            IF(quote.Total_Inches_Remain__c >= 67){
	                gasMeter.T_QTY__c = topReference.gasMeter__c;
	            }
	            ELSE{
	                gasMeter.T_QTY__c = 0;
	            }
	            IF (quote.Gas_Meters__c == TRUE){
	            	gasMeter.T_HRS_QTY__c = gasMeter.T_QTY__c * quote.Top_Drain_Hours__c;
	            }
	            ELSE{
	            	gasMeter.T_HRS_QTY__c = 0;
	            }
	            gasMeter.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(gasMeter);
	        Quote_Line_Item__c vacHose = new Quote_Line_Item__c();
	            vacHose.Quote__c = quote.id;
	            vacHose.Name__c = 'Vac Hose';
	            vacHose.CP__c = vacHoseData.Hourly_Cost__c; 
	            vacHose.BP__c = vacHoseData.Hourly__c;              
	            vacHose.B_QTY__c = baseReference.vacHose__c;
	            vacHose.B_HRS_QTY__c = vacHose.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                vacHose.M_QTY__c = middleReference.vacHose__c;
	            }
	            ELSE{
	                vacHose.M_QTY__c = 0;
	            }
	            vacHose.M_HRS_QTY__c = vacHose.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                vacHose.T_QTY__c = topReference.vacHose__c;
	            }
	            ELSE{
	                vacHose.T_QTY__c = 0;
	            }
	            vacHose.T_HRS_QTY__c = vacHose.T_QTY__c * quote.Top_Drain_Hours__c;
	            vacHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(vacHose);
	        Quote_Line_Item__c waterHose = new Quote_Line_Item__c();
	            waterHose.Quote__c = quote.id;
	            waterHose.Name__c = 'Water Hose';
	            waterHose.CP__c = waterHoseData.Hourly_Cost__c;   
	            waterHose.BP__c = waterHoseData.Hourly__c;              
	            waterHose.B_QTY__c = baseReference.WHose__c;
	            waterHose.B_HRS_QTY__c = waterHose.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                waterHose.M_QTY__c = middleReference.WHose__c;
	            }
	            ELSE{
	                waterHose.M_QTY__c = 0;
	            }
	            waterHose.M_HRS_QTY__c = waterHose.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                waterHose.T_QTY__c = topReference.WHose__c;
	            }
	            ELSE{
	                waterHose.T_QTY__c = 0;
	            }
	            waterHose.T_HRS_QTY__c = waterHose.T_QTY__c * quote.Top_Drain_Hours__c;
	            waterHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(waterHose);
	        Quote_Line_Item__c cp20 = new Quote_Line_Item__c();
	            cp20.Quote__c = quote.id;
	            cp20.Name__c = 'CP20';
	            cp20.CP__c = cp20Data.Hourly_Cost__c; 
	            cp20.BP__c = cp20Data.Hourly__c;               
	            cp20.B_QTY__c = baseReference.cp20__c;
	            cp20.B_HRS_QTY__c = cp20.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                cp20.M_QTY__c = middleReference.cp20__c;
	            }
	            ELSE{
	                cp20.M_QTY__c = 0;
	            }
	            cp20.M_HRS_QTY__c = cp20.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                cp20.T_QTY__c = topReference.cp20__c;
	            }
	            ELSE{
	                cp20.T_QTY__c = 0;
	            }
	            cp20.T_HRS_QTY__c = cp20.T_QTY__c * quote.Top_Drain_Hours__c;
	            cp20.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(cp20);
	        Quote_Line_Item__c tankLight = new Quote_Line_Item__c();
	            tankLight.Quote__c = quote.id;
	            tankLight.Name__c = 'Tank Light';
	            tankLight.CP__c = tankLightData.Hourly_Cost__c;      
	            tankLight.BP__c = tankLightData.Hourly__c;          
	            tankLight.B_QTY__c = baseReference.TLight__c;
	            tankLight.B_HRS_QTY__c = tankLight.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                tankLight.M_QTY__c = middleReference.TLight__c;
	            }
	            ELSE{
	                tankLight.M_QTY__c = 0;
	            }
	            tankLight.M_HRS_QTY__c = tankLight.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                tankLight.T_QTY__c = topReference.TLight__c;
	            }
	            ELSE{
	                tankLight.T_QTY__c = 0;
	            }
	            tankLight.T_HRS_QTY__c = tankLight.T_QTY__c * quote.Top_Drain_Hours__c;
	            tankLight.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(tankLight);
	         Quote_Line_Item__c flashLight = new Quote_Line_Item__c();
	            flashLight.Quote__c = quote.id;
	            flashLight.Name__c = 'Flash Light';
	            flashLight.CP__c = flashLightData.Hourly_Cost__c;  
	            flashLight.BP__c = flashLightData.Hourly__c;             
	            flashLight.B_QTY__c = baseReference.FLight__c;
	            flashLight.B_HRS_QTY__c = flashLight.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                flashLight.M_QTY__c = middleReference.FLight__c;
	            }
	            ELSE{
	                flashLight.M_QTY__c = 0;
	            }
	            flashLight.M_HRS_QTY__c = flashLight.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                flashLight.T_QTY__c = topReference.FLight__c;
	            }
	            ELSE{
	                flashLight.T_QTY__c = 0;
	            }
	            flashLight.T_HRS_QTY__c = flashLight.T_QTY__c * quote.Top_Drain_Hours__c;
	            flashLight.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(flashLight);
	        Quote_Line_Item__c persH2s = new Quote_Line_Item__c();
	            persH2s.Quote__c = quote.id;
	            persH2s.Name__c = 'Personell H2S';
	            persH2s.CP__c = persH2sData.Hourly_Cost__c;    
	            persH2s.BP__c = persH2sData.Hourly__c;             
	            persH2s.B_QTY__c = baseReference.H2s__c;
	            persH2s.B_HRS_QTY__c = persH2s.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                persH2s.M_QTY__c = middleReference.H2s__c;
	            }
	            ELSE{
	                persH2s.M_QTY__c = 0;
	            }
	            persH2s.M_HRS_QTY__c = persH2s.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                persH2s.T_QTY__c = topReference.H2s__c;
	            }
	            ELSE{
	                persH2s.T_QTY__c = 0;
	            }
	            persH2s.T_HRS_QTY__c = persH2s.T_QTY__c * quote.Top_Drain_Hours__c;
	            persH2s.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(persH2s);
	        Quote_Line_Item__c m15 = new Quote_Line_Item__c();
	            m15.Quote__c = quote.id;
	            m15.Name__c = 'M15';
	            m15.CP__c = m15Data.Hourly_Cost__c;   
	            m15.BP__c = m15Data.Hourly__c;             
	            m15.B_QTY__c = baseReference.m15__c;
	            m15.B_HRS_QTY__c = m15.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                m15.M_QTY__c = middleReference.m15__c;
	            }
	            ELSE{
	                m15.M_QTY__c = 0;
	            }
	            m15.M_HRS_QTY__c = m15.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                m15.T_QTY__c = topReference.m15__c;
	            }
	            ELSE{
	                m15.T_QTY__c = 0;
	            }
	            m15.T_HRS_QTY__c = m15.T_QTY__c * quote.Top_Drain_Hours__c;
	            m15.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(m15);
	        Quote_Line_Item__c m30 = new Quote_Line_Item__c();
	            m30.Quote__c = quote.id;
	            m30.Name__c = 'M30';
	            m30.CP__c = m30Data.Hourly_Cost__c;    
	            m30.BP__c = m30Data.Hourly__c;            
	            m30.B_QTY__c = baseReference.m30__c;
	            m30.B_HRS_QTY__c = m30.B_QTY__c * (quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                m30.M_QTY__c = middleReference.m30__c;
	            }
	            ELSE{
	                m30.M_QTY__c = 0;
	            }
	            m30.M_HRS_QTY__c = m30.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                m30.T_QTY__c = topReference.m30__c;
	            }
	            ELSE{
	                m30.T_QTY__c = 0;
	            }
	            m30.T_HRS_QTY__c = m30.T_QTY__c * quote.Top_Drain_Hours__c;
	            m30.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(m30);
	        Quote_Line_Item__c sidewayCannon = new Quote_Line_Item__c();
	            sidewayCannon.Quote__c = quote.id;
	            sidewayCannon.Name__c = 'Sideway Cannon';
	            sidewayCannon.CP__c = sidewayCannonData.Hourly_Cost__c; 
	            sidewayCannon.BP__c = sidewayCannonData.Hourly__c;              
	            sidewayCannon.B_QTY__c = baseReference.SCanon__c;
	            sidewayCannon.B_HRS_QTY__c = sidewayCannon.B_QTY__c * quote.Base_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                sidewayCannon.M_QTY__c = middleReference.SCanon__c;
	            }
	            ELSE{
	                sidewayCannon.M_QTY__c = 0;
	            }
	            sidewayCannon.M_HRS_QTY__c = sidewayCannon.M_QTY__c * quote.Middle_Drain_Hours__c;
	            IF(quote.Total_Inches_Remain__c >= 67){
	                sidewayCannon.T_QTY__c = topReference.SCanon__c;
	            }
	            ELSE{
	                sidewayCannon.T_QTY__c = 0;
	            }
	            sidewayCannon.T_HRS_QTY__c = sidewayCannon.T_QTY__c * quote.Top_Drain_Hours__c;
	            sidewayCannon.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(sidewayCannon);
	        Quote_Line_Item__c vacumTrucks = new Quote_Line_Item__c();
	            vacumTrucks.Quote__c = quote.id;
	            vacumTrucks.Name__c = 'Vacum Trucks';
	            vacumTrucks.CP__c = vacumTrucksData.Hourly_Cost__c;   
	            vacumTrucks.BP__c = vacumTrucksData.Hourly__c;             
	            vacumTrucks.B_QTY__c = quote.Vacum_Trucks__c;
	            vacumTrucks.B_HRS_QTY__c = vacumTrucks.B_QTY__c * quote.Vac_Truck_Hours__c;
				vacumTrucks.M_QTY__c = quote.Vacum_Trucks__c;
	            vacumTrucks.M_HRS_QTY__c = vacumTrucks.M_QTY__c * quote.Vac_Truck_Hours__c;
	            vacumTrucks.T_QTY__c = quote.Vacum_Trucks__c;           
	            vacumTrucks.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(vacumTrucks);
	        Quote_Line_Item__c vacTruckGasMeter = new Quote_Line_Item__c();
	            vacTruckGasMeter.Quote__c = quote.id;
	            vacTruckGasMeter.Name__c = 'Vac Truck Gas Meter';
	            vacTruckGasMeter.CP__c = vacTruckGasMeterData.Hourly_Cost__c;  
	            vacTruckGasMeter.BP__c = vacTruckGasMeterData.Hourly__c;              
	            vacTruckGasMeter.B_QTY__c = quote.Vacum_Trucks__c;
	            IF (quote.Gas_Meters__c == TRUE){
	            	vacTruckGasMeter.B_HRS_QTY__c = vacumTrucks.B_QTY__c * quote.Vac_Truck_Hours__c;
	            }
	            ELSE{
	            	vacTruckGasMeter.B_HRS_QTY__c = 0;
	            }            
				vacTruckGasMeter.M_QTY__c = quote.Vacum_Trucks__c;
	            vacTruckGasMeter.M_HRS_QTY__c = 0;
	            vacTruckGasMeter.T_QTY__c = quote.Vacum_Trucks__c;
	            vacTruckGasMeter.T_HRS_QTY__c = 0;
	            vacTruckGasMeter.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(vacTruckGasMeter);
	        
	        //Materials data
	        FX5__Price_Book_Item__c tyvekData = list_PriceBookItems.get('TYVEK');        
	        FX5__Price_Book_Item__c plasticData = list_PriceBookItems.get('20_VSQN_PLSTC_RLL_100');        
        	FX5__Price_Book_Item__c respData = list_PriceBookItems.get('RESP_FLL_FAC');        
	        FX5__Price_Book_Item__c glovesData = list_PriceBookItems.get('PVC_GLV');        
	        FX5__Price_Book_Item__c PlugsData = list_PriceBookItems.get('EAR_PLG_FM');        
	        FX5__Price_Book_Item__c waterData = list_PriceBookItems.get('DRNK_WTR');        
	        FX5__Price_Book_Item__c poolData = list_PriceBookItems.get('DCN_LG_POOL');        
	        FX5__Price_Book_Item__c bagsData = list_PriceBookItems.get('PLSTC_BG_30X40');        
	        FX5__Price_Book_Item__c cleanData = list_PriceBookItems.get('HND_CLNR');       
	        FX5__Price_Book_Item__c tapeData = list_PriceBookItems.get('DUCT_TAPE');        
	        FX5__Price_Book_Item__c hornData = list_PriceBookItems.get('PRTBL_AIR_HRN');        
	        FX5__Price_Book_Item__c ragsData = list_PriceBookItems.get('RAGS_BX');        
	        FX5__Price_Book_Item__c rgData = list_PriceBookItems.get('RN_GR_FRC');        
	        FX5__Price_Book_Item__c cblockData = list_PriceBookItems.get('CRIB_BLCKS');       
	        FX5__Price_Book_Item__c respCartData = list_PriceBookItems.get('RESP_RPLC_CART');       
	        FX5__Price_Book_Item__c vtruckWashData = list_PriceBookItems.get('HT_WTR_WSHOUT');
	                
	        Quote_Line_Item__c tyvek = new Quote_Line_Item__c();
	            tyvek.Quote__c = quote.id;
	            tyvek.Name__c = 'Tyvek';
	            tyvek.CP__c = tyvekData.FX5__Catalog_Cost__c; 
	            tyvek.BP__c = tyvekData.FX5__Price__c;               
	            tyvek.B_QTY__c = baseReference.TYVEK__c;
	            tyvek.B_Job_QTY__c = tyvek.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                tyvek.M_QTY__c = middleReference.TYVEK__c;
	            }
	            ELSE{
	                tyvek.M_QTY__c = 0;
	            }
	            tyvek.M_Job_QTY__c = tyvek.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	tyvek.T_QTY__c = topReference.TYVEK__c;
				}
				ELSE{
					tyvek.T_QTY__c = 0;
				}
	            tyvek.T_Job_QTY__c = tyvek.T_QTY__c * quote.Top_Shifts__c;
	            tyvek.Type__c = 'Materials';                   
	            newQuoteLineItem.add(tyvek);
	       Quote_Line_Item__c plastic = new Quote_Line_Item__c();
	            plastic.Quote__c = quote.id;
	            plastic.Name__c = 'Plastic';
	            plastic.CP__c = plasticData.FX5__Catalog_Cost__c; 
	            plastic.BP__c = plasticData.FX5__Price__c;              
	            plastic.B_QTY__c = baseReference.PLASTIC__c;
	            plastic.B_Job_QTY__c = baseReference.PLASTIC__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                plastic.M_QTY__c = middleReference.PLASTIC__c;
	            }
	            ELSE{
	                plastic.M_QTY__c = 0;
	            }
	            IF(quote.Total_Inches_Remain__c>19){
	            	plastic.M_Job_QTY__c = middleReference.PLASTIC__c;
	            }
	            ELSE{
	            	plastic.M_Job_QTY__c = 0;
	            }           
				IF(quote.Total_Inches_Remain__c>67){
	            	plastic.T_QTY__c = topReference.PLASTIC__c;
				}
				ELSE{
					plastic.T_QTY__c = 0;
				}
				IF(quote.Total_Inches_Remain__c>67){
	            	plastic.T_Job_QTY__c = topReference.PLASTIC__c;
				}
				ELSE{
					plastic.T_Job_QTY__c = 0;
				}
	            plastic.Type__c = 'Materials';                   
	            newQuoteLineItem.add(plastic);        
	       Quote_Line_Item__c resp = new Quote_Line_Item__c();
	            resp.Quote__c = quote.id;
	            resp.Name__c = 'Respirators';
	            resp.CP__c = respData.FX5__Catalog_Cost__c; 
	            resp.BP__c = respData.FX5__Price__c;               
	            resp.B_QTY__c = baseReference.resp__c;
	            resp.B_Job_QTY__c = resp.B_QTY__c * quote.Base_Shifts__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                resp.M_QTY__c = middleReference.resp__c;
	            }
	            ELSE{
	                resp.M_QTY__c = 0;
	            }
	            resp.M_Job_QTY__c = resp.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	resp.T_QTY__c = topReference.resp__c;
				}
				ELSE{
					resp.T_QTY__c = 0;
				}
	            resp.T_Job_QTY__c = resp.T_QTY__c * quote.Top_Shifts__c;
	            resp.Type__c = 'Materials';                   
	            newQuoteLineItem.add(resp);     
	       Quote_Line_Item__c gloves = new Quote_Line_Item__c();
	            gloves.Quote__c = quote.id;
	            gloves.Name__c = 'Gloves';
	            gloves.CP__c = glovesData.FX5__Catalog_Cost__c; 
	            gloves.BP__c = glovesData.FX5__Price__c;               
	            gloves.B_QTY__c = baseReference.gloves__c;
	            gloves.B_Job_QTY__c = gloves.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                gloves.M_QTY__c = middleReference.gloves__c;
	            }
	            ELSE{
	                gloves.M_QTY__c = 0;
	            }
	            gloves.M_Job_QTY__c = gloves.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	gloves.T_QTY__c = topReference.gloves__c;
				}
				ELSE{
					gloves.T_QTY__c = 0;
				}
	            gloves.T_Job_QTY__c = gloves.T_QTY__c * quote.Top_Shifts__c;
	            gloves.Type__c = 'Materials';                   
	            newQuoteLineItem.add(gloves);     
	      Quote_Line_Item__c plugs = new Quote_Line_Item__c();
	            plugs.Quote__c = quote.id;
	            plugs.Name__c = 'Ear Plugs';
	            plugs.CP__c = plugsData.FX5__Catalog_Cost__c; 
	            plugs.BP__c = plugsData.FX5__Price__c;               
	            plugs.B_QTY__c = baseReference.plugs__c;
	            plugs.B_Job_QTY__c = plugs.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                plugs.M_QTY__c = middleReference.plugs__c;
	            }
	            ELSE{
	                plugs.M_QTY__c = 0;
	            }
	            plugs.M_Job_QTY__c = plugs.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	plugs.T_QTY__c = topReference.plugs__c;
				}
				ELSE{
					plugs.T_QTY__c = 0;
				}
	            plugs.T_Job_QTY__c = plugs.T_QTY__c * quote.Top_Shifts__c;
	            plugs.Type__c = 'Materials';                   
	            newQuoteLineItem.add(plugs);     
	      Quote_Line_Item__c water = new Quote_Line_Item__c();
	            water.Quote__c = quote.id;
	            water.Name__c = 'Water';
	            water.CP__c = waterData.FX5__Catalog_Cost__c; 
	            water.BP__c = waterData.FX5__Price__c;              
	            water.B_QTY__c = baseReference.water__c;
	            water.B_Job_QTY__c = water.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                water.M_QTY__c = middleReference.water__c;
	            }
	            ELSE{
	                water.M_QTY__c = 0;
	            }
	            water.M_Job_QTY__c = water.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	water.T_QTY__c = topReference.water__c;
				}
				ELSE{
					water.T_QTY__c = 0;
				}
	            water.T_Job_QTY__c = water.T_QTY__c * quote.Top_Shifts__c;
	            water.Type__c = 'Materials';                   
	            newQuoteLineItem.add(water);     
	      Quote_Line_Item__c pool = new Quote_Line_Item__c();
	            pool.Quote__c = quote.id;
	            pool.Name__c = 'Kitty Pools';
	            pool.CP__c = poolData.FX5__Catalog_Cost__c; 
	            pool.BP__c = poolData.FX5__Price__c;            
	            pool.B_QTY__c = baseReference.pool__c;
	            pool.B_Job_QTY__c = pool.B_QTY__c * quote.Base_Shifts__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                pool.M_QTY__c = middleReference.pool__c;
	            }
	            ELSE{
	                pool.M_QTY__c = 0;
	            }
	            pool.M_Job_QTY__c = pool.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	pool.T_QTY__c = topReference.pool__c;
				}
				ELSE{
					pool.T_QTY__c = 0;
				}
	            pool.T_Job_QTY__c = pool.T_QTY__c * quote.Top_Shifts__c;
	            pool.Type__c = 'Materials';                   
	            newQuoteLineItem.add(pool);      
	      Quote_Line_Item__c bags = new Quote_Line_Item__c();
	            bags.Quote__c = quote.id;
	            bags.Name__c = 'Plastic Bags';
	            bags.CP__c = bagsData.FX5__Catalog_Cost__c; 
	            bags.BP__c = bagsData.FX5__Price__c;               
	            bags.B_QTY__c = baseReference.bags__c;
	            bags.B_Job_QTY__c = bags.B_QTY__c * quote.Base_Shifts__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                bags.M_QTY__c = middleReference.bags__c;
	            }
	            ELSE{
	                bags.M_QTY__c = 0;
	            }
	            bags.M_Job_QTY__c = bags.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	bags.T_QTY__c = topReference.bags__c;
				}
				ELSE{
					bags.T_QTY__c = 0;
				}
	            bags.T_Job_QTY__c = bags.T_QTY__c * quote.Top_Shifts__c;
	            bags.Type__c = 'Materials';                   
	            newQuoteLineItem.add(bags);     
	      Quote_Line_Item__c clean = new Quote_Line_Item__c();
	            clean.Quote__c = quote.id;
	            clean.Name__c = 'Hand Cleaner';
	            clean.CP__c = cleanData.FX5__Catalog_Cost__c; 
	            clean.BP__c = cleanData.FX5__Price__c;              
	            clean.B_QTY__c = baseReference.clean__c;
	            clean.B_Job_QTY__c = clean.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                clean.M_QTY__c = middleReference.clean__c;
	            }
	            ELSE{
	                clean.M_QTY__c = 0;
	            }
	            clean.M_Job_QTY__c = clean.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	clean.T_QTY__c = topReference.clean__c;
				}
				ELSE{
					clean.T_QTY__c = 0;
				}
	            clean.T_Job_QTY__c = clean.T_QTY__c * quote.Top_Shifts__c;
	            clean.Type__c = 'Materials';                   
	            newQuoteLineItem.add(clean);   
		  Quote_Line_Item__c tape = new Quote_Line_Item__c();
	            tape.Quote__c = quote.id;
	            tape.Name__c = 'Duct Tape';
	            tape.CP__c = tapeData.FX5__Catalog_Cost__c; 
	            tape.BP__c = tapeData.FX5__Price__c;               
	            tape.B_QTY__c = baseReference.tape__c;
	            tape.B_Job_QTY__c = tape.B_QTY__c *(quote.Base_Shifts__c + quote.Non_Drain_Shifts__c);
	            IF(quote.Total_Inches_Remain__c >= 19){
	                tape.M_QTY__c = middleReference.tape__c;
	            }
	            ELSE{
	                tape.M_QTY__c = 0;
	            }
	            tape.M_Job_QTY__c = tape.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	tape.T_QTY__c = topReference.tape__c;
				}
				ELSE{
					tape.T_QTY__c = 0;
				}
	            tape.T_Job_QTY__c = tape.T_QTY__c * quote.Top_Shifts__c;
	            tape.Type__c = 'Materials';                   
	            newQuoteLineItem.add(tape);        
	       Quote_Line_Item__c horn = new Quote_Line_Item__c();
	            horn.Quote__c = quote.id;
	            horn.Name__c = 'Air Horn';
	            horn.CP__c = hornData.FX5__Catalog_Cost__c; 
	            horn.BP__c = hornData.FX5__Price__c;              
	            horn.B_QTY__c = baseReference.horn__c;
	            horn.B_Job_QTY__c = horn.B_QTY__c * quote.Base_Shifts__c ;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                horn.M_QTY__c = middleReference.horn__c;
	            }
	            ELSE{
	                horn.M_QTY__c = 0;
	            }
	            horn.M_Job_QTY__c = horn.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	horn.T_QTY__c = topReference.horn__c;
				}
				ELSE{
					horn.T_QTY__c = 0;
				}
	            horn.T_Job_QTY__c = horn.T_QTY__c * quote.Top_Shifts__c;
	            horn.Type__c = 'Materials';                   
	            newQuoteLineItem.add(horn);
	         Quote_Line_Item__c rags = new Quote_Line_Item__c();
	            rags.Quote__c = quote.id;
	            rags.Name__c = 'Rags';
	            rags.CP__c = ragsData.FX5__Catalog_Cost__c; 
	            rags.BP__c = ragsData.FX5__Price__c;               
	            rags.B_QTY__c = baseReference.rags__c;
	            rags.B_Job_QTY__c = rags.B_QTY__c * quote.Base_Shifts__c ;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                rags.M_QTY__c = middleReference.rags__c;
	            }
	            ELSE{
	                rags.M_QTY__c = 0;
	            }
	            rags.M_Job_QTY__c = rags.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	rags.T_QTY__c = topReference.rags__c;
				}
				ELSE{
					rags.T_QTY__c = 0;
				}
	            rags.T_Job_QTY__c = rags.T_QTY__c * quote.Top_Shifts__c;
	            rags.Type__c = 'Materials';                   
	            newQuoteLineItem.add(rags);
	       Quote_Line_Item__c rg = new Quote_Line_Item__c();
	            rg.Quote__c = quote.id;
	            rg.Name__c = 'Rain Gear';
	            rg.CP__c = rgData.FX5__Catalog_Cost__c; 
	            rg.BP__c = rgData.FX5__Price__c;               
	            rg.B_QTY__c = baseReference.rg__c;
	            rg.B_Job_QTY__c = rg.B_QTY__c * quote.Base_Shifts__c ;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                rg.M_QTY__c = middleReference.rg__c;
	            }
	            ELSE{
	                rg.M_QTY__c = 0;
	            }
	            rg.M_Job_QTY__c = rg.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	rg.T_QTY__c = topReference.rg__c;
				}
				ELSE{
					rg.T_QTY__c = 0;
				}
	            rg.T_Job_QTY__c = rg.T_QTY__c * quote.Top_Shifts__c;
	            rg.Type__c = 'Materials';                   
	            newQuoteLineItem.add(rg);
	        Quote_Line_Item__c cblock = new Quote_Line_Item__c();
	            cblock.Quote__c = quote.id;
	            cblock.Name__c = 'Cribbing Blocks';
	            cblock.CP__c = cblockData.FX5__Catalog_Cost__c; 
				cblock.BP__c = cblockData.FX5__Price__c;              
	            cblock.B_QTY__c = baseReference.cblock__c * 28;
	            cblock.B_Job_QTY__c = baseReference.cblock__c * 28;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                cblock.M_QTY__c = middleReference.cblock__c;
	            }
	            ELSE{
	                cblock.M_QTY__c = 0;
	            }
	            IF(quote.Total_Inches_Remain__c>19){
	                cblock.M_Job_QTY__c = middleReference.cblock__c *28;
	            }
	            ELSE{
	                cblock.M_Job_QTY__c = 0;
	            }           
	            IF(quote.Total_Inches_Remain__c>67){
	                cblock.T_QTY__c = topReference.cblock__c;
	            }
	            ELSE{
	                cblock.T_QTY__c = 0;
	            }
	            IF(quote.Total_Inches_Remain__c>67){
	                cblock.T_Job_QTY__c = topReference.cblock__c *28;
	            }
	            ELSE{
	                cblock.T_Job_QTY__c = 0;
	            }
	            cblock.Type__c = 'Materials';                   
	            newQuoteLineItem.add(cblock); 
	            system.debug('*****************************************************************  cribbing blocks entered');
	        Quote_Line_Item__c respCart = new Quote_Line_Item__c();
	            respCart.Quote__c = quote.id;
	            respCart.Name__c = 'Respirator Cartridge';
	            respCart.CP__c = respCartData.FX5__Catalog_Cost__c; 
	            respCart.BP__c = respCartData.FX5__Price__c;             
	            respCart.B_QTY__c = baseReference.resp__c;
	            respCart.B_Job_QTY__c = respCart.B_QTY__c * quote.Base_Shifts__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                respCart.M_QTY__c = middleReference.resp__c;
	            }
	            ELSE{
	                respCart.M_QTY__c = 0;
	            }
	            respCart.M_Job_QTY__c = respCart.M_QTY__c * quote.Middle_Shifts__c;
				IF(quote.Total_Inches_Remain__c>67){
	            	respCart.T_QTY__c = topReference.resp__c;
				}
				ELSE{
					respCart.T_QTY__c = 0;
				}
	            respCart.T_Job_QTY__c = respCart.T_QTY__c * quote.Top_Shifts__c;
	            respCart.Type__c = 'Materials';                   
	            newQuoteLineItem.add(respCart); 
	        Quote_Line_Item__c vtruckWash = new Quote_Line_Item__c();
	            vtruckWash.Quote__c = quote.id;
	            vtruckWash.Name__c = 'Vac Truck Wash';
	            vtruckWash.CP__c = vtruckWashData.FX5__Catalog_Cost__c; 
	            vtruckWash.BP__c = vtruckWashData.FX5__Price__c;                 
	            vtruckWash.B_QTY__c = quote.Vacum_Trucks__c;
	            vtruckWash.B_Job_QTY__c = quote.Vacum_Trucks__c;
	            IF(quote.Total_Inches_Remain__c >= 19){
	                vtruckWash.M_QTY__c = quote.Vacum_Trucks__c;
	            }
	            ELSE{
	                vtruckWash.M_QTY__c = 0;
	            }
	            vtruckWash.M_Job_QTY__c = quote.Vacum_Trucks__c;
	            IF(quote.Total_Inches_Remain__c>67){
	                vtruckWash.T_QTY__c = quote.Vacum_Trucks__c;
	            }
	            ELSE{
	                vtruckWash.T_QTY__c = 0;
	            }
	            vtruckWash.T_Job_QTY__c = quote.Vacum_Trucks__c;
	            vtruckWash.Type__c = 'Materials';                   
	            newQuoteLineItem.add(vtruckWash); 
	        
	         //Cleaning Labor data
	        FX5__Price_Book_Item__c superVData = list_PriceBookItems.get('SPVSR');        
	        FX5__Price_Book_Item__c foremenData = list_PriceBookItems.get('FOREMAN');        
	        FX5__Price_Book_Item__c equipmentOpData = list_PriceBookItems.get('EQUP_OPER');        
	        FX5__Price_Book_Item__c laborData = list_PriceBookItems.get('LBR_TECH');        
	        FX5__Price_Book_Item__c driverData = list_PriceBookItems.get('CL_A_DRV');
	                
	        Quote_Line_Item__c superV = new Quote_Line_Item__c();
	        	superV.Quote__c = quote.id;
	            superV.Name__c = 'Cleaning Supervisor';
	            superV.CP__c = superVData.Standard_Time_Cost__c; 
	            superV.BP__c = superVData.Standard_Time__c; 
	            superV.B_QTY__c = baseReference.CLEANUP_SUP__c;
	            superV.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>19){
	            	superV.M_QTY__c= middleReference.cleanup_Sup__c;
	            }
	            ELSE{
	            	superV.M_QTY__c= 0;
	            }
	            superV.M_Hours__c  = quote.Middle_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>67){
	            	superV.T_QTY__c= topReference.cleanup_Sup__c;
	            }
	            ELSE{
	            	superV.T_QTY__c= 0;
	            }
	            superV.T_Hours__c = quote.Top_Drain_Hours__c;
	            superV.Type__c = 'Labor';
	            newQuoteLineItem.add(superV);
	       Quote_Line_Item__c foremen = new Quote_Line_Item__c();
	            foremen.Quote__c = quote.id;
	            foremen.Name__c = 'Cleanup Foremen';
	            foremen.CP__c = foremenData.Standard_Time_Cost__c; 
	            foremen.BP__c = foremenData.Standard_Time__c;
	            foremen.B_QTY__c = baseReference.CLEANUP_FOREMEN__c;
	            foremen.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>19){
	                foremen.M_QTY__c= middleReference.cleanup_FOREMEN__c;
	            }
	            ELSE{
	                foremen.M_QTY__c= 0;
	            }
	            foremen.M_Hours__c  = quote.Middle_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>67){
	                foremen.T_QTY__c= topReference.cleanup_FOREMEN__c;
	            }
	            ELSE{
	                foremen.T_QTY__c= 0;
	            }
	            foremen.T_Hours__c = quote.Top_Drain_Hours__c;
	            foremen.Type__c = 'Labor';
	            newQuoteLineItem.add(foremen);
	        Quote_Line_Item__c equipmentOp = new Quote_Line_Item__c();
	            equipmentOp.Quote__c = quote.id;
	            equipmentOp.Name__c = 'Cleanup Equipment Op';
	            equipmentOp.CP__c = equipmentOpData.Standard_Time_Cost__c; 
	            equipmentOp.BP__c = equipmentOpData.Standard_Time__c;  
	            equipmentOp.B_QTY__c = baseReference.CLEANUP_eo__c;
	            equipmentOp.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>19){
	                equipmentOp.M_QTY__c= middleReference.cleanup_eo__c;
	            }
	            ELSE{
	                equipmentOp.M_QTY__c= 0;
	            }
	            equipmentOp.M_Hours__c  = quote.Middle_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>67){
	                equipmentOp.T_QTY__c= topReference.cleanup_eo__c;
	            }
	            ELSE{
	                equipmentOp.T_QTY__c= 0;
	            }
	            equipmentOp.T_Hours__c = quote.Top_Drain_Hours__c;
	            equipmentOp.Type__c = 'Labor';
	            newQuoteLineItem.add(equipmentOp);
	       Quote_Line_Item__c labor = new Quote_Line_Item__c();
	            labor.Quote__c = quote.id;
	            labor.Name__c = 'Cleanup Labor';
	            labor.CP__c = laborData.Standard_Time_Cost__c; 
	            labor.BP__c = laborData.Standard_Time__c;
	            labor.B_QTY__c = baseReference.CLEANUP_labor__c;
	            labor.B_Hours__c = quote.Base_Drain_Hours__c + quote.Non_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>19){
	                labor.M_QTY__c= middleReference.cleanup_labor__c;
	            }
	            ELSE{
	                labor.M_QTY__c= 0;
	            }
	            labor.M_Hours__c  = quote.Middle_Drain_Hours__c;
	            IF (quote.Total_Inches_Remain__c>67){
	                labor.T_QTY__c= topReference.cleanup_labor__c;
	            }
	            ELSE{
	                labor.T_QTY__c= 0;
	            }
	            labor.T_Hours__c = quote.Top_Drain_Hours__c;
	            labor.Type__c = 'Labor';
	            newQuoteLineItem.add(labor);
	        Quote_Line_Item__c driver = new Quote_Line_Item__c();
	            driver.Quote__c = quote.id;
	            driver.Name__c = 'Cleanup Driver';
	            driver.CP__c = driverData.Standard_Time_Cost__c;
	            driver.BP__c = driverData.Standard_Time__c;
	            driver.B_QTY__c = quote.Vacum_Trucks__c;                          
	            driver.B_Hours__c = quote.Vac_Truck_Hours__c;            
	            driver.M_QTY__c = 0;
	            driver.T_QTY__c = 0;
	            driver.Type__c = 'Labor';                   
	            newQuoteLineItem.add(driver); 
	
	        //end quote item updates
	        
	        insert newQuoteLineItem;
	        RecursiveTriggerHandler.insertNotDone = false;

       }
       if(quote.Job_Type__c == 'Refined'){
	     	RecursiveTriggerHandler.insertNotDone = false;
	        //system.debug('******************************************************************************************insert done' + RecursiveTriggerHandler.insertNotDone);
	        Decimal tankDiameter = quote.Tank_Diameter__c;
	        String locationEntered = quote.Location__c; 
       		REFERENCE__c refinedReference = ([SELECT id,TYPE__C,DS__c,DE__c,TECHS__C,PTFIXED__C,PTRING__C,PTDECK__C,WASH__C,TRUCK__C,X185AC__C,X375AC__C,
       			HOTWASH__C,HOTEO__C,HOTGM__C,FRESH__C,AHOSE__C,GROUND__C,GASMETER__C,VACHOSE__C,WHOSE__C,JETPUMP__C,	GAMAJ__C,CP20__C,TLIGHT__C,FLIGHT__C,
       			H2S__C,M15__C,RG__C,PLASTIC__C,RESP__C,GLOVES__C,PLUGS__C,	WATER__C,POOL__C,BAGS__C,CLEAN__C,TAPE__C,HORN__C,STEM__C,MOB__C,WASHRATE__C,LEGCREW__C,
       			SETLEGS__C,CRIBHOURS__C,CRIBTOWERS__C FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'Refined')]);
       		LOCATION__c location = ([SELECT id, Name, BOTTLEWASH__C, FRESHAIR_REFINED__C, GasMeter_Loc__c, M30__c, MOB_HOURS__C, WASH__C, HOLEWATCH__C, GASMETERQTY__C, PERDIEM__c, TRAVELTIME__c, FRESHAIR__c, GASMETERS__c FROM LOCATION__c WHERE Name =: locationEntered]);
       		//Equipment data
	        
	        FX5__Price_Book_Item__c gamaJetData = list_PriceBookItems.get('GAMA_JET');       
	        FX5__Price_Book_Item__c cartData = list_PriceBookItems.get('RESP_RPLC_CART');             
	        FX5__Price_Book_Item__c hotPWasherData = list_PriceBookItems.get('2.5K_PRSS_WSHR_3GPM');        
	        FX5__Price_Book_Item__c jetPumpData = list_PriceBookItems.get('JT_PMP');        
	        FX5__Price_Book_Item__c gearTruckData = list_PriceBookItems.get('CRW_CB');       
	        FX5__Price_Book_Item__c one85AcData = list_PriceBookItems.get('185_AIR_CMP');        
	        FX5__Price_Book_Item__c three75AcData = list_PriceBookItems.get('375_AIR_CMP');        
	        FX5__Price_Book_Item__c freshAirData = list_PriceBookItems.get('FRSH_AIR_SETUP_4MSK');        
	        FX5__Price_Book_Item__c airHoseData = list_PriceBookItems.get('AIR_HSE_50');        
	        FX5__Price_Book_Item__c groundCableData = list_PriceBookItems.get('GRND_CBL');        
	        FX5__Price_Book_Item__c gasMeterData = list_PriceBookItems.get('4GAS_MTR_MNTR');               
	        FX5__Price_Book_Item__c vacHoseData = list_PriceBookItems.get('4_CMLCK_VAC_HSE_20');        
	        FX5__Price_Book_Item__c waterHoseData = list_PriceBookItems.get('WTR_HSE_50');        
	        FX5__Price_Book_Item__c cp20Data = list_PriceBookItems.get('CP20_CPPS_BLWR');        
	        FX5__Price_Book_Item__c tankLightData = list_PriceBookItems.get('LRG_TNK_LGHT_EP');        
	        FX5__Price_Book_Item__c flashLightData = list_PriceBookItems.get('FLSHLGHT_EXP_PRF');       
	        FX5__Price_Book_Item__c persH2sData = list_PriceBookItems.get('PERS_H2S_MTR_MNTR');        
	        FX5__Price_Book_Item__c m15Data = list_PriceBookItems.get('M15_PMP');        
	        FX5__Price_Book_Item__c m30Data = list_PriceBookItems.get('M30_PMP');        
	        FX5__Price_Book_Item__c vacumTrucksData = list_PriceBookItems.get('120BBL_VAC_TRCK');       
	     
       		
       		Quote_Line_Item__c gearTrucks = new Quote_Line_Item__c();
	            gearTrucks.Quote__c = quote.id;
	            gearTrucks.Name__c = 'Gear Trucks';
	            gearTrucks.CP__c = gearTruckData.Hourly_Cost__c; 
	            gearTrucks.PPE__c = gearTruckData.Hourly__c; //billing figure              
	            gearTrucks.B_QTY__c = refinedReference.Truck__c;//using base quantity in quote line item
	            gearTrucks.Ext__c = gearTrucks.PPE__c * gearTrucks.B_QTY__c;
	            gearTrucks.Per_Shift__c = gearTrucks.Ext__c * quote.Hours_In_Shift__c;
	            gearTrucks.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(gearTrucks);	
			Quote_Line_Item__c one85Ac = new Quote_Line_Item__c();
	            one85Ac.Quote__c = quote.id;
	            one85Ac.Name__c = '185 Air Compressor';
	            one85Ac.CP__c = one85AcData.Hourly_Cost__c; 
	            one85Ac.PPE__c = one85AcData.Hourly__c; //billing figure 	                        
	            one85Ac.B_QTY__c = refinedReference.X185AC__C;//using base quantity in quote line item
	            one85Ac.Ext__c = one85Ac.PPE__c * one85Ac.B_QTY__c; 
	            one85Ac.Per_Shift__c = one85Ac.Ext__c * quote.Hours_In_Shift__c;
	            one85Ac.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(one85Ac);	
       		Quote_Line_Item__c three85Ac = new Quote_Line_Item__c();
	            three85Ac.Quote__c = quote.id;
	            three85Ac.Name__c = '375 Air Compressor';
	            three85Ac.CP__c = three75AcData.Hourly_Cost__c; 
	            three85Ac.PPE__c = three75AcData.Hourly__c; //billing figure              
	            three85Ac.B_QTY__c = refinedReference.X375AC__C;//using base quantity in quote line item
	            three85Ac.Ext__c = three85Ac.PPE__c * three85Ac.B_QTY__c;
	            three85Ac.Per_Shift__c = three85Ac.Ext__c * quote.Hours_In_Shift__c;
	            three85Ac.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(three85Ac);	
       		Quote_Line_Item__c M30 = new Quote_Line_Item__c();
	            M30.Quote__c = quote.id;
	            M30.Name__c = 'M30';
	            M30.CP__c = m30Data.Hourly_Cost__c; 
	            M30.PPE__c = m30Data.Hourly__c; //billing figure  
	            M30.B_QTY__c = location.M30__c;            
	            //M30.B_QTY__c = refinedReference.TRUCK__C;//using base quantity in quote line item
	            M30.Ext__c = M30.PPE__c * M30.B_QTY__c;
	            M30.Per_Shift__c = M30.Ext__c * quote.Hours_In_Shift__c;
	            M30.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(M30);	
			Quote_Line_Item__c hotPWasher = new Quote_Line_Item__c();
	            hotPWasher.Quote__c = quote.id;
	            hotPWasher.Name__c = 'Hot Pressure Washer';
	            hotPWasher.CP__c = hotPWasherData.Hourly_Cost__c; 
	            hotPWasher.PPE__c = hotPWasherData.Hourly__c; //billing figure              
	            if(quote.Wash_Type__c == 'Hot'){
	            	hotPWasher.B_QTY__c = refinedReference.HOTWASH__C;//using base quantity in quote line item	
	            }
	            else{
	            	hotPWasher.B_QTY__c = 0;//using base quantity in quote line item
	            }
	            hotPWasher.Ext__c = hotPWasher.PPE__c * hotPWasher.B_QTY__c;
	            hotPWasher.Per_Shift__c = hotPWasher.Ext__c * quote.Hours_In_Shift__c;
	            hotPWasher.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(hotPWasher);	
	       	Quote_Line_Item__c freshAir = new Quote_Line_Item__c();
		            freshAir.Quote__c = quote.id;
		            freshAir.Name__c = 'Fresh Air';
		            freshAir.CP__c = freshAirData.Hourly_Cost__c; 
		            freshAir.PPE__c = freshAirData.Hourly__c; //billing figure 
		            if(quote.Fresh_Air_Needed__c == false){
		            	freshAir.B_QTY__c = 0;
		            }             
		            else{
		            	freshAir.B_QTY__c = 1;
		            }
		            freshAir.Ext__c = freshAir.PPE__c * freshAir.B_QTY__c;
		            //freshAir.Per_Shift__c = freshAir.EXT__c * quote.Hours_In_Shift__c;
		            freshAir.Per_Shift__c = freshAir.EXT__c * quote.BottleWash_Hours__c * quote.Techs__c;
		            freshAir.Type__c = 'Equipment';                   
		            newQuoteLineItem.add(freshAir);	       		
       		Quote_Line_Item__c airHose = new Quote_Line_Item__c();
	            airHose.Quote__c = quote.id;
	            airHose.Name__c = 'Air Hose';
	            airHose.CP__c = airHoseData.Hourly_Cost__c; 
	            airHose.PPE__c = airHoseData.Hourly__c; //billing figure              
	            airHose.B_QTY__c = refinedReference.AHOSE__C;//using base quantity in quote line item
	            airHose.Ext__c = airHose.PPE__c * airHose.B_QTY__c;
	            airHose.Per_Shift__c = airHose.Ext__c * quote.Hours_In_Shift__c;
	            airHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(airHose);	        
	        Quote_Line_Item__c groundCable = new Quote_Line_Item__c();
	            groundCable.Quote__c = quote.id;
	            groundCable.Name__c = 'Ground Cable';
	            groundCable.CP__c = groundCableData.Hourly_Cost__c; 
	            groundCable.PPE__c = groundCableData.Hourly__c; //billing figure              
	            groundCable.B_QTY__c = refinedReference.GROUND__C;//using base quantity in quote line item
	            groundCable.Ext__c = groundCable.PPE__c * groundCable.B_QTY__c;
	            groundCable.Per_Shift__c = groundCable.Ext__c * quote.Hours_In_Shift__c;
	            groundCable.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(groundCable);	            
	       Quote_Line_Item__c gasMeter = new Quote_Line_Item__c();
	            gasMeter.Quote__c = quote.id;
	            gasMeter.Name__c = 'Gas Meter';
	            gasMeter.CP__c = gasMeterData.Hourly_Cost__c; 
	            gasMeter.PPE__c = gasMeterData.Hourly__c; //billing figure              	            
	            if(quote.Location__c == 'Wilmington'){
	            	gasMeter.B_QTY__c = 0;
	            }
	            else if(quote.Location__c == 'Carson'){
	            	gasMeter.B_QTY__c = 0;
	            }
	            else{
	            	gasMeter.B_QTY__c = quote.GasMeters_Hotwash__c + quote.GasMeters_Tank__c + location.GasMeter_Loc__c + quote.GasMeters_Vac_Truck__c;
	            }	            	            
	            gasMeter.Ext__c = gasMeter.PPE__c * gasMeter.B_QTY__c;
	            gasMeter.Per_Shift__c = gasMeter.Ext__c * quote.Hours_In_Shift__c;
	            gasMeter.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(gasMeter);	         
	        Quote_Line_Item__c vacHose = new Quote_Line_Item__c();
	            vacHose.Quote__c = quote.id;
	            vacHose.Name__c = 'Vac Hoses';
	            vacHose.CP__c = vacHoseData.Hourly_Cost__c; 
	            vacHose.PPE__c = vacHoseData.Hourly__c; //billing figure              
	            vacHose.B_QTY__c = refinedReference.VACHOSE__C;//using base quantity in quote line item
	            vacHose.Ext__c = vacHose.PPE__c * vacHose.B_QTY__c;
	            vacHose.Per_Shift__c = vacHose.Ext__c * quote.Hours_In_Shift__c;
	            vacHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(vacHose);
	        Quote_Line_Item__c waterHose = new Quote_Line_Item__c();
	            waterHose.Quote__c = quote.id;
	            waterHose.Name__c = 'Water Hoses';
	            waterHose.CP__c = waterHoseData.Hourly_Cost__c; 
	            waterHose.PPE__c = waterHoseData.Hourly__c; //billing figure              
	            waterHose.B_QTY__c = refinedReference.WHOSE__C;//using base quantity in quote line item
	            waterHose.Ext__c = waterHose.PPE__c * waterHose.B_QTY__c;
	            waterHose.Per_Shift__c = waterHose.Ext__c * quote.Hours_In_Shift__c;
	            waterHose.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(waterHose);
	        Quote_Line_Item__c jetPump = new Quote_Line_Item__c();
	            jetPump.Quote__c = quote.id;
	            jetPump.Name__c = 'Jet Pump';
	            jetPump.CP__c = jetPumpData.Hourly_Cost__c; 
	            jetPump.PPE__c = jetPumpData.Hourly__c; //billing figure              
	            jetPump.B_QTY__c = refinedReference.JETPUMP__C;//using base quantity in quote line item
	            jetPump.Ext__c = jetPump.PPE__c * jetPump.B_QTY__c;
	            jetPump.Per_Shift__c = jetPump.Ext__c * quote.Hours_In_Shift__c;
	            jetPump.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(jetPump);   
	        Quote_Line_Item__c gamaJet = new Quote_Line_Item__c();
	            gamaJet.Quote__c = quote.id;
	            gamaJet.Name__c = 'Gama Jet';
	            gamaJet.CP__c = gamaJetData.Hourly_Cost__c; 
	            gamaJet.PPE__c = gamaJetData.Hourly__c; //billing figure              
	            gamaJet.B_QTY__c = refinedReference.GAMAJ__C;//using base quantity in quote line item
	            gamaJet.Ext__c = gamaJet.PPE__c * gamaJet.B_QTY__c;
	            gamaJet.Per_Shift__c = gamaJet.Ext__c * quote.Hours_In_Shift__c;
	            gamaJet.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(gamaJet);   
	       Quote_Line_Item__c cp20 = new Quote_Line_Item__c();
	            cp20.Quote__c = quote.id;
	            cp20.Name__c = 'CP-20';
	            cp20.CP__c = cp20Data.Hourly_Cost__c; 
	            cp20.PPE__c = cp20Data.Hourly__c; //billing figure              
	            cp20.B_QTY__c = refinedReference.CP20__C;//using base quantity in quote line item
	            cp20.Ext__c = cp20.PPE__c * cp20.B_QTY__c;
	            cp20.Per_Shift__c = cp20.Ext__c * quote.Hours_In_Shift__c;
	            cp20.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(cp20);
       	  Quote_Line_Item__c tankLight = new Quote_Line_Item__c();
	            tankLight.Quote__c = quote.id;
	            tankLight.Name__c = 'Tank Lights';
	            tankLight.CP__c = tankLightData.Hourly_Cost__c; 
	            tankLight.PPE__c = tankLightData.Hourly__c; //billing figure  
	            tankLight.B_QTY__c = refinedReference.JETPUMP__C;    //this is what is referred to in excel calculators        
	            //tankLight.B_QTY__c = refinedReference.TLIGHT__C;//using base quantity in quote line item
	            tankLight.Ext__c = tankLight.PPE__c * tankLight.B_QTY__c;
	            tankLight.Per_Shift__c = tankLight.Ext__c * quote.Hours_In_Shift__c;
	            tankLight.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(tankLight);  
	       Quote_Line_Item__c flashLight = new Quote_Line_Item__c();
	            flashLight.Quote__c = quote.id;
	            flashLight.Name__c = 'Flash Lights';
	            flashLight.CP__c = flashLightData.Hourly_Cost__c; //cost figure
	            flashLight.PPE__c = flashLightData.Hourly__c; //billing figure              
	            flashLight.B_QTY__c = refinedReference.FLIGHT__C;//using base quantity in quote line item
	            flashLight.Ext__c = flashLight.PPE__c * flashLight.B_QTY__c;
	            flashLight.Per_Shift__c = flashLight.Ext__c * quote.Hours_In_Shift__c;
	            flashLight.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(flashLight);
	       Quote_Line_Item__c persH2s = new Quote_Line_Item__c();
	            persH2s.Quote__c = quote.id;
	            persH2s.Name__c = 'Personell H2s';
	            persH2s.CP__c = persH2sData.Hourly_Cost__c; 
	            persH2s.PPE__c = persH2sData.Hourly__c; //billing figure              
	            persH2s.B_QTY__c = refinedReference.H2S__C;//using base quantity in quote line item
	            persH2s.Ext__c = persH2s.PPE__c * persH2s.B_QTY__c;
	            persH2s.Per_Shift__c = persH2s.Ext__c * quote.Hours_In_Shift__c;
	            persH2s.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(persH2s);	      
	        Quote_Line_Item__c m15 = new Quote_Line_Item__c();
	            m15.Quote__c = quote.id;
	            m15.Name__c = 'M-15s';
	            m15.CP__c = m15Data.Hourly_Cost__c; 
	            m15.PPE__c = m15Data.Hourly__c; //billing figure              
	            m15.B_QTY__c = refinedReference.M15__C;//using base quantity in quote line item
	            m15.Ext__c = m15.PPE__c * m15.B_QTY__c;
	            m15.Per_Shift__c = m15.Ext__c * quote.Hours_In_Shift__c;
	            m15.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(m15);	         
	         Quote_Line_Item__c vacumTrucks = new Quote_Line_Item__c();
	            vacumTrucks.Quote__c = quote.id;
	            vacumTrucks.Name__c = 'Vacuum Trucks';
	            vacumTrucks.CP__c = vacumTrucksData.Hourly_Cost__c; 
	            vacumTrucks.PPE__c = vacumTrucksData.Hourly__c; //billing figure              
	            vacumTrucks.B_QTY__c = quote.Vacum_Trucks__c;
	            vacumTrucks.Ext__c = vacumTrucks.PPE__c * vacumTrucks.B_QTY__c;
	            vacumTrucks.Per_Shift__c = vacumTrucks.Ext__c * quote.Hours_In_Shift__c;
	            vacumTrucks.Type__c = 'Equipment';                   
	            newQuoteLineItem.add(vacumTrucks);
	         //crew totals   
	          Quote_Line_Item__c pontoonCrewEq = new Quote_Line_Item__c();
	          	pontoonCrewEq.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.PPE__c + flashLight.PPE__c + persH2s.Ext__c + m15.Ext__c) * quote.Pontoon_Hours__c;	            
	            pontoonCrewEq.Name__c = 'Pontoon Crew Equipment';
	            pontoonCrewEq.Type__c = 'Crew Equipment';
	            pontoonCrewEq.Quote__c = quote.id;                 
	            newQuoteLineItem.add(pontoonCrewEq);    
	          Quote_Line_Item__c washCrewEq = new Quote_Line_Item__c();
	            washCrewEq.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + M30.Ext__c + 92 + groundCable.Ext__c + gasMeter.Ext__c + vacHose.Ext__c + waterHose.Ext__c + jetPump.Ext__c + gamaJet.Ext__c + cp20.Ext__c + tankLight.Ext__c + flashLight.Ext__c + persH2s.Ext__c + m15.Ext__c) * quote.Wash_Hours__c;
	            washCrewEq.Name__c = 'Wash Crew Equipment';
	            washCrewEq.Type__c = 'Crew Equipment';
	            washCrewEq.Quote__c = quote.id;                 
	            newQuoteLineItem.add(washCrewEq);
	         Quote_Line_Item__c hotWashCrewEq = new Quote_Line_Item__c();
	            hotWashCrewEq.Total__c =  hotPWasher.Ext__c * quote.HotWash_Hours__c;
	            hotWashCrewEq.Name__c = 'HotWash Crew Equipment';
	            hotWashCrewEq.Type__c = 'Crew Equipment';
	            hotWashCrewEq.Quote__c = quote.id;                 
	            newQuoteLineItem.add(hotWashCrewEq); 
	         Quote_Line_Item__c mobCrewEq = new Quote_Line_Item__c();
	            mobCrewEq.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.Ext__c + tankLight.Ext__c + persH2s.Ext__c) * quote.MOB_Hours__c;
	            mobCrewEq.Name__c = 'MOB Crew Equipment';
	            mobCrewEq.Type__c = 'Crew Equipment'; 
	            mobCrewEq.Quote__c = quote.id;                
	            newQuoteLineItem.add(mobCrewEq);
	         Quote_Line_Item__c deMOBCrewEq = new Quote_Line_Item__c();
	            deMOBCrewEq.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__C + cp20.Ext__c + tankLight.Ext__c + persH2s.Ext__c) * quote.DeMOB_Hours__c;
	            deMOBCrewEq.Name__c = 'DeMOB Crew Equipment';
	            deMOBCrewEq.Type__c = 'Crew Equipment'; 
	            deMOBCrewEq.Quote__c = quote.id;                
	            newQuoteLineItem.add(deMOBCrewEq);
	         Quote_Line_Item__c drainCrewEq = new Quote_Line_Item__c();
	            drainCrewEq.Total__c = vacumTrucks.Ext__c * quote.Drain_Hours__c;
	            drainCrewEq.Name__c = 'Drain Crew Equipment';
	            drainCrewEq.Type__c = 'Crew Equipment'; 
	            drainCrewEq.Quote__c = quote.id;                
	            newQuoteLineItem.add(drainCrewEq);
	         Quote_Line_Item__c scaleCrewEq = new Quote_Line_Item__c();
	            scaleCrewEq.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.Ext__c + tankLight.Ext__c + flashLight.Ext__c + persH2s.Ext__c) * quote.Scale_Hours__c;
	            scaleCrewEq.Name__c = 'Scale Crew Equipment';
	            scaleCrewEq.Type__c = 'Crew Equipment'; 
	            scaleCrewEq.Quote__c = quote.id;                
	            newQuoteLineItem.add(scaleCrewEq);
	         Quote_Line_Item__c legsCrewEq = new Quote_Line_Item__c();
	            legsCrewEq.Total__c = (gearTrucks.Ext__c + one85Ac.Ext__c + three85Ac.Ext__c + gasMeter.PPE__c + cp20.PPE__c + tankLight.Ext__c + flashLight.Ext__c + persH2s.Ext__c) * quote.Legs_Hours__c;
	            legsCrewEq.Name__c = 'Legs Crew Equipment';
	            legsCrewEq.Type__c = 'Crew Equipment';
	            legsCrewEq.Quote__c = quote.id;                 
	            newQuoteLineItem.add(legsCrewEq); 
	          Quote_Line_Item__c cribbingCrewEq = new Quote_Line_Item__c();
	            cribbingCrewEq.Total__c = (one85Ac.Ext__c + three85Ac.Ext__c + M30.Ext__c + gasMeter.PPE__c + vacHose.PPE__c + tankLight.Ext__c + flashLight.PPE__c + persH2s.Ext__c + m15.Ext__c) * quote.Cribbing_Hours__c;
	            cribbingCrewEq.Name__c = 'Cribbing Crew Equipment';
	            cribbingCrewEq.Type__c = 'Crew Equipment';
	            cribbingCrewEq.Quote__c = quote.id;                 
	            newQuoteLineItem.add(cribbingCrewEq);     	         
	         Quote_Line_Item__c vacuumCrewEq = new Quote_Line_Item__c();
	            vacuumCrewEq.Total__c = vacumTrucks.Ext__c * quote.Vac_Truck_Hours_Refined__c;
	            vacuumCrewEq.Name__c = 'Vacuum Crew Equipment';
	            vacuumCrewEq.Type__c = 'Crew Equipment'; 
	            vacuumCrewEq.Quote__c = quote.id;                
	            newQuoteLineItem.add(vacuumCrewEq);    
	        Quote_Line_Item__c bottleWashCrewEq = new Quote_Line_Item__c();
	            bottleWashCrewEq.Total__c = ((quote.Wash_Crew__c/2) * quote.Fresh_Air_Hours_Refined__c) * freshAir.Ext__c;
	            bottleWashCrewEq.Name__c = 'Bottle Wash Crew Equipment';
	            bottleWashCrewEq.Type__c = 'Crew Equipment';
	            bottleWashCrewEq.Quote__c = quote.id;                 
	            newQuoteLineItem.add(bottleWashCrewEq);  
	           
	            
       	//Materials data
	        FX5__Price_Book_Item__c tyvekData = list_PriceBookItems.get('TYVEK');        
	        FX5__Price_Book_Item__c plasticData = list_PriceBookItems.get('20_VSQN_PLSTC_RLL_100');        
	        FX5__Price_Book_Item__c respData = list_PriceBookItems.get('1/2_RESP_FAC');        
	        FX5__Price_Book_Item__c glovesData = list_PriceBookItems.get('PVC_GLV');        
	        FX5__Price_Book_Item__c earPlugsData = list_PriceBookItems.get('EAR_PLG_FM');        
	        FX5__Price_Book_Item__c waterData = list_PriceBookItems.get('DRNK_WTR');        
	        FX5__Price_Book_Item__c poolData = list_PriceBookItems.get('DCN_LG_POOL');        
	        FX5__Price_Book_Item__c bagsData = list_PriceBookItems.get('PLSTC_BG_30X40');        
	        FX5__Price_Book_Item__c cleanData = list_PriceBookItems.get('HND_CLNR');       
	        FX5__Price_Book_Item__c tapeData = list_PriceBookItems.get('DUCT_TAPE');        
	        FX5__Price_Book_Item__c hornData = list_PriceBookItems.get('PRTBL_AIR_HRN');        
	        FX5__Price_Book_Item__c cblockData = list_PriceBookItems.get('CRIB_BLCKS');       
	        FX5__Price_Book_Item__c respCartData = list_PriceBookItems.get('RESP_RPLC_CART');       
	        FX5__Price_Book_Item__c vtruckWashData = list_PriceBookItems.get('HT_WTR_WSHOUT');
			FX5__Price_Book_Item__c rgData = list_PriceBookItems.get('RN_GR_FRC');        
	        
	        Quote_Line_Item__c rainGear = new Quote_Line_Item__c();
	            rainGear.Quote__c = quote.id;
	            rainGear.Name__c = 'Rain Gear';
	            rainGear.CP__c = rgData.FX5__Catalog_Cost__c; 
	            rainGear.PPE__c = rgData.FX5__Price__c; //billing figure              
	            rainGear.B_QTY__c = refinedReference.RG__C;//using base quantity in quote line item
	            rainGear.Ext__c = rainGear.PPE__c * rainGear.B_QTY__c;
	            rainGear.Type__c = 'Materials';                   
	            newQuoteLineItem.add(rainGear);		            
	        Quote_Line_Item__c plastic = new Quote_Line_Item__c();
	            plastic.Quote__c = quote.id;
	            plastic.Name__c = 'Plastic';
	            plastic.CP__c = plasticData.FX5__Catalog_Cost__c; 
	            plastic.PPE__c = plasticData.FX5__Price__c; //billing figure              
	            plastic.B_QTY__c = refinedReference.PLASTIC__C;//using base quantity in quote line item
	            plastic.Ext__c = plastic.PPE__c * plastic.B_QTY__c;
	            plastic.Type__c = 'Materials';                   
	            newQuoteLineItem.add(plastic);	   
	       Quote_Line_Item__c resp = new Quote_Line_Item__c();
	            resp.Quote__c = quote.id;
	            resp.Name__c = 'Respirators';
	            resp.CP__c = respData.FX5__Catalog_Cost__c; 
	            resp.PPE__c = respData.FX5__Price__c; //billing figure              
	            resp.B_QTY__c = refinedReference.RESP__C;//using base quantity in quote line item
	            resp.Ext__c = resp.PPE__c * resp.B_QTY__c;
	            resp.Type__c = 'Materials';                   
	            newQuoteLineItem.add(resp);	 
	       Quote_Line_Item__c gloves = new Quote_Line_Item__c();
	            gloves.Quote__c = quote.id;
	            gloves.Name__c = 'Gloves';
	            gloves.CP__c = glovesData.FX5__Catalog_Cost__c; 
	            gloves.PPE__c = glovesData.FX5__Price__c; //billing figure              
	            gloves.B_QTY__c = refinedReference.GLOVES__C;//using base quantity in quote line item
	            gloves.Ext__c = gloves.PPE__c * gloves.B_QTY__c;
	            gloves.Type__c = 'Materials';                   
	            newQuoteLineItem.add(gloves);	    
	       Quote_Line_Item__c earPlugs = new Quote_Line_Item__c();
	            earPlugs.Quote__c = quote.id;
	            earPlugs.Name__c = 'Ear Plugs';
	            earPlugs.CP__c = earPlugsData.FX5__Catalog_Cost__c;
	            earPlugs.PPE__c = earPlugsData.FX5__Price__c; //billing figure              
	            earPlugs.B_QTY__c = refinedReference.PLUGS__C;//using base quantity in quote line item
	            earPlugs.Ext__c = earPlugs.PPE__c * earPlugs.B_QTY__c;
	            earPlugs.Type__c = 'Materials';                   
	            newQuoteLineItem.add(earPlugs);	        
	       Quote_Line_Item__c water = new Quote_Line_Item__c();
	            water.Quote__c = quote.id;
	            water.Name__c = 'Water';
	            water.CP__c = waterData.FX5__Catalog_Cost__c; 
	            water.PPE__c = waterData.FX5__Price__c; //billing figure              
	            water.B_QTY__c = refinedReference.WATER__C;//using base quantity in quote line item
	            water.Ext__c = water.PPE__c * water.B_QTY__c;
	            water.Type__c = 'Materials';                   
	            newQuoteLineItem.add(water);	      
	       Quote_Line_Item__c pool = new Quote_Line_Item__c();
	            pool.Quote__c = quote.id;
	            pool.Name__c = 'Kitty Pools';
	            pool.CP__c = poolData.FX5__Catalog_Cost__c; 
	            pool.PPE__c = poolData.FX5__Price__c; //billing figure              
	            pool.B_QTY__c = refinedReference.POOL__C;//using base quantity in quote line item
	            pool.Ext__c = pool.PPE__c * pool.B_QTY__c;
	            pool.Type__c = 'Materials';                   
	            newQuoteLineItem.add(pool);	      
	       Quote_Line_Item__c bags = new Quote_Line_Item__c();
	            bags.Quote__c = quote.id;
	            bags.Name__c = 'Plastic Bags';
	            bags.CP__c = bagsData.FX5__Catalog_Cost__c; 
	            bags.PPE__c = bagsData.FX5__Price__c; //billing figure              
	            bags.B_QTY__c = refinedReference.BAGS__C;//using base quantity in quote line item
	            bags.Ext__c = bags.PPE__c * bags.B_QTY__c;
	            bags.Type__c = 'Materials';                   
	            newQuoteLineItem.add(bags);	       
	       Quote_Line_Item__c clean = new Quote_Line_Item__c();
	            clean.Quote__c = quote.id;
	            clean.Name__c = 'Hand Cleaner';
	            clean.CP__c = cleanData.FX5__Catalog_Cost__c; 
	            clean.PPE__c = cleanData.FX5__Price__c; //billing figure              
	            clean.B_QTY__c = refinedReference.CLEAN__C;//using base quantity in quote line item
	            clean.Ext__c = clean.PPE__c * clean.B_QTY__c;
	            clean.Type__c = 'Materials';                   
	            newQuoteLineItem.add(clean);	       
	       Quote_Line_Item__c tape = new Quote_Line_Item__c();
	            tape.Quote__c = quote.id;
	            tape.Name__c = 'Duct Tape';
	            tape.CP__c = tapeData.FX5__Catalog_Cost__c; 
	            tape.PPE__c = tapeData.FX5__Price__c; //billing figure              
	            tape.B_QTY__c = refinedReference.TAPE__C;//using base quantity in quote line item
	            tape.Ext__c = tape.PPE__c * tape.B_QTY__c;
	            tape.Type__c = 'Materials';                   
	            newQuoteLineItem.add(tape);	     
	       Quote_Line_Item__c horn = new Quote_Line_Item__c();
	            horn.Quote__c = quote.id;
	            horn.Name__c = 'Air Horn';
	            horn.CP__c = hornData.FX5__Catalog_Cost__c; 
	            horn.PPE__c = hornData.FX5__Price__c; //billing figure              
	            horn.B_QTY__c = refinedReference.HORN__C;//using base quantity in quote line item
	            horn.Ext__c = horn.PPE__c * horn.B_QTY__c;
	            horn.Type__c = 'Materials';                   
	            newQuoteLineItem.add(horn);	   
	       Quote_Line_Item__c respCart = new Quote_Line_Item__c();
	            respCart.Quote__c = quote.id;
	            respCart.Name__c = 'Respirator Cart';
	            respCart.CP__c = respCartData.FX5__Catalog_Cost__c; 
	            respCart.PPE__c = respCartData.FX5__Price__c; //billing figure              
	            respCart.B_QTY__c = refinedReference.RESP__C;//using base quantity in quote line item
	            respCart.Ext__c = respCart.PPE__c * respCart.B_QTY__c;
	            respCart.Type__c = 'Materials';                   
	            newQuoteLineItem.add(respCart);	     
	       Quote_Line_Item__c cblock = new Quote_Line_Item__c();
	            cblock.Quote__c = quote.id;
	            cblock.Name__c = 'Cribbing Blocks';
	            cblock.CP__c = cblockData.FX5__Catalog_Cost__c; 
	            cblock.PPE__c = cblockData.FX5__Price__c; //billing figure              
	            cblock.B_QTY__c = quote.Cribbing_Towers__c * 28;
	            cblock.Ext__c = cblock.PPE__c * cblock.B_QTY__c;
	            cblock.Type__c = 'Materials';                   
	            newQuoteLineItem.add(cblock);
	       Quote_Line_Item__c vtruckWash = new Quote_Line_Item__c();
	            vtruckWash.Quote__c = quote.id;
	            vtruckWash.Name__c = 'Vac Truck Wash';
	            vtruckWash.CP__c = vtruckWashData.FX5__Catalog_Cost__c;
	            vtruckWash.PPE__c = vtruckWashData.FX5__Price__c; //billing figure              
	            vtruckWash.B_QTY__c = quote.Vacum_Trucks__c;
	            vtruckWash.Ext__c = vtruckWash.PPE__c * vtruckWash.B_QTY__c;
	            vtruckWash.Type__c = 'Materials';                   
	            newQuoteLineItem.add(vtruckWash);	     
	       Quote_Line_Item__c tyvek = new Quote_Line_Item__c();
	            tyvek.Quote__c = quote.id;
	            tyvek.Name__c = 'Tyvek';
	            tyvek.CP__c = tyvekData.FX5__Catalog_Cost__c; 
	            tyvek.PPE__c = tyvekData.FX5__Price__c; //billing figure              
	            tyvek.B_QTY__c = refinedReference.RG__C;//using base quantity in quote line item
	            tyvek.Ext__c = tyvek.PPE__c * tyvek.B_QTY__c;
	            tyvek.Type__c = 'Materials';                   
	            newQuoteLineItem.add(tyvek);
	       //Mat shifts
	        Quote_Line_Item__c pontoonMatShift = new Quote_Line_Item__c();
	       		pontoonMatShift.Total__c = quote.Pontoon_Hours__c/quote.Hours_In_Shift__c;
	            pontoonMatShift.Name__c = 'Pontoon MatShifts';
	            pontoonMatShift.Type__c = 'Materials'; 
	            pontoonMatShift.Quote__c = quote.id;                
	          	newQuoteLineItem.add(pontoonMatShift);        
	       Quote_Line_Item__c washMatShift = new Quote_Line_Item__c();
	       		washMatShift.Total__c = quote.Wash_Hours__c/quote.Hours_In_Shift__c;
	            washMatShift.Name__c = 'Wash MatShifts';
	            washMatShift.Type__c = 'Materials'; 
	            washMatShift.Quote__c = quote.id;                
	         	newQuoteLineItem.add(washMatShift);	            
	       Quote_Line_Item__c hotWashMatShift = new Quote_Line_Item__c();
	       		hotWashMatShift.Total__c = quote.HotWash_Hours__c/quote.Hours_In_Shift__c;
	            hotWashMatShift.Name__c = 'HotWash MatShifts';
	            hotWashMatShift.Type__c = 'Materials'; 
	            hotWashMatShift.Quote__c = quote.id;                
	          	newQuoteLineItem.add(hotWashMatShift);
	       Quote_Line_Item__c MOBMatShift = new Quote_Line_Item__c();
	       		MOBMatShift.Total__c = quote.MOB_Hours__c/quote.Hours_In_Shift__c;
	            MOBMatShift.Name__c = 'MOB MatShifts';
	            MOBMatShift.Type__c = 'Materials'; 
	            MOBMatShift.Quote__c = quote.id;                
	      		newQuoteLineItem.add(MOBMatShift);	            
	       Quote_Line_Item__c DeMOBMatShift = new Quote_Line_Item__c();
	       		DeMOBMatShift.Total__c = quote.DeMOB_Hours__c/quote.Hours_In_Shift__c;
	            DeMOBMatShift.Name__c = 'DeMOB MatShifts';
	            DeMOBMatShift.Type__c = 'Materials'; 
	            DeMOBMatShift.Quote__c = quote.id;                
	         	newQuoteLineItem.add(DeMOBMatShift);	            
	       Quote_Line_Item__c drainMatShift = new Quote_Line_Item__c();
	       		drainMatShift.Total__c = quote.Drain_Hours__c/quote.Hours_In_Shift__c;
	            drainMatShift.Name__c = 'Drain MatShifts';
	            drainMatShift.Type__c = 'Materials';
	            drainMatShift.Quote__c = quote.id;                 
	         	newQuoteLineItem.add(drainMatShift);	            
	       Quote_Line_Item__c scaleMatShift = new Quote_Line_Item__c();
	       		scaleMatShift.Total__c = quote.Scale_Hours__c/quote.Hours_In_Shift__c;
	            scaleMatShift.Name__c = 'Scale MatShifts';
	            scaleMatShift.Type__c = 'Materials';
	            scaleMatShift.Quote__c = quote.id;                 
	          	newQuoteLineItem.add(scaleMatShift);	            
	        Quote_Line_Item__c legsMatShift = new Quote_Line_Item__c();
	       		legsMatShift.Total__c = quote.Legs_Hours__c/quote.Hours_In_Shift__c;
	            legsMatShift.Name__c = 'Legs MatShifts';
	            legsMatShift.Type__c = 'Materials'; 
	            legsMatShift.Quote__c = quote.id;                
	           	newQuoteLineItem.add(legsMatShift);	            
	        Quote_Line_Item__c cribbingMatShift = new Quote_Line_Item__c();
	       		cribbingMatShift.Total__c = quote.Cribbing_Hours__c/quote.Hours_In_Shift__c;
	            cribbingMatShift.Name__c = 'Cribbing MatShifts';
	            cribbingMatShift.Type__c = 'Materials'; 
	            cribbingMatShift.Quote__c = quote.id;                
	            newQuoteLineItem.add(cribbingMatShift);	            
	        Quote_Line_Item__c vacuumMatShift = new Quote_Line_Item__c();
	       		vacuumMatShift.Total__c = quote.Vac_Truck_Hours_Refined__c/quote.Hours_In_Shift__c;
	            vacuumMatShift.Name__c = 'Vacuum MatShifts';
	            vacuumMatShift.Type__c = 'Materials'; 
	            vacuumMatShift.Quote__c = quote.id;                
	            newQuoteLineItem.add(vacuumMatShift);	            
	        Quote_Line_Item__c bottleWashMatShift = new Quote_Line_Item__c();
	       		bottleWashMatShift.Total__c = quote.Fresh_Air_Hours_Refined__c/quote.Hours_In_Shift__c;
	            bottleWashMatShift.Name__c = 'BottleWash MatShifts';
	            bottleWashMatShift.Type__c = 'Materials';
	            bottleWashMatShift.Quote__c = quote.id;                 
	            newQuoteLineItem.add(bottleWashMatShift);
			//Materials totals by type	                      	 
	        Quote_Line_Item__c pontoonMaterials = new Quote_Line_Item__c();
	       		pontoonMaterials.Total__c = (resp.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + pool.Ext__c + bags.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c + respCart.Ext__c + tyvek.Ext__c) * pontoonMatShift.Total__c;
	            pontoonMaterials.Name__c = 'Pontoon Crew Materials';
	            pontoonMaterials.Type__c = 'Crew Materials'; 
	            pontoonMaterials.Quote__c = quote.id;                
	            newQuoteLineItem.add(pontoonMaterials);   
  			Quote_Line_Item__c washMaterials = new Quote_Line_Item__c();
	       		washMaterials.Total__c = (rainGear.Ext__c  + resp.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + pool.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c + respCart.Ext__c ) * washMatShift.Total__c + plastic.Ext__c;
	            washMaterials.Name__c = 'Wash Crew Materials';
	            washMaterials.Type__c = 'Crew Materials';
	            washMaterials.Quote__c = quote.id;                 
	            newQuoteLineItem.add(washMaterials);  
	        Quote_Line_Item__c MOBMaterials = new Quote_Line_Item__c();
	       		MOBMaterials.Total__c = (gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c  + tyvek.Ext__c) * MOBMatShift.Total__c;
	            MOBMaterials.Name__c = 'MOB Crew Materials';
	            MOBMaterials.Type__c = 'Crew Materials'; 
	            MOBMaterials.Quote__c = quote.id;                
	            newQuoteLineItem.add(MOBMaterials);       
	        Quote_Line_Item__c DeMOBMaterials = new Quote_Line_Item__c();
	       		DeMOBMaterials.Total__c = (rainGear.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c  + bags.Ext__c + clean.Ext__c + tape.Ext__c ) * DeMOBMatShift.Total__c;
	            DeMOBMaterials.Name__c = 'DeMOB Crew Materials';
	            DeMOBMaterials.Type__c = 'Crew Materials';
	            DeMOBMaterials.Quote__c = quote.id;                 
	            newQuoteLineItem.add(DeMOBMaterials);       
	        Quote_Line_Item__c drainMaterials = new Quote_Line_Item__c();
	       		drainMaterials.Total__c = (gloves.Ext__c + earPlugs.Ext__c) * drainMatShift.Total__c;
	            drainMaterials.Name__c = 'Drain Crew Materials';
	            drainMaterials.Type__c = 'Crew Materials'; 
	            drainMaterials.Quote__c = quote.id;                
	            newQuoteLineItem.add(drainMaterials);          
	        Quote_Line_Item__c scaleMaterials = new Quote_Line_Item__c();
	       		scaleMaterials.Total__c = (rainGear.Ext__c + resp.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c + pool.Ext__c + bags.Ext__c + clean.Ext__c + tape.Ext__c + horn.Ext__c) * scaleMatShift.Total__c;
	            scaleMaterials.Name__c = 'Scale Crew Materials';
	            scaleMaterials.Type__c = 'Crew Materials';
	            scaleMaterials.Quote__c = quote.id;                 
	            newQuoteLineItem.add(scaleMaterials);    
	        Quote_Line_Item__c legsMaterials = new Quote_Line_Item__c();
	       		legsMaterials.Total__c = (gloves.Ext__c + earPlugs.Ext__c + water.Ext__c  + clean.Ext__c + tyvek.Ext__c) * legsMatShift.Total__c;
	            legsMaterials.Name__c = 'Legs Crew Materials';
	            legsMaterials.Type__c = 'Crew Materials';
	            legsMaterials.Quote__c = quote.id;                 
	            newQuoteLineItem.add(legsMaterials);       
	        Quote_Line_Item__c cribbingMaterials = new Quote_Line_Item__c();
	       		cribbingMaterials.Total__c = (rainGear.Ext__c + gloves.Ext__c + earPlugs.Ext__c + water.Ext__c) * cribbingMatShift.Total__c + cblock.Ext__c;
	            cribbingMaterials.Name__c = 'Cribbing Crew Materials';
	            cribbingMaterials.Type__c = 'Crew Materials'; 
	            cribbingMaterials.Quote__c = quote.id;                
	            newQuoteLineItem.add(cribbingMaterials);  
   			Quote_Line_Item__c vacuumMaterials = new Quote_Line_Item__c();
	       		vacuumMaterials.Total__c = (gloves.Ext__c + water.Ext__c) * vacuumMatShift.Total__c + vtruckWash.Ext__c;
	            vacuumMaterials.Name__c = 'Vacuum Crew Materials';
	            vacuumMaterials.Type__c = 'Crew Materials';
	            vacuumMaterials.Quote__c = quote.id;                 
	            newQuoteLineItem.add(vacuumMaterials);  
       
       		//labor
       		FX5__Price_Book_Item__c mrateData = list_PriceBookItems.get('mrate');        
	         
	        
       		Quote_Line_Item__c pontoonLabor = new Quote_Line_Item__c();
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
       			else if (quote.Hours_In_Shifts__c == 12){
       				pontoonLabor.Total__c = quote.Pontoon_Crew__c * quote.Pontoon_Hours__c;
       			}*/
       			pontoonLabor.Total__c = quote.Pontoon_Crew__c * quote.Pontoon_Hours__c * mrateData.Hourly__c;       			       			
	            pontoonLabor.Name__c = 'Pontoon Labor';
	            pontoonLabor.Type__c = 'Labor'; 
	            pontoonLabor.Quote__c = quote.id;                
	            newQuoteLineItem.add(pontoonLabor); 
       		Quote_Line_Item__c washLabor = new Quote_Line_Item__c();
       			washLabor.Total__c = quote.Wash_Crew__c * quote.Wash_Hours__c *mrateData.Hourly__c;
	            washLabor.Name__c = 'Wash Labor';
	            washLabor.Type__c = 'Labor';  
	            washLabor.Quote__c = quote.id;               
	            newQuoteLineItem.add(washLabor);
       		Quote_Line_Item__c hotWashLabor = new Quote_Line_Item__c();
       			hotWashLabor.Total__c = quote.HotWash_Crew__c * quote.HotWash_Hours__c * mrateData.Hourly__c;
	            hotWashLabor.Name__c = 'HotWash Labor';
	            hotWashLabor.Type__c = 'Labor';
	            hotWashLabor.Quote__c = quote.id;                 
	            newQuoteLineItem.add(hotWashLabor);
       		Quote_Line_Item__c MOBLabor = new Quote_Line_Item__c();       			
       			MOBLabor.Total__c = quote.MOB_Crew__c * quote.MOB_Hours__c * 44;
	            MOBLabor.Name__c = 'MOB Labor';
	            MOBLabor.Type__c = 'Labor';
	            MOBLabor.Quote__c = quote.id;                 
	            newQuoteLineItem.add(MOBLabor);
       		Quote_Line_Item__c DeMOBLabor = new Quote_Line_Item__c();       		
       			DeMOBLabor.Total__c = quote.DeMOB_Crew__c * quote.DeMOB_Hours__c * mrateData.Hourly__c;
	            DeMOBLabor.Name__c = 'DeMOB Labor';
	            DeMOBLabor.Type__c = 'Labor';
	            DeMOBLabor.Quote__c = quote.id;                 
	            newQuoteLineItem.add(DeMOBLabor);
       		Quote_Line_Item__c drainLabor = new Quote_Line_Item__c();
       			drainLabor.Total__c = quote.Drain_Crew__c * quote.Drain_Hours__c * mrateData.Hourly__c;
	            drainLabor.Name__c = 'Drain Labor';
	            drainLabor.Type__c = 'Labor'; 
	            drainLabor.Quote__c = quote.id;                
	            newQuoteLineItem.add(drainLabor);
       		Quote_Line_Item__c scaleLabor = new Quote_Line_Item__c();
       			scaleLabor.Total__c = quote.Scale_Crew__c * quote.Scale_Hours__c * mrateData.Hourly__c;
	            scaleLabor.Name__c = 'Scale Labor';
	            scaleLabor.Type__c = 'Labor';
	            scaleLabor.Quote__c = quote.id;                 
	            newQuoteLineItem.add(scaleLabor);
       		Quote_Line_Item__c legsLabor = new Quote_Line_Item__c();
       			legsLabor.Total__c = quote.Legs_Crew__c * quote.Legs_Hours__c * mrateData.Hourly__c;
	            legsLabor.Name__c = 'Legs Labor';
	            legsLabor.Type__c = 'Labor';  
	            legsLabor.Quote__c = quote.id;               
	            newQuoteLineItem.add(legsLabor);
       		Quote_Line_Item__c cribbingLabor = new Quote_Line_Item__c();
       			cribbingLabor.Total__c = quote.Cribbing_Crew__c * quote.Cribbing_Hours__c * mrateData.Hourly__c;
	            cribbingLabor.Name__c = 'Cribbing Labor';
	            cribbingLabor.Type__c = 'Labor';
	            cribbingLabor.Quote__c = quote.id;                 
	            newQuoteLineItem.add(cribbingLabor);
       		Quote_Line_Item__c vacuumLabor = new Quote_Line_Item__c();
       			vacuumLabor.Total__c = quote.Vac_Truck_Crew__c * quote.Vac_Truck_Hours_Refined__c * mrateData.Hourly__c;
	            vacuumLabor.Name__c = 'Vacuum Labor';
	            vacuumLabor.Type__c = 'Labor';
	            vacuumLabor.Quote__c = quote.id;                 
	            newQuoteLineItem.add(vacuumLabor);
       		Quote_Line_Item__c bottleWashLabor = new Quote_Line_Item__c();
       		system.debug('*******************************in bottlewash  crew==' + quote.BottleWash_Crew__c + '    hours=====' + quote.BottleWash_Hours__c + '    mrate.hourly====== ' + mrateData.Hourly__c);
       			//bottleWashLabor.Total__c = quote.BottleWash_Crew__c * quote.BottleWash_Hours__c * mrateData.Hourly__c;
	            bottleWashLabor.Total__c = quote.BottleWash_Crew__c * quote.Fresh_Air_Hours_Refined__c * mrateData.Hourly__c;
	            bottleWashLabor.Name__c = 'BottleWash Labor';
	            bottleWashLabor.Type__c = 'Labor';
	            bottleWashLabor.Quote__c = quote.id;                 
	            newQuoteLineItem.add(bottleWashLabor);
	            
       		insert newQuoteLineItem;
       		       		       		 
	 		//RecursiveTriggerHandler.insertNotDone = false;

       }
 	RecursiveTriggerHandler.insertNotDone = false;
	}//end for loop
	Quote_RE__c q = [SELECT id,Job_Type__c, Lump_Sum_Total__c,Total_Equipment_Billing__c,Total_Materials_Billing__c,
		Total_Labor_Billing__c,Rescue_Billing__c,Total_Tech_PerDiem__c,Rescue_PerDiem__c,Equipment_Hourly__c,
		Materials_Job__c,Refined_Labor__c,Degas_Support_Refined__c 
		FROM Quote_RE__c WHERE Id IN :Trigger.new];
	if(q.Job_Type__c == 'Crude'){
		q.Lump_Sum_Total__c = q.Total_Equipment_Billing__c +  q.Total_Materials_Billing__c +  q.Total_Labor_Billing__c +  q.Rescue_Billing__c + q.Total_Tech_PerDiem__c +  q.Rescue_PerDiem__c;
	}
	else{
		 q.Lump_Sum_Total__c = q.Equipment_Hourly__c +  q.Materials_Job__c +  q.Refined_Labor__c + q.Rescue_Billing__c + q.Total_Tech_PerDiem__c  + q.Degas_Support_Refined__c;          
	}
	update q;
	
	/*if(Trigger.isAfter){
		
		
		
		quote.Lump_Sum_Total__c = quote.Total_Equipment_Billing__c +  quote.Total_Materials_Billing__c +  quote.Total_Labor_Billing__c +  quote.Rescue_Billing__c + quote.Total_Tech_PerDiem__c +  quote.Rescue_PerDiem__c;
            quote.Lump_Sum_Cost__c = quote.Total_Equipment_Costs__c + quote.Total_Materials_Costs__c + quote.Total_Labor_Costs__c + quote.Rescue_Cost__c + quote.Total_Tech_PerDiem__c + quote.Rescue_PerDiem__c;
            quote.Lump_Sum_Difference__c = quote.Lump_Sum_Total__c - quote.Lump_Sum_Cost__c;*/
		
	
    
      
}