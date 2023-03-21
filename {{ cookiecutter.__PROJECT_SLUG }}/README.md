# {{cookiecutter.PROJECT_NAME}}



## DBT Profile Targets
The dbt target determines the method of Snowflake connectivity DBT will perform, along with other global settings such as how schema naming should happen when models are run. You can set the DBT target in the environment variable `DBT_TARGET` via `export DBT_TARGET=dev`. You can view the dbt profile config in `dbt/profiles.yml`
 - dev
   - This dbt target will enable connectivity via your user account and relies on externalbrowser authentication (just click SSO).
   - This target causes all schemas, by default, to be created under your name prefixed with DEV_. e.g. if your schema settings inside a model definition are set to `FACT`, then these will be created under `DEV_<YOURNAME>_FACT` schema. e.g. `DEV_ADEEB_FACT`
   - Purpose: This is to enable each engineer to do development, run their models, have tables created, without impacting the objects the other engineers are working on
 - dev_ci
   - This dbt target will enable connectivity via your user account and relies on externalbrowser authentication (just click SSO).
   - This target ignores the schema name defined in `profiles.yml` and instead only uses the schema specified provided in your model
   - This target is the same as the `sandbox` target below, but is for use locally from your laptop to observe the same behaviour
 - uat / prod
   - These are CICD targets and use the sandbox service account to connect to Snowflake
   - These targets are to be used when by an automation tool (e.g. TeamCity) deployment
   - These targets ignore the schema name defined in `profiles.yml` and instead only uses the schema specified provided in your model


### Re-install Poetry
 - You can re-install poetry by simply running `make install`
 - To do a clean install of poetry:
  ```bash
  make clean install
  ```

## Update Poetry Dependencies
 - You are welcome to manually update Poetry dependencies by editing the `pyproject.toml` file
 - After editing the file you can run `poetry update` to align versions and dependencies
 - To align your project with the template dependencies, run `cruft update`