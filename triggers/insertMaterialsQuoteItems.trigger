trigger insertMaterialsQuoteItems on Quote_RE__c (after insert, after update) {
    //update and insert quote line item values from custom setting
    LIST<Quote_Line_Item__c> newQuoteLineItem = new LIST<Quote_Line_Item__c>();
         for(Quote_RE__c quote : Trigger.new){
        Decimal tankDiameter = quote.Tank_Diameter__c;
        //String locationEntered = quote.Location__c;
        REFERENCE__c baseReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'BASE')]);
        REFERENCE__c middleReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'MID')]);
        REFERENCE__c topReference = ([SELECT id, AHOSE__c,BAGS__c,BLINDING__c,CATEGORY__c,CBLOCK__c,CLEAN__c,CLEANUP_EO__c,CLEANUP_FOREMEN__c,CLEANUP_LABOR__c,CLEANUP_SUP__c,CLEANUP_TECHS__c,CP20__c,CRIBBING_EO__c,CRIBBING_FOREMEN__c,CRIBBING_LABOR__c,CRIBBING_SUP__c,CRIBCREW__c,CRIBHOURS__c,DE__c,DECK__c,DS__c,FIXED__c,FLANGEHOSE__c,FLIGHT__c,FRESH__c,GASMETER__c,GLOVES__c,GROUND__c,H2S__c,HORN__c,HOTGM__c,JETPUMP__c,LVS__c,M15__c,M30__c,MINS__c,PLASTIC__c,PLUGS__c,POOL__c,PW__c,PWFCLEAN__c,PWHOSE__c,RAGS__c,RESP__c,RG__c,RIGDOWN__c,RIGUP__c,RING__c,RMC__c,SCANON__c,SEALREMOVE__c,SEALWASH__c,SETLEGS__c,SIGS__c,SUPTRUCK__c,TANKSWEEP__c,TAPE__c,TLIGHT__c,TRASHPUMP__c,TRUCK__c,TYPE__c,TYVEK__c,VACHOSE__c,WATER__c,WHOSE__c,X185AC__c,X375AC__c FROM REFERENCE__c WHERE (DS__c <=: TankDiameter AND DE__c >=: TankDiameter) AND (TYPE__c =: 'TOP')]);
       
    //Materials data
        MATERIALS_QUOTE_ITEMS__c tyvekData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Tyvek']);
        MATERIALS_QUOTE_ITEMS__c plasticData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Plastic']);
        MATERIALS_QUOTE_ITEMS__c respData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Respirators']);
        MATERIALS_QUOTE_ITEMS__c glovesData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Gloves']);
        MATERIALS_QUOTE_ITEMS__c earPlugsData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Ear Plugs']);
        MATERIALS_QUOTE_ITEMS__c waterData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Water']);
        MATERIALS_QUOTE_ITEMS__c kittyPoolData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Kitty Pools']);
        MATERIALS_QUOTE_ITEMS__c plasticBagData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Plastic Bags']);
        MATERIALS_QUOTE_ITEMS__c handCleanerData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Hand Cleaner']);
        MATERIALS_QUOTE_ITEMS__c ductTapeData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Duct Tape']);
        MATERIALS_QUOTE_ITEMS__c airHornData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Air Horn']);
        MATERIALS_QUOTE_ITEMS__c ragsData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Rags']);
        MATERIALS_QUOTE_ITEMS__c rainGearData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Rain Gear']);
        MATERIALS_QUOTE_ITEMS__c cribBlockData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Cribbing Blocks']);
        MATERIALS_QUOTE_ITEMS__c respCartData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Respirator Cartridge']);
        MATERIALS_QUOTE_ITEMS__c vacTruckWashData = ([SELECT id, Name, CP__c, BP__c FROM MATERIALS_QUOTE_ITEMS__c WHERE Name = 'Vac Truck Wash']);
     insert newQuoteLineItem;
        //update quote;
       }
}