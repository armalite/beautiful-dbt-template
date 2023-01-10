# beautiful-dbt-template
This repository contains a template DBT project that can be used for DBT development on Snowflake.


## Environment Setup
The setup script of this repo uses Python Poetry to handle package management and create your virtual environments for development.

### Prerequisites
 - It is recommended that you work in a Unix environment (i.e. MacOS)
 - Windows machines are also possible but may require further tweaking
 - This repository assumes your Snowflake environments are set up in a particular structure:
   - You work in a single instance of Snowflake (e.g. the Prod instance)
   - Your 'environments' (dev, uat, prod) are simply different databases in the Prod instance
   - The PROJECT_NAME you supply is used as a prefix to name most of your Snowflake infrastructure resources (database, roles, warehouses)
   - You have a separate Database and associated infra for dev, uat and prod e.g. if your project name is "JAFFLE SHOP", the dbt profile will be set up assuming the following:
      - Your dev database should be called JAFFLE_SHOP_DEV
      - Your dev warehouse should be called JAFFLE_SHOP_DEV_WH
      - Your dev service account user should be called JAFFLE_SHOP_DEV_SA
      - Your dev admin role should be called JAFFLE_SHOP_DEV_ADMIN
   - Your service accounts can use Private keys for authentication
      - If Private keys have not been set up, you will need to update the dbt `profiles.yml` file to make sure the non development targets use passwords instead


### Environment Setup Steps (Mac)
 1. Install `cookiecutter` using [`pipx`](https://github.com/pipxproject/pipx)
    ```bash
    pipx install cookiecutter
    ```

 1. Use `cookiecutter` to instantiate this template on your local machine

    ```bash
    cookiecutter git@github.com:Armalite/beautiful-dbt-template.git
    ```

 1. Fill in the information that `cookiecutter` prompts you to add:
    - **Project Name**: The full name of your project. This is used in documentation and to generate a project slug, which for a given "Project Name" looks like "project-name".
    - **Description**: A short description which is used in generated documentation.
    - **Snowflake Account**: The Snowflake account you want your DBT project to connect to.
    - **Snowflake Username**: The Snowflake username you will connect
    - **Snowflake Password**: You can set this in an environment variable SNOWFLAKE_PASSWORD and the dbt project will use that for development target(s)


 1. After filling out this information, cookiecutter will download poetry dependencies, and initialise your instantiated template as a git repository.

1. *(Optional)* If you would like to track your changes on GitHub, you will need to [create a remote repository on GitHub](https://github.dev.xero.com/new) for your project. Make sure this remote repository is empty (don't add any templates).

   Once you have set up your remote repository, you can connect it to your local repository following the steps to "push an existing repository from the command-line". These steps should look something like:
    ```
    git remote add origin git@github.dev.xero.com:Xero/<repo-name>.git
    git branch -M main
    git push -u origin main
    ```
    For example, if my remote repository was https://github.dev.xero.com/Xero/dt-xerogo-transforms, the \<repo-name\> would be `dt-xerogo-transforms` and the command would be:
    ```
    git remote add origin git@github.dev.xero.com:Xero/dt-xerogo-transforms.git
    git branch -M main
    git push -u origin main
    ```

 1. *(Optional)* Edit the `pyproject.toml` file to add an author for Poetry to set
 1. Check that Poetry has been added to your bashrc or zshrc. e.g. Run `cat ~/.zshrc` and ensure the following line is present: `export PATH="$HOME/.poetry/bin:$PATH"`
 1. Restart your terminal/shell and ensure Poetry is installed `poetry --version`.
 1. You should now have a .venv virtual environment folder created in your repository folder.
 1. When inside your `dbt/` folder you can run any dbt command within this virtual environment by prefixing your command with `poetry run` e.g. `poetry run dbt run --profiles-dir .`

 ![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) If running `poetry --version` fails after step `6.` above, run `make install` again

### Re-install Poetry
 - You can re-install poetry by simply running `make install`
 - To do a clean install of poetry:
  ```bash
  make clean install
  ```

### Update Poetry Dependencies
 - You are welcome to manually update Poetry dependencies by editing the `pyproject.toml` file
 - After editing the file you can run `poetry update` to align versions and dependencies
 - To align your project with the template dependencies, run `cruft update`

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

