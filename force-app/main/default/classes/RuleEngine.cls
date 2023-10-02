/**
 * The RuleEngine class is responsible for implementing the business rules of the application.
 * It contains methods for evaluating rules and making decisions based on those rules.
 */
public with sharing class RuleEngine
{
    // list of Opportunity Scoring Rules from the custom setting
    private List<Opportunity_Score_Rule__c> oppRuleCfgs;
    
    // constructor
    public RuleEngine()
    {
        loadRules();
    }

    // load the Opportunity Scoring Rules from the custom setting
    private void loadRules()
    {
        // check if the Opportunity Scoring Rules have already been loaded else cache them
        if (oppRuleCfgs != null)
        {
            return;
        }
        // get the Opportunity Scoring Rules from the custom setting and store in oppRuleCfgs 
        // ordered by the Index__c field, low to high. 
        oppRuleCfgs = [SELECT Implementing_Class_Name__c FROM Opportunity_Score_Rule__c ORDER BY Index__c ASC NULLS FIRST];    
    }

    // score the Opportunity based on the Opportunity Scoring Rules
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
