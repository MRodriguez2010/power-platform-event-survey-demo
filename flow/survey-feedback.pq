let
 Source = Excel.Workbook(Web.Contents("__SHAREPOINT_SITE_URL__/Shared%20Documents/surveys.xlsx"), null, true),
 Rows = Source{[Item="SurveyResponses",Kind="Table"]}[Data],
 Typed = Table.TransformColumnTypes(Rows,{{"ResponseId", type text},{"Event", type text},{"Rating", Int64.Type},{"Feedback", type text}}),
 Unique = if Table.RowCount(Typed) <> Table.RowCount(Table.Distinct(Typed,{"ResponseId"})) then error "Duplicate ResponseId requires review" else Typed,
 Validity = Table.AddColumn(Unique,"Validation",each if [Rating] >= 1 and [Rating] <= 5 then "Valid" else "Invalid rating",type text),
 ValidRating = Table.AddColumn(Validity,"ValidRating",each if [Validation] = "Valid" then [Rating] else null,type number),
 Matched = Table.AddColumn(ValidRating,"KeywordMatch",each Text.Combine(List.Select({"complaint","unsafe","harassment"},(keyword)=>Text.Contains(if [Feedback]=null then "" else [Feedback],keyword,Comparer.OrdinalIgnoreCase)),"; "),type text),
 Route = Table.AddColumn(Matched,"ReviewRoute",each if [Validation] <> "Valid" then "Data quality review" else if [KeywordMatch] <> "" then "Critical feedback review" else "No escalation",type text)
in Route