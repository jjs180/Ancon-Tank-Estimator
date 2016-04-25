public class QuoteController {
	//public Id quoteId{get;set;}
	public static Date jobDate{get;set;}
	public string userName{get;set;}
    public string companyName{get;set;}   
    public static string contactId{get;set;}
    public static string userId{get;set;}
    public Id quoteId{get;set;}
    public Contact currentContact{get;set;}
    public static Id companyId{get;set;}
    //public static Date estimatedStartDate{get;set;}    
    public static Id officeId{get;set;}
    public static string accountType{get;set;}
    public static String contactId2{get;set;}
    public static User currentUser{get;set;}
    public string selectedProject{get;set;}
    
    public Id quoteSFId{get;set;}
    
    
    public QuoteController (){            
       	quoteSFId = ApexPages.currentPage().getParameters().get('qId');
       	userId = UserInfo.getUserId() ;
      
        currentUser  = [SELECT id, firstName, lastName, Account.Name, ContactId, AccountId FROM User WHERE Id =: userId];
       	contactId = currentUser.ContactId;
       	//contactId = apexpages.currentpage().getparameters().get('cid');
       	//Contact currentContact = [SELECT id, firstName, lastName, Account.Name, AccountId,FX5__Office__c FROM Contact WHERE Id =: contactId];
       	
        Contact currentContact = [SELECT id, Name, firstName, lastName, Account.Name, AccountId FROM Contact WHERE Id =: currentUser.ContactId];
    	userName = currentContact.firstName + ' ' + currentContact.lastName;
    	companyName = currentContact.Account.Name;
    	companyId = currentContact.AccountId;
    	//estimatedStartDate = jobDate;
    	//officeId = currentContact.FX5__Office__c;
    	Account currentAccount = [SELECT id, Type FROM Account WHERE Id=: companyId];
    	accountType = currentAccount.Type; 
    	If (jobDate == null){
    		jobDate = Date.today();
    	} 
    	//estimatedStartDate = jobDate;                 
    }
    public List<Quote_RE__c> getQuotes(){
    	return [SELECT Id, Name, Tank__c,Status__c,PO__c,Account__c, Account__r.Name, Location__c, Lump_Sum_Total__c,Purchase_Order_RE__c,Days__c FROM Quote_RE__c WHERE Account__c =: companyId ];
    }
    public List<Project__c> getProjects(){
    	return [SELECT Id, Name, Tank__c, Location__c,Days__c,Actual_Days__c,Change_Order__c,Account__c,Account__r.Name, PO_Amount__c, Quote__c,PO__c FROM Project__c WHERE Account__c =: companyId];
    }
    public List<Quote_RE__c> getAcceptedQuotes(){
    	return [SELECT Id, Name, Tank__c,Status__c,PO__c,Account__c,Location__c, Lump_Sum_Total__c,Purchase_Order_RE__c,Days__c FROM Quote_RE__c WHERE Account__c =: companyId AND Status__c =: 'Accepted'];
    }
     public List<Quote_RE__c> getSubmittedQuotes(){
    	return [SELECT Id, Name, Tank__c,Status__c,PO__c,Account__c,Location__c, Lump_Sum_Total__c,Purchase_Order_RE__c,Days__c FROM Quote_RE__c WHERE Account__c =: companyId AND Status__c =: 'Quoted'];
    }
    public PageReference goToQuotes(){
    	contactId2 = apexpages.currentpage().getparameters().get('cid');
    	PageReference pr = Page.Quote;
    	pr.getParameters().put('cid', contactId2);
    	pr.setRedirect(true);
    	return pr;
    } 
    public PageReference goToTankEstimator(){
    	contactId2 = apexpages.currentpage().getparameters().get('cid');
    	PageReference pr = Page.Tank_Estimator;
    	pr.getParameters().put('cid', contactId2);
    	pr.setRedirect(true);
    	return pr;
    }
     public PageReference goToTankProjects(){
     	contactId2 = apexpages.currentpage().getparameters().get('cid');
    	PageReference pr = Page.Projects;
    	pr.getParameters().put('cid', contactId2);
    	pr.setRedirect(true);
    	return pr;
    }
     public PageReference goToMain(){
     	contactId2 = apexpages.currentpage().getparameters().get('cid');
    	PageReference pr = Page.Main;
    	pr.getParameters().put('cid', contactId2);
    	pr.setRedirect(true);
    	return pr;
    }
    public PageReference editProject(){
    	PageReference pr = Page.editProject;
    	system.debug('****************************** selectedprojectid============   ' + selectedProject);
    	pr.getParameters().put('id', selectedProject);
    	pr.setRedirect(true);
    	return pr;
    	
    }

            
    //rhys hardin id= 003P000000gE8UV
    @RemoteAction
    public static object calculateQuote(string passedId,Map<string,string> quoteDetails,Map<string,boolean> quoteDetails2){
    	Quote_RE__c q = new Quote_RE__c();
    	Contact currentContact = [SELECT id, Name, AccountId, Email FROM Contact WHERE Id=: passedId];
    	FX5__Price_Book__c crudePriceBook = [SELECT id, Name FROM FX5__Price_Book__c WHERE Name = 'Crude Tank Tool'];
    	FX5__Price_Book__c refinedPriceBook = [SELECT id, Name FROM FX5__Price_Book__c WHERE Name = 'Refined Tank Tool'];
    	system.debug('****************************************************pricebook id=================  ' + crudePriceBook.Id + '      jobtype===    ' + quoteDetails.get('jobType'));
    	//both tools use these
    	q.Account__c = currentContact.AccountId;
    	q.Job_Type__c = quoteDetails.get('jobType');    	
		q.Tank_Diameter__c= Integer.ValueOf(quoteDetails.get('tankDiameter'));//cannot be null
		q.Hours_In_Shift__c= Integer.ValueOf(quoteDetails.get('hoursPerShift'));//cannot be null
		q.Location__c= quoteDetails.get('location');
		q.Pontoon_Type__c= quoteDetails.get('pontoonType');
		q.Clean_Pontoon__c= quoteDetails2.get('cleanPontoon');
		q.Vacum_Trucks__c= Integer.ValueOf(quoteDetails.get('vacumTrucks'));
		q.Truck_Size__c= Integer.ValueOf(quoteDetails.get('truckSize'));//cannot be null
		q.Drain_Method__c= quoteDetails.get('drainMethod');
		q.Product__c= quoteDetails.get('product');		
		q.Contact_Email__c = currentContact.Email;		
		q.Rescue_Team__c= quoteDetails.get('rescueTeam');
		q.Set_Legs__c= quoteDetails2.get('setLegs');
		q.Cribbing__c= quoteDetails2.get('cribbing');
		q.Degas_Support__c= quoteDetails2.get('degasSupport');
		q.Degas_Support_Hours__c= Integer.ValueOf(quoteDetails.get('degasSupportHours'));
		q.Notes__c = quoteDetails.get('notes');
		If(Integer.ValueOf(quoteDetails.get('remainingIn'))!= null){
			q.Remaining_In__c= Integer.ValueOf(quoteDetails.get('remainingIn'));
		}
		else{
			q.Remaining_In__c= 0;
		}
		q.Status__c = 'Draft';
		
		if(quoteDetails.get('jobType') == 'Crude'){
			q.Price_Book__c = crudePriceBook.Id;
			q.Product_Above_5_Ft__c= quoteDetails.get('productAbove5ft');//crude only
			
			q.Roof_Access__c= quoteDetails2.get('roofAccess');
			q.Entry_Cleaning_Required__c= quoteDetails2.get('entryCleaningRequired');
			q.Treatment_Needed__c= quoteDetails2.get('treatmentNeeded');
			q.Remove_Seal__c= quoteDetails2.get('removeSeal');
			q.Clean_Seal__c= quoteDetails2.get('cleanSeal');
			q.FracTanks__c= quoteDetails2.get('fracTanks');
			q.FracTanks_Needed__c= Integer.ValueOf(quoteDetails.get('fracTanksNeeded'));
			q.Vacum_Truck_Support__c= quoteDetails2.get('vacuumTruckSupport');
			q.vFracDrainDown__c= quoteDetails2.get('vFracDrainDown');
			q.vFracSkimming__c= quoteDetails2.get('vFracSkimming');
			q.vFinalWash__c= quoteDetails2.get('vFinalWash');
			q.vBlinding__c= quoteDetails2.get('vBlinding');
			q.vDegas__c= quoteDetails2.get('vDegas');
			q.vSeal_Cleaning__c= quoteDetails2.get('vSealCleaning');
			q.vPontoon_Cleaning__c= quoteDetails2.get('vPontoonCleaning');
			If(Integer.ValueOf(quoteDetails.get('remainingFt')) != null){
				q.Remaining_Ft__c= Integer.ValueOf(quoteDetails.get('remainingFt'));//crude only
			}
			else{
				q.Remaining_Ft__c= 0;
			}			
		}
		if(quoteDetails.get('jobType') == 'Refined'){
			q.Price_Book__c = refinedPriceBook.Id;
			q.Barrels_Scale__c = quoteDetails.get('scales');
			q.Wash_Type__c = quoteDetails.get('washType');
		}
		
		/*system.debug(q.Tank_Diameter__c+'=========tankDiameter');
		system.debug(q.Hours_In_Shift__c+'=========hoursPerShift');
		system.debug(q.Location__c+'=========location');
		system.debug(q.Pontoon_Type__c+'=========pontoonType');
		system.debug(q.Clean_Pontoon__c+'=========cleanPontoon');
		system.debug(q.Vacum_Trucks__c+'=========vacumTrucks');
		system.debug(q.Truck_Size__c+'=========truckSize');
		system.debug(q.Drain_Method__c+'=========drainMethod');
		system.debug(q.Product__c+'=========product');
		system.debug(q.Product_Above_5_Ft__c+'=========productAbove5ft');
		system.debug(q.Remaining_Ft__c+'=========remainingFt');
		system.debug(q.Remaining_In__c+'=========remainingIn');
		system.debug(q.Roof_Access__c+'=========roofAccess');
		system.debug(q.Entry_Cleaning_Required__c+'=========entryCleaningRequired');
		system.debug(q.Treatment_Needed__c+'=========treatmentNeeded');
		system.debug(q.Remove_Seal__c+'=========removeSeal');
		system.debug(q.Clean_Seal__c+'=========cleanSeal');
		system.debug(q.Rescue_Team__c+'=========rescueTeam');
		system.debug(q.Set_Legs__c+'=========setLegs');
		system.debug(q.Cribbing__c+'=========cribbing');
		system.debug(q.Degas_Support__c+'=========degasSupport');
		system.debug(q.Degas_Support_Hours__c+'=========degasSupportHours');
		system.debug(q.FracTanks__c+'=========fracTanks');
		system.debug(q.FracTanks_Needed__c+'=========fracTanksNeeded');
		system.debug(q.Vacum_Truck_Support__c+'=========vacuumTruckSupport');
		system.debug(q.vFracDrainDown__c+'=========vFracDrainDown');
		system.debug(q.vFracSkimming__c+'=========vFracSkimming');
		system.debug(q.vFinalWash__c+'=========vFinalWash');
		system.debug(q.vBlinding__c+'=========vBlinding');
		system.debug(q.vDegas__c+'=========vDegas');
		system.debug(q.vSeal_Cleaning__c+'=========vSealCleaning');
		system.debug(q.vPontoon_Cleaning__c+'=========vPontoonCleaning');
		system.debug(q.Notes__c +'=========notes');*/
		
    	insert q;    	
    	Quote_RE__c quoteDetail = [SELECT Id, Name,CreatedDate,Equipment_Hourly__c, Materials_Job__c, Total_Equipment_Billing__c,Degas_Support_Refined__c,Total_Materials_Billing__c,Total_Labor_Billing__c,Rescue_Billing__c,Total_Tech_PerDiem__c,Rescue_PerDiem__c,Lump_Sum_Total__c,Total_Inches_Remain__c,Total_Barrels__c,Estimated_Start_Date__c  FROM Quote_RE__c WHERE Id =: q.Id Limit 1];
    	return quoteDetail;    	 	   	
    } 
	@RemoteAction
    public static object submitQuote(String quoteId, String tankNumber){
        Quote_RE__c q = [SELECT Id, Name FROM Quote_RE__c WHERE Id =: quoteId];
        q.Status__c = 'Quoted';
        q.Tank__c = tankNumber;
        //q.Estimated_Start_Date__c = estimatedStartDate;
        update q;
       	Quote_RE__c quoteDetail = [SELECT Id, Days__c,Location__c,Rescue_PerDiem_Refined__c,Name,Total_Equipment_Billing__c,Tank__c,Total_Materials_Billing__c,Total_Labor_Billing__c,Rescue_Billing__c,Total_Tech_PerDiem__c,Rescue_PerDiem__c,Lump_Sum_Total__c,Total_Inches_Remain__c,Total_Barrels__c,Status__c,Estimated_Start_Date__c FROM Quote_RE__c WHERE Id =: q.Id Limit 1];
    	return quoteDetail;
    }

    
    @RemoteAction
    public static object editQuote(String quoteId, string status, string tankNumber,Map<string,string> quoteDetails,Map<string,boolean> quoteDetails2){
    	Quote_RE__c q = [SELECT id, name FROM Quote_RE__c WHERE Id =: quoteId];
    	//string company = quoteDetails.get('company');
    	//Account a = [SELECT Id, Name From Account WHERE Name =: company];
    	//q.Account__c = a.id;
    	Date dt = Date.valueOf(quoteDetails.get('estimatedStartDate'));     	
    	q.status__c = status;    	
		q.Tank_Diameter__c= Integer.ValueOf(quoteDetails.get('tankDiameter'));
		q.Hours_In_Shift__c= Integer.ValueOf(quoteDetails.get('hoursPerShift'));
		q.Location__c= quoteDetails.get('location');
		q.Pontoon_Type__c= quoteDetails.get('pontoonType');
		q.Clean_Pontoon__c= quoteDetails2.get('cleanPontoon');
		q.Vacum_Trucks__c= Integer.ValueOf(quoteDetails.get('vacumTrucks'));
		q.Truck_Size__c= Integer.ValueOf(quoteDetails.get('truckSize'));
		q.Drain_Method__c= quoteDetails.get('drainMethod');
		q.Product__c= quoteDetails.get('product');
		q.Product_Above_5_Ft__c= quoteDetails.get('productAbove5ft');
		q.Remaining_Ft__c= Integer.ValueOf(quoteDetails.get('remainingFt'));
		q.Remaining_In__c= Integer.ValueOf(quoteDetails.get('remainingIn'));
		q.Roof_Access__c= quoteDetails2.get('roofAccess');
		q.Entry_Cleaning_Required__c= quoteDetails2.get('entryCleaningRequired');
		q.Treatment_Needed__c= quoteDetails2.get('treatmentNeeded');
		q.Remove_Seal__c= quoteDetails2.get('removeSeal');
		q.Clean_Seal__c= quoteDetails2.get('cleanSeal');
		q.Rescue_Team__c= quoteDetails.get('rescueTeam');
		q.Set_Legs__c= quoteDetails2.get('setLegs');
		q.Cribbing__c= quoteDetails2.get('cribbing');
		q.Degas_Support__c= quoteDetails2.get('degasSupport');
		q.Degas_Support_Hours__c= Integer.ValueOf(quoteDetails.get('degasSupportHours'));
		q.FracTanks__c= quoteDetails2.get('fracTanks');
		q.FracTanks_Needed__c= Integer.ValueOf(quoteDetails.get('fracTanksNeeded'));
		q.Vacum_Truck_Support__c= quoteDetails2.get('vacuumTruckSupport');
		q.vFracDrainDown__c= quoteDetails2.get('vFracDrainDown');
		q.vFracSkimming__c= quoteDetails2.get('vFracSkimming');
		q.vFinalWash__c= quoteDetails2.get('vFinalWash');
		q.vBlinding__c= quoteDetails2.get('vBlinding');
		q.vDegas__c= quoteDetails2.get('vDegas');
		q.vSeal_Cleaning__c= quoteDetails2.get('vSealCleaning');
		q.vPontoon_Cleaning__c= quoteDetails2.get('vPontoonCleaning');
		q.Tank__c = tankNumber;
		q.Notes__c = quoteDetails.get('notes');
		if(quoteDetails.get('estimatedStartDate') !=Null){
			q.Estimated_Start_Date__c = dt;
		}
		
    	/*if (jobDate !=Null){
			q.Estimated_Start_Date__c = jobDate;
		}*/
		
		system.debug(q.Tank_Diameter__c+'=========tankDiameter');
		system.debug(q.Hours_In_Shift__c+'=========hoursPerShift');
		system.debug(q.Location__c+'=========location');
		system.debug(q.Pontoon_Type__c+'=========pontoonType');
		system.debug(q.Clean_Pontoon__c+'=========cleanPontoon');
		system.debug(q.Vacum_Trucks__c+'=========vacumTrucks');
		system.debug(q.Truck_Size__c+'=========truckSize');
		system.debug(q.Drain_Method__c+'=========drainMethod');
		system.debug(q.Product__c+'=========product');
		system.debug(q.Product_Above_5_Ft__c+'=========productAbove5ft');
		system.debug(q.Remaining_Ft__c+'=========remainingFt');
		system.debug(q.Remaining_In__c+'=========remainingIn');
		system.debug(q.Roof_Access__c+'=========roofAccess');
		system.debug(q.Entry_Cleaning_Required__c+'=========entryCleaningRequired');
		system.debug(q.Treatment_Needed__c+'=========treatmentNeeded');
		system.debug(q.Remove_Seal__c+'=========removeSeal');
		system.debug(q.Clean_Seal__c+'=========cleanSeal');
		system.debug(q.Rescue_Team__c+'=========rescueTeam');
		system.debug(q.Set_Legs__c+'=========setLegs');
		system.debug(q.Cribbing__c+'=========cribbing');
		system.debug(q.Degas_Support__c+'=========degasSupport');
		system.debug(q.Degas_Support_Hours__c+'=========degasSupportHours');
		system.debug(q.FracTanks__c+'=========fracTanks');
		system.debug(q.FracTanks_Needed__c+'=========fracTanksNeeded');
		system.debug(q.Vacum_Truck_Support__c+'=========vacuumTruckSupport');
		system.debug(q.vFracDrainDown__c+'=========vFracDrainDown');
		system.debug(q.vFracSkimming__c+'=========vFracSkimming');
		system.debug(q.vFinalWash__c+'=========vFinalWash');
		system.debug(q.vBlinding__c+'=========vBlinding');
		system.debug(q.vDegas__c+'=========vDegas');
		system.debug(q.vSeal_Cleaning__c+'=========vSealCleaning');
		system.debug(q.vPontoon_Cleaning__c+'=========vPontoonCleaning');
		system.debug(q.Notes__c +'=========notes');
    	update q;    	
    	Quote_RE__c quoteDetail = [SELECT Id, Name,Total_Equipment_Billing__c,Total_Materials_Billing__c,Total_Labor_Billing__c,Estimated_Start_Date__c ,Rescue_Billing__c,Total_Tech_PerDiem__c,Rescue_PerDiem__c,Lump_Sum_Total__c,Total_Inches_Remain__c,Total_Barrels__c FROM Quote_RE__c WHERE Id =: q.Id Limit 1];
    	return quoteDetail;    	 	   	
    } 
    
    @RemoteAction
    public static object createPurchaseOrder(string quoteId){
    	Purchase_Order__c po = new Purchase_Order__c();
    	Quote_RE__c q = [SELECT Id,Account__c,Location__c,Lump_Sum_Total__c,Tank__c FROM Quote_RE__c WHERE Id =: quoteId ];
    	//Contact currentContact = [SELECT id, Name, AccountId FROM Contact WHERE Id=: contactId];
    	//po.PO__c = poNumber;
    	po.Amount__c = q.Lump_Sum_Total__c;
    	po.Vendor__c = '001P000000dUS1M';
    	po.Cost_Code__c = '50003 Material';
    	po.Office__c = '001P000000dUS1b';
    	//po.Office__c = officeId;
    	insert po;
    	Purchase_Order__c poDetail = [SELECT Id, Name,PO__c FROM Purchase_Order__c WHERE Id =: po.Id ];
    	Project__c p = new Project__c();
    	p.Purchase_Order__c =  poDetail.Id;    	
     	p.Quote__c = q.Id;
     	p.Account__c = q.Account__c;    	     	
     	p.Name = 'This Project';
     	p.Location__c = q.Location__c;
     	system.debug('*******************************companyId===' + companyId );
     	insert p;
     	Project__c pDetail = [SELECT Id, Name FROM Project__c WHERE Id =: p.Id];
     	//Quote_RE__c q = [SELECT Id,Account__c,Location__c,Lump_Sum_Total__c,Tank__c FROM Quote_RE__c WHERE Id =: quoteId ];
     	q.Purchase_Order__c = poDetail.Id;
     	q.Project__c = pDetail.Id;
     	q.Status__c = 'Accepted';
     	update q;   	
    	return poDetail;
    }       
     @RemoteAction
     public static object createProject(String quoteId, String poId){
     	Project__c p = new Project__c();
     	Quote_RE__c q = [SELECT Id,Lump_Sum_Total__c,Tank__c,Days__c FROM Quote_RE__c WHERE Id =: quoteId ];
     	Purchase_Order__c po =[SELECT Id,Name FROM Purchase_Order__c WHERE Id =: poId];
     	p.Purchase_Order__c =  po.Id;    	
     	p.Quote__c = q.Id;
     	p.Account__c = companyId;    	     	
     	p.Name = 'This Project';
     	insert p;     	
     	Project__c projectDetails = [SELECT Id, Name FROM Project__c WHERE Id =: p.Id];
     	return projectDetails;
     }
   
    /*  @RemoteAction
    	public static object createJobs(String quoteId, String poId){
     	FX5__Job__c j = new FX5__Job__c();
     	Quote_RE__c q = [SELECT Id,Lump_Sum_Total__c,Tank__c FROM Quote_RE__c WHERE Id =: quoteId ];     	
     	j.Quote__c = q.Id;
     	j.FX5__CustomerAccount__c = companyId;
     	j.FX5__Customer_PO_Amount__c = q.Lump_Sum_Total__c;
     	j.FX5__Primary_Job_Contact__c = contactId;
     	//j.FX5__Quote2__c = 'a0qP0000000yZgW'; //dummy quote until managed Quote is replaced with Quote_RE__c
     	j.FX5__Office__c = officeId; //office of the current user
     	j.Unit_Or_Tank_Number__c = q.Tank__c;
     	j.FX5__Price_Book__c = 'a0EP00000080qvk';//dummy price book
     	j.Brief_Scope_of_work__c = 'Brief Scope of Work';
     	j.Customer_Type__c = 'Refinery';
     	j.Wash_Out__c = 'None';
     	j.FX5__Customer_PO__c = poId;
     	j.FX5__Site_Address1__c = '123 Main St';
     	j.FX5__Site_City__c = 'Los Angeles';
     	j.FX5__Priority__c = 'Low';
     	//j.FX5__Projected_End_Date__c = jobDate.addDays(30);
     	j.FX5__Projected_End_Date__c = Date.today();
     	j.FX5__Projected_Start_Date__c = Date.today();
     	//j.FX5__Projected_Start_Date__c = jobDate;
     	j.Name = 'This Project';
     	insert j;     	
     	FX5__Job__c jobDetails = [SELECT Id, Name FROM FX5__Job__c WHERE Id =: j.Id];
     	Purchase_Order__c purOrd = [SELECT id, Name FROM Purchase_Order__c WHERE Id =: poId];
     	purOrd.Job__c = jobDetails.Id;
     	update purOrd;
     	return jobDetails;
     }*/
}