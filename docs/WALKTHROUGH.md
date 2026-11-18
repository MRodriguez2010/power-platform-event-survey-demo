# Walkthrough

1. Explain the business problem in one sentence: Collect synthetic survey input in an Excel table, validate ratings, flag keyword matches and write review receipts to SharePoint.
2. Show the source workbook(s) and the named table(s).
3. Open the native flow and show the input, validation/routing and receipt actions.
4. Run the seeded baseline with blank optional inputs, then inspect the output values.

| Record | Expected outcome |
|---|---|
| S001 | Accepted |
| S002 | CriticalFeedbackReview |
| S003 | CriticalFeedbackReview |
| S004 | InvalidRating |

S003 says “No complaint from me” and deliberately triggers a false positive. This is substring matching, not sentiment analysis. S004 has an invalid rating. The native Power Query preview evaluated four rows, but a usable Power BI report and refresh were not verified: the service reported a regional Pro-workspace limitation.

For certification, enter a new synthetic request ID and the required fields on one run. Use a later run’s certifier fields to submit Approve, Deny or Postpone against that same ID. These forms are practice interfaces in Power Automate; they are not separate Power Apps or identity-enforced approval screens. Inputs use revision 1. Repeated IDs do not append another intake row, but production edit/revision workflows are outside this sample.

For survey intake, a new ID adds one row; blank ID reprocesses saved rows. For mail, there are no input fields and no real sends.

If the live service is unavailable, show the captured native evidence and say it is a prior run. Do not describe a screenshot or local receipt check as a live execution.
