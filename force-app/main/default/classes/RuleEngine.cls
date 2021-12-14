public with sharing class RuleEngine 
{
    private List<Opportunity_Score_Rule__c> oppRuleCfgs;
    
    public RuleEngine()
    {
        loadRules();
    }

    private void loadRules()
    {
        // get the Opportunity Scoring Rules from the custom setting and stores in oppRuleCfgs 
        // ordered by the Index__c field, low to high. 
        oppRuleCfgs = [SELECT Implementing_Class_Name__c FROM Opportunity_Score_Rule__c ORDER BY Index__c ASC NULLS FIRST];    
    }

    public Integer scoreOpportunity(Opportunity opp)
    {
        Integer totalScore = 0;
        for (Opportunity_Score_Rule__c oppRuleCfg : oppRuleCfgs)
        {
            // create the OpportunityScoringRuleIF implementing class based on the Implementing_Class_Name__c field
            Type opportunityScoringRuleType = Type.forName(oppRuleCfg.Implementing_Class_Name__c);
            OpportunityScoringRuleIF oppRule = (OpportunityScoringRuleIF) opportunityScoringRuleType.newInstance();

            totalScore+=oppRule.calculateScore(opp);
        }

        return totalScore;
    }
}
