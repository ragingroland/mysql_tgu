CREATE TABLE TurnoverAnalysis (
	PeriodMonth VARCHAR(7) NOT NULL,
    PeriodQrt VARCHAR(7) NOT NULL,
    PeriodHYear VARCHAR(7) NOT NULL,
    Period date NOT NULL,
	Divisions сhar(3) NOT NULL,
	ProductDivision char(6) NOT NULL,
	SalesChannel varchar(50) NOT NULL,
	CustomerGroups char(2) NOT NULL,
	Region char(1) NOT NULL,
	City char(2) NOT NULL,
	SumSaled decimal(18, 2) NOT NULL)
UNSEGMENTED ALL NODES;


INSERT INTO TurnoverAnalysis (
	PeriodMonth, PeriodQrt, PeriodHYear, Period,
    Division, ProductDepartment, SalesChannel, 
    CustomerGroup, Region, City, SumSaled)
SELECT
    EXTRACT(MONTH FROM DataInfo) AS PeriodMonth,
    CASE 
    	WHEN EXTRACT(MONTH FROM DataInfo) IN (1, 2, 3) THEN 1
    	WHEN EXTRACT(MONTH FROM DataInfo) IN (4, 5, 6) THEN 2
    	WHEN EXTRACT(MONTH FROM DataInfo) IN (7, 8, 9) THEN 3
    	ELSE 4
	END AS PeriodQrt,
    CASE
    	IF EXTRACT(MONTH FROM DataInfo) BETWEEN 1 AND 6 THEN 1
    	ELSE 2
    END AS PeriodHYear,
    DataInfo AS Period,
	LEFT(Class305.Class305_Level1, 3) AS Division,
	LEFT(Class305.Class305_Level2, 6) AS ProductDivision,
	SalesChannel,
	LEFT(Class71.Class71_Code, 2) AS CustomerGroups,
	LEFT(Class37.Class37_Code, 1) AS Region,
	LEFT(Class37.Class37_Code, 2) AS City,
	SUM(CliTurnoverDtl.SumSaled) AS SumSaled
FROM
	CliTurnoverDtl
	INNER JOIN Class305 ON RgdDivisDprt.Class305_Code = Class305.Class305_Code
	INNER JOIN Class71 ON DescKontrag.Class71_Code = Class71.Class71_Code
	INNER JOIN Class37 ON CliTurnoverDtl.Class37_Code = Class37.Class37_Code
	INNER JOIN DescKontrag ON CliTurnoverDtl.CliCode = DescKontrag.CliCode
    INNER JOIN RgdDivisDprt ON CliTurnoverDtl.RgdCode = RgdDivisDprt.RgdCode
WHERE
	CliTurnoverDtl.DataInfo >= ADD_MONTHS(CURRENT_DATE, -24)
GROUP BY 
    PeriodMonth, PeriodQrt, PeriodHYear, Period, Division, ProductDepartment, SalesChannel, CustomerGroup, Region, City;