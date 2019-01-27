# US Health Care: Quality as an Indicator of Cost

This Shiny application, written in R, was developed to give an overview of cost of healtcare in each states. [Click here to view and interact the application.]( https://berneskaracay.shinyapps.io/Medicare-Inpatient-Charge/) 

### Overview

Stack Overflow has many groups separated by interests. Search of Stack Overflow is facilitated by proper topic tagging. Stack Exchange can be used to query Stack Overflow tags (and explore their popularity). Russian Stack Overflow is also a large and active community. Comparing tags of the English-speaking Stack Overflow to the Russian counterpart may reveal interesting trends.

### Motivation

As a immigrant I have had any major experience with USA healtchare system but I always hear that it is very expensive. My first experience was 4 months ago when my wife had c-section. I recieved the bill one month latter and it is a lot. Hence, I decide to make this Shiny App in order to help people to find cheapest and highest quality hospital in their state. 

### Null and Alternative Hypotheses

**Null Hypothesis**:
Is healthcare cost good indicator for quality of healthcare? 
My initial hypothesis is: Yes because the hospital charges more if they
hire better doctors and good technologies which are both
expensive to attain.

### Data Collection and Preparation

The hospital quality data used here is from the [HCAHPS Hospital Consumer Assessment of Healthcare Providers and Systems](https://www.hcahpsonline.org/en/) for the year 2016. 

The hospital payment data used here is from the
[CMS Center for Medicare and Medicaid Services](https://www.cms.gov/research-statistics-data-and-systems/statistics-trends-and-reports/medicare-provider-charge-data/inpatient.html) for the year 2016. This data includes information on utilization, payment (total payment and Medicare payment), and hospital-specific charges for the more than 3,000 U.S. hospitals that receive Medicare Inpatient Prospective Payment System (IPPS) payments. 

### Widget Controls and Graphs

Left panel widgets interact with the graphs on the right. Right panel has three graphs separated by tabs. The same widgets interact with all of the application graphs. Note: Right panel graphs also have several interactive features. Try hovering your mouse over the graph lines, the icons directly above the graphs, or clicking on individual legend items.

### Interactivity Screenshots
<table style = "border: none">
  <tr>
    <td> 
      <img src="https://user-images.githubusercontent.com/33165031/51431192-2398ed00-1beb-11e9-8da7-eef4c376b6ca.gif"> 
    </td>
    <td>
      <img src="https://user-images.githubusercontent.com/33165031/51431343-1a108480-1bed-11e9-9b3a-e230184dd121.gif">
    </td>
  </tr>
  <tr>
    <td>
    <img src="https://user-images.githubusercontent.com/33165031/51431354-38768000-1bed-11e9-897b-0c3299a6fabc.gif">
    </td>
    <td>
    <img src="https://user-images.githubusercontent.com/33165031/51431356-3ca29d80-1bed-11e9-9043-22ba151878d5.gif">
    </td>
  </tr>
</table>


### Preliminary Findings
Majority of the medical procedures there is a negative correlation between quality and cost.

### Live Demo

[Click here to view and interact the application.]( https://berneskaracay.shinyapps.io/Medicare-Inpatient-Charge/) 
