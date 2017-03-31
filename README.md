
An Analysis of Non-Profit Organization Revenue Models Using IRS Form 990 Data
================================

A [Shiny application](https://rwk506.shinyapps.io/datadive/).
<br />

###Table of Contents###
[Summary](#Summary)<br />
[Case Study](#Case)<br />
[References](#Refs)<br />
[Other Information](#Other)<br />
<br /><br />


<a name="Summary"/>
###Summary###

The Shiny application can be found [here](https://rwk506.shinyapps.io/datadive/). 

<br />

**How does the financial performance of your non-profit compare to similar organizations?**

This is the question we attempted to address through the examination of tax documents for hundreds of thousands of non-profits who filed with the IRS in the 2015 fiscal year. By analyzing how much of a non-profit's revenue derives from contributions (as opposed to program revenue, membership fees, etc.), we explore how this changes for similar non-profit organizations over time.

The Shiny app plots the amount of contributed gifts compared to the total revenue of the non-profits over time. This metric indicates how financially dependent (high ratio on y-axis) or how independent (low ratio on y-axis) an organization is likely to be on individual contributions compared to how long it has been in operation.

The user can inspect how this changes for different types of non-profit organizations (e.g.: foreign aid, public servies) as designated by NTEE codes, which can be changed from the left panel dropdown menu. Through this process, the long-term financial behavior for similar non-profits shows how the revenue model of organizations changes as those organizations age. More details available in the 'IRS Data' tab of the app.

<br /><br /><br />
<a name="Case"/>
###Case Study Example:###

Imagine you are part of a youth development organization (NTEE code 'O') that has been in operation for 20 years. Presently, you may be seeing a decrease in your reliance on contributions to the total revenue of your organization, perhaps making more and more revenue from programs or membership fees.

However, if you don't see the finances of your organization heading in that direction (and your organization remains heavily dependent on individual contributions), you may want to re-examine your revenue model and consider changes that would lead to more sustainable revenue streams as your organization moves forward.

<br /> <br /><br />




<a name="Refs"/>
###References###

** Data from IRS **
Source: [IRS Form 990 Data on AWS](https://aws.amazon.com/public-datasets/irs-990/)

Original data on the NPOs has been taken from the IRS Form 990 data, which is publicly available on Amazon Web Services. From an enormous effort on the part of DataKind and as part of the DataKind NYC DataDive in March 2017, this data has been cleaned and processed into its present form.

[IRS Form 990 Example](https://www.irs.gov/pub/irs-pdf/f990.pdf)

[IRS Form 990 Instructions](https://www.irs.gov/pub/irs-pdf/i990.pdf)

<br />
**NTEE code information**

[NTEE codes](http://nccs.urban.org/classification/national-taxonomy-exempt-entities)

The National Taxonomy of Exempt Entities is used by the IRS to classify non-profit organizations and facilitate collection, analysis, comparison of NPOs in a consistent manner.

<br />
**Additional Information**
Additional resources that may be useful when interpreting and understanding the analysis presented here.

[DataKind](http://www.datakind.org/)

[DataKind NYC DataDive](https://www.eventbrite.com/e/givingtuesday-datadive-presented-by-92y-datakind-and-the-bill-melinda-gates-foundation-registration-29290486634?utm_campaign=order_confirmation_email&utm_medium=email&ref=eemailordconf&utm_source=eb_email&utm_term=eventname#)

[Tax Form 990 Wiki](https://en.wikipedia.org/wiki/Form_990)

[National Center for Charitable Statistics](http://nccsweb.urban.org/knowledgebase/)





<br /> <br /><br />

<a name="Other"/>
###Other Information###

Author: RWK <br />
License: None. <br />
Contact: May be made through GitHub. Please contact if you intend to use for public/academic purposes. Also contact if any application issues arise. <br />

