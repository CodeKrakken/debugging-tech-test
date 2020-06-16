# Customer Service Support Technician Tech Test
Test for CS Support candidates

## Process

First of all I walked through the program in the browser, putting myself in the user's shoes. I methodically checked all links and noted URLs, constructing a sitemap as I went. Although I am aware there are only 3 bugs to find, I have listed their effects as separate issues for now.

## Issue 1

The first bug I found was on `/companies/[n]`. Although each `Show` button on `/companies` takes you to the right URL, the details listed are always for Company 1.
<br>
This suggests an issue pulling from the database. I suspect that each page of `/companies/[n]` is hardcoded to pull data from row 1 of the table. This is borne out by the effect of deleting Company 1: the remaining pages now show Company 2's data, as it has been moved up in the table to row 1.
<br>
This issue also affects company creation on `/companies/new`. It saves the new company details correctly and routes to a new `/companies/[n]` page, which obviously inherits the issue from the template.

## Issue 2

On every instance of `/companies/[n]`, `Add employee` routes you to `/companies/1/employees/new`. It is possible that this defaulting to Company 1 is related to Issue 1, but it could also be an unrelated syntax issue. 

<br><br>

## Issue 3

Advancing along this branch of the program, I check the `Edit` link for each employee of Company 1. It always takes me to Employee 1's details. It looks like the URLs are wrong - the edit links are as follows:

<br><br>

```
/companies/1/employees/1/edit<br>
/companies/2/employees/1/edit<br>
/companies/3/employees/1/edit<br>
/companies/4/employees/1/edit```

<br><br>

Since they are all from Company 1, it would be logical to set the links thus:

<br><br>

```
/companies/1/employees/1/edit<br>
/companies/1/employees/2/edit<br>
/companies/1/employees/3/edit<br>
/companies/1/employees/4/edit```

<br><br>

A quick check of Company 2's `edit` links yields the following URLs:

<br><br>

```
/companies/1/employees/2/edit<br>
/companies/2/employees/2/edit<br>
/companies/3/employees/2/edit<br>
/companies/4/employees/2/edit```

<br><br>

Each one displays the details for Company 1 Employee 2. This pattern follows for Companies 3 & 4, suggesting that the cause of this issue is a syntax issue in the routing of the `Edit` buttons, specifically that the Company and Employee numbers have been switched. However, since the site is pulling row 1 data for all companies, we cannot yet clarify.<br>

## Issue 4

Editing employee details and clicking `Save` updates the details for the displayed employee. However it then takes us to a near duplicate of `/companies/[n]`, with `/employees` appended to each URL. This is also where we land when we click `Back to employees list`, or return from `/companies[n]/employees/new`. This duplicate, `/companies/[n]/employees` displays the wrong company's details, but this is due to the routing of `Edit` buttons on `/companies/[n]` - it is not a separate bug.<br>
The `Edit` button for each employee has here been replaced by `Edit Employee` and `Destroy Employee` - both buttons function correctly. There is no `Back to companies list` button here but I'm not sure this can be defined as a bug so much as an oversight.

<br><br>

## Issue 5

Although clicking `Add Employee` on `/companies/[n]` will only take us to `/companies/1/employees/new`, the equivalent `Create New Employee` button on `/companies/[n]/employees` allows us to access `/companies/[n]/employees/new` correctly. However, completing the form and clicking `Save` throws an error:

* Surname can't be blank<br>

This persists when the field is filled. I next submitted the form with the surname blank, which yielded the following result:

* Surname can't be blank
* Middlename can't be blank<br>

Clearly the field labelled `Surname` is actually the `Middlename` field, and the real `Surname` field is not displayed, hence always blank.

<br><br>

![site map new](https://user-images.githubusercontent.com/52076323/84813191-74428e80-b007-11ea-8bc1-deaa87755217.jpeg)

<br><br>

## Bugs

* `/companies/[n]` always displays details for row 1 of the database table
* `Edit` links are incorrectly defined on `/companies/[n]`
* Fields are incorrectly labelled on `/companies/[n]/employees/new`

<br><br>

## Recommendations

* On `/companies`, change `Show` button routes from `/companies/[n]` to `/companies/[n]/employees`.

* On `/companies/new`, change `Save` button route from `/companies/[n]` to `/companies/[n]/employees`.

* Remove `/companies/[n]` pages.

<br>These actions will circumvent the first two bugs.<br>

* Remove current `Surname` field on `/companies/[n]/employees/new` and rename `Middlename` field to `Surname`. Investigate database setup and amend columns if necessary.

## Solutions

* Changed `app/views/companies/index.html.erb line 21` from `<%= link_to "Show", company_path(company), class: "btn btn-primary btn-sm"%>` to `<%= link_to "Show", company_employees_path(company), class: "btn btn-primary btn-sm"%>`.

* Changed `app/controllers/companies_controller.rb line 22` from `redirect_to @company` to `redirect_to company_employees_path(@company)`.

* Added `<%= link_to "Back to companies List", companies_path, class: "btn btn-outline-primary" %>` to `/app/views/employees/index.html.erb`.

* Deleted `app/views/companies/show.html.erb`.

* Changed `app/model/employee.rb line 5` from `validates :forename, :surname, :middlename, presence: true` to `validates :forename, :surname, presence: true`.

* Changed `app/views/employees/new.html.erb line 26` from `<%= form.text_field :middlename, class: "form-control" %>` to `<%= form.text_field :surname, class: "form-control" %>`.

* Deleted `db/migrate/20200120121725_add_middlename_to_employees_table.rb` and all `middlename` attributes from `db/seeds.rb`.

## Other

* Changed `app/views/employees/index.html.erb line 1` from `<h2 class="pb-2">Listing Employees</h2>` to `<h2 class="pb-2">Listing Employees of <%= @company.name %></h2>`.

## Summary

These actions dealt with all three bugs. My last action was in the name of human readability: without this change, `/companies/[n]/employees`, the company name is only shown alongside each employee. Therefore a newly created company would not display the company name, which users may find offputting.

## Testing

I used RSpec and Capybara to test my bug fixes. I would ideally have set up the tests first, but with limited time I had to prioritise. To compensate for this and avoid evergreen testing, I made sure to purposefully write a failing version first, searching for content that I know not to be there.<br>
I began with a couple of smoke tests, before focusing on the bug fixes. I am happy to report there were no major issues with testing.

<br>

![Passing Tests](https://user-images.githubusercontent.com/52076323/84813321-b4097600-b007-11ea-9ae3-bda223847c34.png)
