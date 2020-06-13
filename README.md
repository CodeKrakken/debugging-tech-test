# Customer Service Support Technician Tech Test
Test for CS Support candidates

## Process

First of all I walked through the program in the browser, putting myself in the user's shoes. What problem had they been having? I methodically checked all links and noted URLs, constructing a sitemap as I went.

## Findings

The first bug I found was on /companies/[1-4]. Although each "Show" button on /companies takes you to the right URL, the details listed are always for the top company.
<br>
This suggests an issue pulling data from the database. Each page of /companies/[1-4]