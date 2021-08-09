## Technical Decisions

> I'll add here how I found the solutions to the problems I had during the development of this project. *Most of the time, the solution is a random comment from Valim*

## CI/CD

Here is the list of references that I used to build `elixir.yml` and `gigalixir.yml`:

- https://gigalixir.readthedocs.io/en/latest/deploy.html?highlight=github%20actions#how-to-set-up-continuous-integration-ci-cd
- https://github.com/actions/starter-workflows
- https://github.com/actions/starter-workflows/blob/main/ci/elixir.yml

## Seeds

References that helped me to solve `Seeds` (I was completely surprised at how fast it got):

- [Programming Ecto book](https://pragprog.com/titles/wmecto/programming-ecto/) - `Chapter 17: Tuning for Performance`
- https://hexdocs.pm/phoenix/1.3.0-rc.1/seeding_data.html
- https://elixirforum.com/t/what-is-the-best-approach-for-fetching-large-amount-of-records-from-postgresql-with-ecto/3766/23
- https://elixirforum.com/t/is-there-are-way-to-bulk-insert-join-records-of-a-many-to-many-relationship-with-ecto/13630
- https://dinojoaocosta.medium.com/elixir-findings-asynchronous-task-streams-7f6336227ea

## Schedule GenServer `handle_info``

I searched several sources for the best way to schedule the genserver task repeatedly until I found this [Valim's answer](https://stackoverflow.com/a/32097971), what I used.

But as future improvements, I've added a note to maybe try another approach.

## Postgres

I had a lot of problems with my Postgres setup (+ Docker) until I found this [article](https://www.codementor.io/@engineerapart/getting-started-with-postgresql-on-mac-osx-are8jcopb).

It helped solve my environment variables erros.

# To be continued...
