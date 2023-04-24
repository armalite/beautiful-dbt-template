# Templating

This project is built using the Beau DBT Template.

This file and the files found under `.beau` managed by the Beau Template
repository, **editing these files may result in merge conflicts when using
`cruft update`.**

## Retrieving updates from the [Beautiful DBT template](https://github.com/Armalite/beautiful-dbt-template)

Updates from the XTS DBT template are added to your local machine using:

```bash
cruft update
```

If you do not have `cruft` installed on your machine, follow the "Environment
Setup Steps" in the
[Beautiful DBT template](https://github.com/Armalite/beautiful-dbt-template/blob/main/README.md)

## Checking for updates from the [Beautiful DBT template](https://github.com/Armalite/beautiful-dbt-template)

If you want to check for updates, you can use:

```bash
cruft check
```

This will let you know if there are new updates to the template.

If you want to ensure you are always keeping your template up to date, you can
also use this check in CI. The check will return an exit code of 1 if there are
any new changes which you can use to prevent code changes from being merged
until it is resolved

## Contributing

If you ever need to tweak anything inside `.beau/`, you could also raise a change for the template itself. 
Raise a PR in the
[Beautiful DBT template](https://github.com/Armalite/beautiful-dbt-template).
