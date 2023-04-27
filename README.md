# Beau DBT Template

This repository contains a template DBT project that can be used for DBT
development on Snowflake.

## Environment Setup

The setup script of this repo uses Python Poetry to handle package management
and create your virtual environments for development.

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
- You *must* have Python installed on your machine
  - For MacOS you can install Python directly from the website: 
    - https://www.python.org/downloads/ 


## How to use the template

You can begin these steps once you meet all above prerequisites 

1. Create [a remote repository on GitHub](https://github.com/new). Do *not* choose any templates during creation. You will be prompted for the URL of the repo during *step 4*. 

2. Install `cruft` using [`pipx`](https://github.com/pipxproject/pipx)

   ```bash
   pipx install cruft
   ```

3. Use `cruft` to instantiate this template on your local machine

   By default, cruft will create the template where your terminal is. Use the
   `cd` command to navigate to the directory you want your project to be in. For
   example, if you want to keep the project under `Documents` on Mac, use
   `cd ~/Documents`

   **Once you are in the directory that you want to create the template in, run
   the following command:**

   ```bash
   cruft create https://github.com/Armalite/beautiful-dbt-template
   ```

   Fill in the information that `cruft` prompts you for:

   - **Project Name**: The full name of your project. This is used in
     documentation and to generate a project slug, which for a given "Project
     Name" looks like "project-name". This is also used to generate database names
     for your dbt `profiles.yml` as well as your repo folder
   - **Description**: A short description which is used in generated
     documentation.
   - **Team Name**: The name of your team (leave blank or invent one if not available)
   - **Team Email**: Team email of your team (leave blank or invent one if not available)
   - **AUTHOR_NAME**: Name of the project author
   - **SNOWFLAKE_ACCOUNT**: The Snowflake account you want your DBT project to connect to.
   - **USER_NAME**: The Snowflake username you will connect

4. Next, use the installer inside the your new project folder to set up your repo and install
   basic dependencies.

   First, navigate to the project directory that has just been created. For example, if your project is called `my-data-product`:

   ```bash
   cd my-data-product
   ```

   Then execute the following command:

   ```bash
   make install
   ```

   This command does the following:

   - Initialises a git repository for you
   - Prompts you for the URL to your remote Github repo (created in *step 1*) so that it can connect to it
   - Installs all the dependencies needed to run DBT

5. Restart your terminal/shell and ensure Poetry is installed
   `poetry --version`.

When inside your `dbt/` folder you can run any dbt command within this virtual
environment by prefixing your command with `poetry run` e.g.
`poetry run dbt run --profiles-dir .`



### (Optional) Connecting your remote repo
_(Optional)_ *This step is optional and only needed if you skipped providing the Github URL in step 4*.
   If for some reason you did not provide the URL to your Github repo during step 4, you can still 
   manually connect to your remote repository following the steps to "push an existing repository 
   from the command-line". These steps should look something like:

   ```bash
   git remote add origin <repo-url>
   git branch -M main
   git push -u origin main
   ```

   For example, if my remote repository was
   `https://github.com/Bob/my-data-product`, the command would be:

   ```bash
   git remote add origin https://github.com/Bob/my-data-product
   git branch -M main
   git push -u origin main
   ```

### Troubleshooting

#### Poetry did not install
![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) If `poetry --version` does not work:
  - Check that Poetry has been install at a particular location: `where poetry`
  - You can add the above location to the path by appending your zsh or bash file (Depending on the shell you use) with:
  `export PATH="X:$PATH"`
  Replacing X with the location outputed by `where poetry`

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) If running
`poetry --version` still fails, try to run `make install` again

#### Poetry not in path

### Re-installing Poetry

You can re-install poetry by running:

```bash
make install
```

And you can do a clean install of poetry by running:

```bash
make clean install
```

### Update Poetry Dependencies

Additional dependencies are specified by editing the `pyproject.toml` file. This
file will not be changed by `cruft` on updates.

After editing the file you can run `poetry update` to align versions and
dependencies


## DBT Profile Targets
The git repository created by the above steps will contain a README describing all the DBT targets
