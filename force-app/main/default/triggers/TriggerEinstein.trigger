
trigger TriggerEinstein on Opportunity (after insert, after update) {
   
    System.debug('entrado na trigger');

    List<Opportunity> opps = Trigger.new;
    
    // We will process only those opportunities that are updated to closed/won
    List<Opportunity> oppsToProcess = new List<Opportunity>();
    for (Opportunity opp : opps) {
        if (opp.StageName.equals('Closed Won') && opp.StageName!=Trigger.OldMap.get(opp.Id).StageName) {
            oppsToProcess.add(opp);
        }
    }

    if (!oppsToProcess.isEmpty()) {
        // We have opportunities to process. Execute the integration.
        EinsteinDevIntegration.processOpportunities(oppsToProcess[0].Id);
    }

}
