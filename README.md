# Customer Service Support Technician Tech Test
Test for CS Support candidates

## Process

First of all I walked through the program in the browser, putting myself in the user's shoes. What problem had they been having? I methodically checked all links and noted URLs, constructing a sitemap as I went. Although I am aware there are only 3 bugs to find, I have listed their effects as separate issues in the first instance.

## Issue 1

The first bug I found was on `/companies/[n]`. Although each `Show` button on `/companies` takes you to the right URL, the details listed are always for Company 1.
<br>
This suggests an issue pulling from the database. I suspect that each page of `/companies/[n]` is hardcoded to pull data from the row 1 of the table. This is borne out by the effect of deleting Company 1: the remaining pages all show Company 2's data, now moved up in the database to row 1.
<br>
This issue also affects creation of a company on `/companies/new`. It saves the new company details correctly and routes to the correct company details page, but the details displayed are for row 1 of the database.

## Issue 2

On every instance of `/companies/[n]`, `Add employee` routes you to `/companies/1/employees/new`. It is possible that this defaulting to Company 1 is related to Issue 1, but it could also be an unrelated syntax issue. 

<br><br>

## Issue 3

Advancing along this branch of the program, I check the `Edit` link for each employee of Company 1. It always takes me to Employee 1's details. It looks like the URLs are wrong - the edit links are as follows:
<br><br>```
/companies/1/employees/1/edit<br>
/companies/2/employees/1/edit<br>
/companies/3/employees/1/edit<br>
/companies/4/employees/1/edit```
<br><br>
Since they are all from Company 1, it would be logical to set the links thus:
<br><br>```
/companies/1/employees/1/edit<br>
/companies/1/employees/2/edit<br>
/companies/1/employees/3/edit<br>
/companies/1/employees/4/edit```
<br><br>
A quick check of Company 2's `edit` links yields the following URLs:
<br><br>```
/companies/1/employees/2/edit<br>
/companies/2/employees/2/edit<br>
/companies/3/employees/2/edit<br>
/companies/4/employees/2/edit```
<br><br>
Each one displays the details for Company 1 Employee 2. This pattern follows for Companies 3 & 4, suggesting that the cause of this issue is a syntax issue in the routing of the edit buttons, specifically that the Company and Employee numbers have been switched. However, since the site is pulling Row 1 data for all companies, we cannot yet clarify.<br>

## Issue 4

Editing cmployee details and clicking `Save` updates the details for the displayed employee. However it then takes us to a near duplicate of `/companies/[n]`, with `/employees` appended to each URL. This is also where we land when we click `Back to employees list`, or return from `/companies[n]/employees/new`. This duplicate, `/companies/[n]/employees` displays the wrong company's details, but this is due to the routing of `Edit` buttons on `/companies/[n]` - it is not a separate bug.<br>
The `Edit` button for each employee has here been replaced by `Edit Employee` and `Destroy Employee` - both buttons function correctly. There is no `Back to companies list` button here but I'm not sure this can be defined as a bug so much as a missing feature.
<br><br>

## Issue 5

Although clicking `Add Employee` on `/companies/[n]` will only take us to `/companies/1/employees/new`, the equivalent `Create New Employee` button on `/companies/[n]/employees` allows us to access `/companies/[n]/employees/new` correctly. However, clicking `save` throws an error: `* Surname can't be blank`, even when filled. I next submitted a form with the surname blank, which yielded the following result: `* Surname can't be blank<br>* Middlename can't be blank`. Clearly the field labelled `Surname` is actually the `Middlename` field, and the real `Surname` field is not displayed, hence always blank.
<br><br>

## Bugs

* `/companies/[n]` always displays details for Row 1 of the database table
* `Edit` links are incorrectly written on `/companies/[n]
* Fields are incorrectly labelled on `/companies/[n]/employees/new`
<br><br>

## Recommendations

* Change `Show` links on `/companies` from `/companies/[n]` to `/companies/[n]/employees`, and remove `/companies/[n]` pages. This will remove the first two bugs.
* Remove current `Surname` field on `/companies/[n]/employees/new` and rename `Middlename` field to `Surname`.