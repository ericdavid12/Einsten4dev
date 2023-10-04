public class EinsteinDevIntegration {

    @future(callout=true)
    public static void processOpportunities(Id oppId) {

        Opportunity opp = [SELECT Id, Name, Type, LeadSource,Amount,Owner.Name,
                        CloseDate,Account.Name FROM Opportunity WHERE Id=:oppId];

        String body = '';
            body += '{';
            body += '   "OpportunityId": "' + opp.Id + '",';
            body += '   "Type": "' + opp.Type + '",';
            body += '   "LeadSource": "' + opp.LeadSource + '",';
            body += '   "Amount": ' + opp.Amount + ',';
            body += '   "Opportunity Owner": "' + opp.Owner.Name + '",';
            body += '   "Close Date": "' + opp.CloseDate + '",';
            body += '   "Account Name": "' + opp.Account.Name + '"';
            body += '}';
            body += ',\n';
        body = body.substring(0, body.length() - 1);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://einstein4devs.free.beeceptor.com/EinsteinPost');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody(body);
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200) {
            System.debug('Integration successful');
            System.debug('Response: ' + res.getBody());
        } else {
            System.debug('Integration failed');
            
		}
	}
}