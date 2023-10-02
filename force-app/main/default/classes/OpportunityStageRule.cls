/**
 * OpportunityStageRule is a class that implements the OpportunityScoringRuleIF interface.
 * This class is responsible for defining the rules for scoring opportunities based on their stage.
 */
public with sharing class OpportunityStageRule implements OpportunityScoringRuleIF
{
    public static final String OPPTY_STAGE_CLOSED_WON = 'Closed Won';
    
    // returns a score of 10 if the opportunity is Closed Won, otherwise 0
    public Integer calculateScore(Opportunity opp)
    {
        Integer score = 0;
        if (opp.StageName == OPPTY_STAGE_CLOSED_WON)
        {
            score = 10;
        }
        return score;
    }
}
