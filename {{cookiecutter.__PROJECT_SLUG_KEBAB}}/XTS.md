# Templating

This project is built using the XADE Transformation Service DBT Template.

This file and the files found under `.xts` managed by the XTS Template
repository, **editing these files may result in merge conflicts when using
`cruft update`.**

## Retrieving updates from the [XTS template](https://github.dev.xero.com/Xero/DT.XADE.DBT-Template)

Updates from the XTS DBT template are added to your local machine using:

```bash
cruft update
```

If you do not have `cruft` installed on your machine, follow the "Environment
Setup Steps" in the
[Template README.md](https://github.dev.xero.com/Xero/DT.XADE.DBT-Template/blob/main/README.md)

## Checking for updates from the [XTS template](https://github.dev.xero.com/Xero/DT.XADE.DBT-Template)

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

If you ever need to tweak anything inside `.xts/`, it likely means that we also
need to update the template. If you know how, raise a PR in the
[XTS template repo](https://github.dev.xero.com/Xero/DT.XADE.DBT-Template).
Otherwise, reach out over
[#xade-transformation-service](https://xero.slack.com/archives/C02H795MQQN) so
that we can make sure the fix gets out to everyone else.
