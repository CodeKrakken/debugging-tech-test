# Customer Service Support Technician Tech Test
Test for CS Support candidates

## Process

First of all I walked through the program in the browser, putting myself in the user's shoes. What problem had they been having? I methodically checked all links and noted URLs, constructing a sitemap as I went.

## Issue 1

The first bug I found was on /companies/[1-4]. Although each "Show" button on /companies takes you to the right URL, the details listed are always for the top company.
<br>
This suggests an issue pulling from the database. I suspect that each page of /companies/[1-4] is hardcoded to pull data from the row 1 of the table. This is borne out by the effect of deleting the company 1: the remaining pages all show company 2's data, now moved up in the database to row 1.
<br><br>

## Issue 2

Advancing along this branch of the program, I check the `Edit` link for each employee of Company 1. It always takes me to Employee 1's details. It looks like the URLs are wrong - the edit links are as follows:
<br><br>
/companies/1/employees/1/edit<br>
/companies/2/employees/1/edit<br>
/companies/3/employees/1/edit<br>
/companies/4/employees/1/edit
<br><br>
Since they are all from company 1, it would be logical to set the links thus:
<br><br>
/companies/1/employees/1/edit<br>
/companies/1/employees/2/edit<br>
/companies/1/employees/3/edit<br>
/companies/1/employees/4/edit
<br><br>
A quick check of Company 2's `edit` links yields the following URLs:<br><br>
/companies/1/employees/2/edit<br>
/companies/2/employees/2/edit<br>
/companies/3/employees/2/edit<br>
/companies/4/employees/2/edit
<br><br>
Each one displays the details for Company 1 Employee 2. This pattern follows for Companies 3 & 4, suggesting that the cause of this issue is a syntax issue in the routing of the edit buttons, specifically that the Company and Employee numbers hsve been switched.<br>
However, since the site is pulling Row 1 data for all companies, we cannot yet clarify.

## Issue 3

I suspect this is related to the above bug, but 