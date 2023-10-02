/**
 * Interface for defining an opportunity scoring rule.
 * Implement this interface to create custom scoring rules for opportunities.
 */
public interface OpportunityScoringRuleIF 
{
    Integer calculateScore(Opportunity opp);
}
