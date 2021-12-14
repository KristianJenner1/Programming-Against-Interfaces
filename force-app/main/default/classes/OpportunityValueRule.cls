public with sharing class OpportunityValueRule implements OpportunityScoringRuleIF
{
    // returns a score of 10 if the opportunity has a value of 2.5 million or above
    public Integer calculateScore(Opportunity opp)
    {
        Integer score = 0;
        if (opp.Amount >= 2500000)
        {
            score = 10;
        }
        return score;
    }
}
