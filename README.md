# beautiful-dbt-template
This repository contains a template DBT project that can be used for DBT development on Snowflake.

## Environment Setup
The setup script of this repo uses Python Poetry to handle package management and create your virtual environments for development.

### Prerequisites
 - It is recommended that you work in a Unix environment (i.e. MacOS or WSL2 on Windows)
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

### Environment Setup Steps (Mac or WSL Ubuntu)
 1. Create an empty [repository on GitHub](https://github.com/new) via the UI
 2. Install `pipx` if not already installed: `sudo apt install pipx`
 3. Install `cookiecutter` using [`pipx`](https://github.com/pipxproject/pipx)
    ```bash
    pipx install cookiecutter
    ```
 4. Use `cookiecutter` to instantiate this template on your local machine

    ```bash
    cookiecutter https://github.com/Armalite/beautiful-dbt-template
    ```
 5. Fill in the information that `cookiecutter` prompts you to add:
    - **PROJECT_NAME**: The full name of your project. This is used in documentation and to generate a project slug, which for a given "Project Name" looks like "project-name".
    - **DESCRIPTION**: A short description which is used in generated documentation.
    - **AUTHOR_NAME**: Name of the project author
    - **SNOWFLAKE_ACCOUNT**: The Snowflake account you want your DBT project to connect to.
    - **USER_BNAME**: The Snowflake username you will connect
    - **Remote Git URL**: The full URL to the empty Github repository you have created via the UI
 6. After filling out this information, cookiecutter will download poetry dependencies, and initialise your instantiated template as a git repository.
 7. You should now have a .venv virtual environment folder created in your repository folder.
 8. When inside your `dbt/` folder you can run any dbt command within this virtual environment by prefixing your command with `poetry run` e.g. `poetry run dbt run --profiles-dir .`


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
The git repository created by the above steps will contain a README describing all the DBT targets

