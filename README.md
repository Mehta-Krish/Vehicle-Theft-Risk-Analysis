<h1>Vehicle Theft Risk Analysis</h1>
<a href='https://app.powerbi.com/view?r=eyJrIjoiZjYyYjViOTktMDNlNy00NDM0LWIzZWMtMDI2NDUzMmE3Mzg2IiwidCI6IjA0MjJjNTMxLTA2YTgtNDE1Zi04YWQ1LWEzZmU0Mzk5ZjYwMiJ9'>Dashboard</a><br><br>
This project focuses on analyzing vehicle theft patterns in New Zealand using a combination of Python (data cleaning), MySQL (data analysis), and Power BI (data visualization).                   
<br>The goal is to uncover trends related to vehicle types, regions, time patterns, and theft rates, helping stakeholders understand high-risk areas and make data-driven decisions for prevention. 
                    <br><br>Datasets Used:<ul>
                        <li> Location Dataset: Contains region-wise information and population data
                        <li> Vehicle Details Dataset: Contains vehicle categories and company details.
                        <li> Stolen Vehicles Dataset: Main fact dataset containing all theft records.</ul>
                    <br><strong><h3>🐱 Steps Followed :</h3></strong><hr>
                            ✅ Understood and collect the dataset from Maven Analytics.
                        <br>✅ Imported the raw datasets using pandas.
                        <br>✅ Handled missing values & Cleaned the datasets appropriately.
                        <br>✅ Implemented data validation.
                        <br>✅ Loaded the cleaned & valid datasets into MySQL database.
                        <br>✅ Performed EDA using MySQL queries.
                        <br>✅ Imported cleaned & valid data into Power BI.
                        <br>✅ Performed Feature Engineering (Measures, Calendar tables) Using Power Query.
                        <br>✅ Finally designed & developed the dashboard using Power Bi.
                    <br><br><strong><h3>🐱 Key Analysis Performed :</h3></strong><hr><ol>
                    <li><strong>KPI Analysis –</strong> Total Vehicles Stolen, Per Day Reports, Theft Rate, Most Stolen Vehicle Type & Model Year.
                    <li> <strong>Monthly Trend Analysis –</strong> Identified month-wise theft patterns and fluctuations.
                    <li> <strong>Yearly Trend Analysis –</strong> Compared theft growth between years.
                    <li> <strong>Category Analysis –</strong> Compared theft distribution across Standard and Luxury vehicles.
                    <li> <strong>Regional Analysis –</strong> Analyzed theft distribution across regions.
                    <li> <strong>Company-Level Analysis –</strong> Identified top targeted vehicle companies.
                    <li> <strong>Vehicle Preference Analysis –</strong> Most and least stolen vehicle types.
                    <li> <strong>Color Analysis –</strong> Identified which vehicle colors are most targeted.
                    <li> <strong>Day-wise Analysis –</strong> Analyzed theft trends across days of the week.
                    <li> <strong>Model Year Analysis –</strong> Identified most targeted vehicle manufacturing years.
                    <li> <strong>Theft Rate Analysis –</strong> Identified companies having high theft ratios.
                    <li> <strong>Population vs Theft Analysis –</strong> Correlation between population density and theft volume.  
                    </ol>
                    <br><br><strong><h3>🐱 Insights :</h3></strong><hr><ol>
                    <li> <strong>Overall Theft KPIs –</strong><ul>
                      <li><b>Total Vehicles Stolen:</b> 4,039
                      <li><b>Average Daily Thefts:</b> 130
                      <li><b>Theft Rate:</b> 0.08%
                      <li><b>Most Stolen Vehicle Type:</b> Stationwagon
                      <li><b>Most Targeted Model Year:</b> 2006</ul>
                    <li> <strong>Yearly Trend –</strong>  Vehicle thefts increased significantly from 2021 to 2022, showing a rising trend.Indicates growing theft activity.
                    <li> <strong>Monthly Trends –</strong> Theft peaked early in the year (around March) and dropped sharply afterward.
Gradual increase observed again toward the end of the year.
                    <li> <strong>Category Insights –</strong> Standard vehicles dominate thefts (96%), while Luxury vehicles contribute only 4%. Indicates thieves target common and easily accessible vehicles.
                    <li> <strong>Regional Insights –</strong> Auckland has the highest number of thefts by a large margin followed by regions like Canterbury and Bay of Plenty. Urban and high-population areas show higher theft concentration.
                    <li> <strong>Top Targeted Companies –</strong> Toyota is the most stolen vehicle brand followed by Trailer, Nissan, Mazda, and Ford. Popular brands are more vulnerable due to higher availability.
                    <li> <strong>Vehicle Type Insights :</strong><ul>
                          <li> <b>Most stolen:</b> Stationwagon followed by Saloon & Hatchback
                          <li> <b>Least stolen:</b> Special purpose vehicles, Mobile Machines.
                          <li> Indicates thieves prefer common passenger vehicles.</ul>
                    <li> <strong>Color Analysis –</strong> Silver and White vehicles are most stolen, followed by Black and Blue. Likely due to higher availability and easier resale.
                    <li> <strong>Day-of-Week Pattern –</strong> Highest thefts occur on Monday and Tuesday. Weekends show slightly lower but still consistent activity, suggests thefts are not limited to weekends.
                    <li> <strong>Model Year Insights –</strong> Vehicles from 2005–2007 are most targeted while older vehicles lack may be due to advanced security systems.
                    <li> <strong>Theft Rate Insights –</strong> Companies like Toyota, Trailer and Nissan have higher theft rates. Indicates both popularity and vulnerability.
                    <li> <strong>Population vs Theft –</strong> Positive correlation between population and theft count, which defines densely populated regions experience more theft incidents.
</ol>
                    <br><br><strong><h3>🐱 Recommendations:</h3></strong><hr><ul>
                       <li> Install more CCTV cameras and smart monitoring systems in theft-prone zones.
                       <li> Encourage owners of older vehicles (especially 2005–2007 models) to upgrade security systems.                       
                       <li> Closely monitor lending in high-default states like Nebraska, Nevada, and Alaska, and implement region-specific risk controls.
                       <li> Implement stricter regulations and verification in the resale market for second-hand vehicles and parts.
                       <li> Collaborate with automobile companies to enhance built-in vehicle security features.
                       <li> Encourage insurance companies to offer benefits for vehicles equipped with anti-theft systems.
                       <li>Promote the use of advanced anti-theft devices such as GPS trackers and immobilizers in vehicles.
                       </ul>
