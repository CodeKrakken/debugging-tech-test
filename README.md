# Customer Service Support Technician Tech Test
Test for CS Support candidates

<br>

## Process

First of all I walked through the program in the browser, putting myself in the user's shoes. I methodically checked all links and noted URLs, constructing a sitemap as I went. As the three bugs are as yet undefined, I have listed their effects as separate issues.

<br>

## Issue 1

Clicking `Show` for any of the companies on `/companies` takes you to `/companies/[n]`. Although each button interpolates the URL with the correct company ID, the details listed are always for Company 1.
<br>
This suggests a database issue. I suspect that `/companies/[n]` is hardcoded to pull data from row 1 of the table. Indeed, deleting Company 1 causes the remaining pages to show Company 2's data, now found in row 1.
<br>
This issue also affects company creation on `/companies/new`. It saves the new company details correctly but the new `/companies/[n]` page inherits the issue.

<br>

## Issue 2

Still on `/companies/[n]`, `Add employee` routes you to `/companies/1/employees/new`, regardless of which company you are viewing. It is possible that this defaulting to Company 1 is related to Issue 1. 

<br>

## Issue 3

Advancing along this branch of the program, I check the `Edit` link for each employee of Company 1. It always takes me to Employee 1's details. The URLs are as follows:

<br>

```
/companies/1/employees/1/edit
/companies/2/employees/1/edit
/companies/3/employees/1/edit
/companies/4/employees/1/edit
```

<br>

Since they are all from Company 1, it would be logical to set the links thus:

<br>

```
/companies/1/employees/1/edit
/companies/1/employees/2/edit
/companies/1/employees/3/edit
/companies/1/employees/4/edit
```

<br>

A quick check of Company 2's `edit` links yields the following URLs:

<br>

```
/companies/1/employees/2/edit
/companies/2/employees/2/edit
/companies/3/employees/2/edit
/companies/4/employees/2/edit
```

<br>

Each one displays the details for Company 1 Employee 2. This pattern follows for Companies 3 & 4, suggesting that the inrerpolation of the URLs is backwards. However, we cannot clarify until the site is pulling the correct data for each company. <br>

## Issue 4

Incorrect details notwithstanding, clicking `Save` does correctly update the displayed employee's details. However we are then taken to `/companies/[n]/employees`, a near duplicate of `/companies/[n]`. `Back to employees list` follows suit, as do `/companies[n]/employees/new`'s buttons. We see the wrong company's details, but only because of Issue 2 - it is not a separate bug.<br>
The employee `Edit` buttons have here been replaced by `Edit Employee` and `Destroy Employee` - both buttons function correctly. There is no `Back to companies list` button here, but this is more of an oversight than a bug.

<br><br>

## Issue 5

Although clicking `Add Employee` on `/companies/[n]` will only take us to `/companies/1/employees/new`, `/companies/[n]/employees`'s equivalent `Create New Employee` button allows us to access each company correctly. However, clicking `Save` throws an error:

* Surname can't be blank<br>

This persists when the field is filled. I next tried with the surname blank, yielding the following result:

* Surname can't be blank
* Middlename can't be blank<br>

Clearly the field labelled `Surname` is actually the `Middlename` field, and the real `Surname` field is not displayed, hence always blank.

<br><br>

## Bugs

* `/companies/[n]` always pulls from row 1 of the database table
* `Edit` links are incorrectly interpolated on `/companies/[n]`
* Fields are incorrectly labelled on `/companies/[n]/employees/new`

<br><br>

## Recommendations

* On `/companies`, change `Show` button routes from `/companies/[n]` to `/companies/[n]/employees`.

* On `/companies/new`, change button routes from `/companies/[n]` to `/companies/[n]/employees`.

* Remove `/companies/[n]` pages.

<br>These actions will circumvent the first two bugs.<br>

* Remove current `Surname` field on `/companies/[n]/employees/new` and rename `Middlename` field to `Surname`. Investigate database setup and amend columns if necessary.

<br><br>

![site map new](https://user-images.githubusercontent.com/52076323/84813191-74428e80-b007-11ea-8bc1-deaa87755217.jpeg)

<br><br>

## Solutions

### Bugs 1 & 2

* Changed `app/views/companies/index.html.erb line 21` from `<%= link_to "Show", company_path(company), class: "btn btn-primary btn-sm"%>` to `<%= link_to "Show", company_employees_path(company), class: "btn btn-primary btn-sm"%>`.

* Changed `app/controllers/companies_controller.rb line 22` from `redirect_to @company` to `redirect_to company_employees_path(@company)`.

* Added `<%= link_to "Back to companies List", companies_path, class: "btn btn-outline-primary" %>` to `/app/views/employees/index.html.erb`.

* Deleted `app/views/companies/show.html.erb`.

### Bug 3

* Changed `app/model/employee.rb line 5` from `validates :forename, :surname, :middlename, presence: true` to `validates :forename, :surname, presence: true`.

* Changed `app/views/employees/new.html.erb line 26` from `<%= form.text_field :middlename, class: "form-control" %>` to `<%= form.text_field :surname, class: "form-control" %>`.

* Deleted `db/migrate/20200120121725_add_middlename_to_employees_table.rb` and all `middlename` attributes from `db/seeds.rb`.

### Other

* Changed `app/views/employees/index.html.erb line 1` from `<h2 class="pb-2">Listing Employees</h2>` to `<h2 class="pb-2">Listing Employees of <%= @company.name %></h2>`. Without this change, `/companies/[n]/employees`, a newly created company does not display the company name, which may confuse users.

## Testing

I tested my bug fixes with RSpec and Capybara. I would have set up the tests first, but with limited time I had to prioritise. To ensure integrity and avoid evergreen testing, I first made each test fail by expecting non existent content.<br>
I began with a couple of smoke tests, before working through the bugs. There were no major issues with testing.

<br>

![Passing Tests](https://user-images.githubusercontent.com/52076323/84813321-b4097600-b007-11ea-9ae3-bda223847c34.png)
