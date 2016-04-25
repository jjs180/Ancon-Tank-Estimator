trigger UpdateQuoteNumbers on Quote_RE__c (before insert, before update) {
    /*if(RecursiveTriggerHandler.isFirstTime){
        system.debug('************************************************* Is First time?====' + RecursiveTriggerHandler.isFirstTime);
        RecursiveTriggerHandler.isFirstTime = false;*/
   
        
    for(Quote_RE__c quote : Trigger.new){
        system.debug('***************************************************************************jobtype  1  ====  ' + quote.Job_Type__c);
        if(quote.Job_Type__c == 'Crude'){
            
            system.debug('***************************************************************************jobtype should be crude  ====  ' + quote.Job_Type__c);
            /*system.debug(quote.Tank_Diameter__c+'=========tankDiameter');
            system.debug(quote.Hours_In_Shift__c+'=========hoursPerShift');
            system.debug(quote.Location__c+'=========location');
            system.debug(quote.Pontoon_Type__c+'=========pontoonType');
            system.debug(quote.Clean_Pontoon__c+'=========cleanPontoon');
            system.debug(quote.Vacum_Trucks__c+'=========vacumTrucks');
            system.debug(quote.Truck_Size__c+'=========truckSize');
            system.debug(quote.Drain_Method__c+'=========drainMethod');
            system.debug(quote.Product__c+'=========product');
            system.debug(quote.Product_Above_5_Ft__c+'=========productAbove5ft');
            system.debug(quote.Remaining_Ft__c+'=========remainingFt');
            system.debug(quote.Remaining_In__c+'=========remainingIn');
            system.debug(quote.Roof_Access__c+'=========roofAccess');
            system.debug(quote.Entry_Cleaning_Required__c+'=========entryCleaningRequired');
            system.debug(quote.Treatment_Needed__c+'=========treatmentNeeded');
            system.debug(quote.Remove_Seal__c+'=========removeSeal');
            system.debug(quote.Clean_Seal__c+'=========cleanSeal');
            system.debug(quote.Rescue_Team__c+'=========rescueTeam');
            system.debug(quote.Set_Legs__c+'=========setLegs');
            system.debug(quote.Cribbing__c+'=========cribbing');
            system.debug(quote.Degas_Support__c+'=========degasSupport');
            system.debug(quote.Degas_Support_Hours__c+'=========degasSupportHours');
            system.debug(quote.FracTanks__c+'=========fracTanks');
            system.debug(quote.FracTanks_Needed__c+'=========fracTanksNeeded');
            system.debug(quote.Vacum_Truck_Support__c+'=========vacuumTruckSupport');
            system.debug(quote.vFracDrainDown__c+'=========vFracDrainDown');
            system.debug(quote.vFracSkimming__c+'=========vFracSkimming');
            system.debug(quote.vFinalWash__c+'=========vFinalWash');
            system.debug(quote.vBlinding__c+'=========vBlinding');
            system.debug(quote.vDegas__c+'=========vDegas');
            system.debug(quote.vSeal_Cleaning__c+'=========vSealCleaning');
            system.debug(quote.vPontoon_Cleaning__c+'=========vPontoonCleaning');
            system.debug(quote.Notes__c +'=========notes');*/
            
            
            
            Decimal tankDiameter = quote.Tank_Diameter__c;
            String locationEntered = quote.Location__c;
            REFERENCE__c baseReference = ([SELECT id, DS__c, DE__c, RIGUP__c,RIGDOWN__c,CLEANUP_TECHS__c,RING__c,DECK__c,FIXED__c,SEALREMOVE__c,SEALWASH__c,BLINDING__c,PWFCLEAN__c,CRIBHOURS__c,SETLEGS__c,CBLOCK__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'BASE')]);
            REFERENCE__c middleReference = ([SELECT id, DS__c, DE__c, RIGUP__c,RIGDOWN__c,CLEANUP_TECHS__c,RING__c,DECK__c,FIXED__c,SEALREMOVE__c,SEALWASH__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'MID')]);
            REFERENCE__c topReference = ([SELECT id, DS__c, DE__c, RIGUP__c,RIGDOWN__c,CLEANUP_TECHS__c,RING__c,DECK__c,FIXED__c,SEALREMOVE__c,SEALWASH__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'TOP')]);
            LOCATION__c location = ([SELECT id, Name, PERDIEM__c, TRAVELTIME__c, FRESHAIR__c, GASMETERS__c FROM LOCATION__c WHERE Name =: locationEntered]);
           
            
            quote.Rig_Up__c = baseReference.RIGUP__c;
            quote.Rig_Down__c = baseReference.RIGDOWN__c;
            quote.Base_Techs__c = baseReference.CLEANUP_TECHS__c;
            quote.Middle_Techs__c = middleReference.CLEANUP_TECHS__c;
            quote.Top_Techs__c = topReference.CLEANUP_TECHS__c;
            IF(quote.Entry_Cleaning_Required__c == TRUE){
                system.debug('****************************************************************entry required');
                IF(quote.Pontoon_Type__c == 'Ring'){
                    system.debug('***********************************************************pontoon type ring');
                    IF(quote.Clean_Pontoon__c== TRUE){
                        system.debug('*****************************************************clean pontoon true');
                        quote.Pontoon__c = baseReference.RING__c;
                        system.debug('********************************************************baseReference.Ring__c==============' + baseReference.RING__c);                    
                    }
                    ELSE{
                        quote.Pontoon__c=0;
                    }
                }
                IF(quote.Pontoon_Type__c == 'Full Deck'){
                    IF(quote.Clean_Pontoon__c== TRUE){
                        quote.Pontoon__c = baseReference.DECK__c;                  
                    }
                    ELSE{
                        quote.Pontoon__c = 0;
                    }
                }
                IF(quote.Pontoon_Type__c =='Fixed'){
                    quote.Pontoon__c = baseReference.FIXED__c;
                }            
            }
            ELSE{
                    quote.Pontoon__c=0;
            }
            IF(quote.Remove_Seal__c == TRUE){
                quote.Seal_Removal__c = baseReference.SEALREMOVE__c;
            }
            ELSE{
                quote.Seal_Removal__c = 0;
            }
            IF(quote.Clean_Seal__c == TRUE){
                quote.Seal_Cleaning__c = baseReference.SEALWASH__c;
            }
            ELSE{
                quote.Seal_Cleaning__c = 0;
            }
            IF(quote.Entry_Cleaning_Required__c == TRUE){
                quote.Final_Wash_Hours__c = baseReference.PWFCLEAN__c;
            }
            ELSE{
                quote.Final_Wash_Hours__c = 0;
            }
            IF(quote.Cribbing__c == TRUE){
                quote.Cribbing_Hours__c = baseReference.CRIBHOURS__c;
            }
            ELSE{
                quote.Cribbing_Hours__c = 0;
            }
            system.debug('*************************************************setlegs======' + quote.Set_Legs__c);
            IF(quote.Set_Legs__c == TRUE){
                system.debug('*******************************************setlegs true');
                quote.Leg_Hours__c = baseReference.SETLEGS__c;
            }
            ELSE{
                quote.Leg_Hours__c = 0;
            }
            quote.Blinding_Hours__c = baseReference.BLINDING__c;
            IF(quote.Cribbing__c == TRUE){
                quote.Cribbing_Towers__c = baseReference.CBLOCK__c;
            }
            ELSE{
                quote.Cribbing_Towers__c = 0;
            }
            quote.Fresh_Air_Location__c = location.FRESHAIR__c;
            IF(quote.Fresh_Air_Location__c == TRUE){
                quote.Fresh_Air_Needed__c = TRUE;
            }
            ELSE{
                quote.Fresh_Air_Needed__c = FALSE;
            }
            quote.GasMeters_Location__c = location.GASMETERS__c;
            quote.vPontoon_Cleaning_Middle_Value__c =  quote.vFrac_Drain_Down_Value__c +  quote.vFrac_Skimming_Value__c +  quote.vFinal_Wash_Value__c +  quote.vBlinding_Value__c +  quote.vDegas_Value__c +  quote.vEntry_Sludge_Removal_Value__c +  quote.vSeal_Cleaning_Value__c +  quote.vPontoon_Cleaning_Value__c;
        
            Decimal toround = quote.Base_Shifts__c + quote.Middle_Shifts__c + quote.Top_Shifts__c + quote.Non_Drain_Shifts__c + .5;
            Decimal rounded = toround.setScale(0);
            //Decimal rounded = toround.setScale(2,RoundingMode.HALF_UP);
            quote.Total_Shifts__c = rounded;
            //quote.Total_Shifts__c = ROUND(quote.Base_Shifts__c + quote.Middle_Shifts__c + quote.Top_Shifts__c+0.5,0);
            quote.Per_Diem_Base__c = location.PERDIEM__c;
            quote.Per_Diem_Middle__c = location.PERDIEM__c;
            quote.Per_Diem_Top__c = location.PERDIEM__c;
            quote.Lump_Sum_Total__c = quote.Total_Equipment_Billing__c +  quote.Total_Materials_Billing__c +  quote.Total_Labor_Billing__c +  quote.Rescue_Billing__c + quote.Total_Tech_PerDiem__c +  quote.Rescue_PerDiem__c;
            quote.Lump_Sum_Cost__c = quote.Total_Equipment_Costs__c + quote.Total_Materials_Costs__c + quote.Total_Labor_Costs__c + quote.Rescue_Cost__c + quote.Total_Tech_PerDiem__c + quote.Rescue_PerDiem__c;
            quote.Lump_Sum_Difference__c = quote.Lump_Sum_Total__c - quote.Lump_Sum_Cost__c;
        }
        if(quote.Job_Type__c == 'Refined'){
            Decimal tankDiameter = quote.Tank_Diameter__c;
            String locationEntered = quote.Location__c;
            REFERENCE__c refinedReference = ([SELECT id,TYPE__C,DS__c,DE__c,TECHS__C,PTFIXED__C,PTRING__C,PTDECK__C,WASH__C,TRUCK__C,X185AC__C,X375AC__C,
                HOTWASH__C,HOTEO__C,HOTGM__C,FRESH__C,AHOSE__C,GROUND__C,GASMETER__C,VACHOSE__C,WHOSE__C,JETPUMP__C,GAMAJ__C,CP20__C,TLIGHT__C,FLIGHT__C,
                H2S__C,M15__C,RG__C,PLASTIC__C,RESP__C,GLOVES__C,PLUGS__C,  WATER__C,POOL__C,BAGS__C,CLEAN__C,TAPE__C,HORN__C,STEM__C,MOB__C,WASHRATE__C,LEGCREW__C,
                SETLEGS__C,CRIBHOURS__C,CRIBTOWERS__C FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'Refined')]);
            REFERENCE__c scaleReference = ([SELECT id, SCALE__c, SCALE_HOURS__c FROM REFERENCE__c WHERE SCALE__c =: quote.Barrels_Scale__c]);
            LOCATION__c location = ([SELECT id, Name, BOTTLEWASH__C, FRESHAIR_REFINED__C, GASMETERQTY__C, HOLEWATCH__C, M30__C, MOB_HOURS__C, WASH__C, PERDIEM__c, TRAVELTIME__c, FRESHAIR__c, GASMETERS__c FROM LOCATION__c WHERE Name =: locationEntered]);
           
            quote.Pontoon_Crew__c = refinedReference.TECHS__c;
            if(quote.Pontoon_Type__c == 'Ring'){
                if(quote.Clean_Pontoon__c == true){
                    quote.Pontoon_Hours__c = refinedReference.PTRING__C;
                }
                else{
                    quote.Pontoon_Hours__c = 0;
                }
            }
            else if(quote.Pontoon_Type__c == 'Deck'){
                if(quote.Clean_Pontoon__c == true){
                    quote.Pontoon_Hours__c = refinedReference.PTDECK__C;
                }
                else{
                    quote.Pontoon_Hours__c = 0;
                }
            }
            else if(quote.Pontoon_Type__c == 'Fixed'){
                quote.Pontoon_Hours__c = refinedReference.PTFIXED__C;
            }
            else{
                quote.Pontoon_Hours__c = 0;
            }
            quote.Wash_Hours__c = refinedReference.WASH__C;
            quote.Scale_Hours__c = scaleReference.SCALE_Hours__C;
            if(quote.Wash_Type__c == 'Hot'){
                quote.HotWash_Crew__c = refinedReference.HOTEO__C;
            }
            else{
                quote.HotWash_Crew__c = 0;
            }
            quote.MOB_Crew__c = refinedReference.TECHS__c;
            quote.HotWash_Hours__c = refinedReference.WASH__C;
            quote.MOB_Hours__c = refinedReference.MOB__C + location.MOB_HOURS__C;
            quote.DeMOB_Crew__c = refinedReference.TECHS__c;
            quote.DeMOB_Hours__c = refinedReference.MOB__C + location.MOB_HOURS__C;
            if(location.FRESHAIR_REFINED__C = true){
                quote.Fresh_Air_Location__c = true;
            }
            quote.Base_Crew__c = refinedReference.TECHS__c;
            quote.Wash_Crew__c = refinedReference.PTFIXED__C;
            if(quote.Set_Legs__c = true){
                quote.Legs_Crew__c = refinedReference.LEGCREW__C;
            }
            else{
                quote.Legs_Crew__c = 0;
            }
            if(quote.Set_Legs__c = true){
                quote.Legs_Hours__c = refinedReference.SETLEGS__C;
            }
            else{
                quote.Legs_Hours__c = 0;
            }
            if(quote.Product__c == 'Diesel'){
                quote.Fresh_Air_Needed__c = true;
            }
            else{
                if(quote.Fresh_Air_Location__c == true){
                    quote.Fresh_Air_Needed__c = true;
                }
                else{
                    quote.Fresh_Air_Needed__c = true;
                }
            }
            if(quote.Set_Legs__c == true){
                quote.Cribbing_Crew__c = refinedReference.SETLEGS__C;
            }
            else{
                quote.Cribbing_Crew__c = 0;
            }
            if(quote.Cribbing__c == true){
                quote.Cribbing_Hours__c = refinedReference.CRIBHOURS__C;
            }
            else{
                quote.Cribbing_Hours__c = 0;
            }
            if(quote.Cribbing__c == true){
                quote.Cribbing_Towers__c = refinedReference.CRIBTOWERS__C;
            }
            else{
                quote.Cribbing_Towers__c = 0;
            }
            quote.Fresh_Air_Shifts__c = refinedReference.FRESH__C;
            quote.Vaccum_Hours__c = refinedReference.WASH__c + quote.DeMOB_Crew__c;
            if(quote.Fresh_Air_Needed__c == false){
                quote.BottleWash_Hours__c = 0;
            }
            else{
                quote.BottleWash_Hours__c = quote.Fresh_Air_Hours_Refined__c;
            }
            if(quote.Rescue_Team__c == '2 Man Team'){
                quote.Rescue_Rate_Refined__c = 140;
            }
            else if(quote.Rescue_Team__c == '3 Man Team'){
                quote.Rescue_Rate_Refined__c = 155;
            }
            else{
                quote.Rescue_Rate_Refined__c = 0;
            }
            quote.Total_Shifts__c = quote.Total_Hours__c/quote.Hours_In_Shift__c;
            quote.GasMeters_Location__c = location.GASMETERS__c;
            quote.GasMeters_Tank__c =  refinedReference.GASMETER__C;
            quote.Location_WashType__c = location.WASH__C;
            if(quote.Location_WashType__c == 'Hot'){
                quote.Final_WashType__c = 'Hot';
            }
            else{
                quote.Final_WashType__c = quote.Wash_Type__c;
            }
            if(quote.Final_WashType__c == 'Hot'){
                quote.GasMeters_HotWash__c = refinedReference.HOTGM__C;
            }
            else{
                quote.GasMeters_HotWash__c = 0;
            }
            quote.Steamer_Tank__c = refinedReference.STEM__C;
            quote.Techs__c = refinedReference.TECHS__c + quote.HotWash_Crew__c + quote.Vacum_Trucks__c + quote.BottleWash_Crew__c;
            quote.Vac_Truck_Hours_Refined__c = refinedReference.WASH__C + quote.DeMob_Hours__c;
            
            //formula value of Rescue_Billing__c and Rescue_Techs__c not available during before insert context
            integer rescueTechs = 0;
            if(quote.Rescue_Team__c == '2 Man Team'){
                quote.Rescue_PerDiem_Refined__c = 2 * quote.PerDiem__c * quote.Fresh_Air_Shifts__c;
                rescueTechs=2;
            }
            else if(quote.Rescue_Team__c == '3 Man Team'){
                quote.Rescue_PerDiem_Refined__c = 3 * quote.PerDiem__c * quote.Fresh_Air_Shifts__c;
                rescueTechs=3;
            }
            else{
                quote.Rescue_PerDiem_Refined__c = 0;
            }
            FX5__Price_Book_Item__c dgRateData = ([SELECT id, Hourly__c FROM FX5__Price_Book_Item__c WHERE FX5__Price_Book__c =: quote.Price_Book__c AND FX5__Catalog_Item_Code__c =: 'DGRate']);        
            if(quote.Degas_Support__c = true){        
                quote.Degas_Support_Refined__c = quote.Degas_Support_Hours__c * dgRateData.Hourly__c;
                system.debug('dgrate ========================           ' + dgRateData.Hourly__c + '    degas support refined=========' + quote.Degas_Support_Refined__c);
            }
            system.debug('Total Refined Equipment Hourly====' + quote.Equipment_Hourly__c);
            system.debug('Total Refined Materials Job====' + quote.Materials_Job__c);
            system.debug('Total Refined Labor====' + quote.Refined_Labor__c);
            //system.debug('Total Refined Rescue billing====' + quote.Rescue_Billing__c);
            system.debug('Total Tech PerDiem====' + quote.Total_Tech_PerDiem__c);
            system.debug('Total Rescue PerDiem====' + quote.Rescue_PerDiem__c);
            //quote.Lump_Sum_Total__c = quote.Total_Equipment_Billing__c +  quote.Total_Materials_Billing__c +  quote.Total_Labor_Billing__c +  quote.Rescue_Billing__c + quote.Total_Tech_PerDiem__c +  quote.Rescue_PerDiem__c;
            

            double rescueRefinedAmount = rescueTechs * quote.BottleWash_Hours__c * quote.Rescue_Rate_Refined__c;  //Rescue_Hours_Refined__c is just BottleWash_Hours__c
            system.debug('Total Refined Calculated RescueAmount====' + rescueRefinedAmount);

            quote.Lump_Sum_Total__c = quote.Equipment_Hourly__c +  quote.Materials_Job__c +  quote.Refined_Labor__c + rescueRefinedAmount + quote.Total_Tech_PerDiem__c +  quote.Rescue_PerDiem__c + quote.Degas_Support_Refined__c;
            system.debug('Refined Total Lump sum====' + quote.Lump_Sum_Total__c);   
        }
    }
    /*}
    ELSE{
        system.debug('already ran');
        return;
    }*/
}