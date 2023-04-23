# DT.XADE.DBT-Template

This repository contains a template DBT project that can be used for DBT
development on your XADE workspaces.

## Environment Setup

The setup script of this repo uses Python Poetry to handle package management
and create your virtual environments for development.

### Prerequisites

- It is recommended you have requested and have been granted local admin access on your laptop
- It is recommended that you work in a Unix environment (i.e. MacOS)
- Windows machines are also possible but require WSL2 to be installed, which allows you to have a Unix environment on your Windows laptop
  - More details regarding Windows setup will be added very soon (April 2023)
- You *must* have Python installed on your machine
  - For MacOS you can install Python directly from the website: 
    - https://www.python.org/downloads/ 
    - Alternatively you can set up your laptop using the [dt-setup-mac](https://github.dev.xero.com/Xero/dt-setup-mac) process, however keep in mind this process will install other data tooling you may not require
  - For Windows, instructions will be provided very soon (April 2023)


## How to use the template

You can begin these steps once you meet all above prerequisites 

1. Create [a remote repository on GitHub](https://github.dev.xero.com/new). Do *not* choose any templates during creation. You will be prompted for the URL of the repo during *step 4*. 

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
   cruft create https://github.dev.xero.com/Xero/DT.XADE.DBT-Template
   ```

   Fill in the information that `cruft` prompts you for:

   - **Project Name**: The full name of your project. This is used in
     documentation and to generate a project slug, which for a given "Project
     Name" looks like "project-name".
   - **Description**: A short description which is used in generated
     documentation.
   - **Pod Name**: The name of the pod who owns this repository
   - **Pod Email**: An email that links back to your pod (if you don't have one,
     feel free to make up one)
   - **Workspace**: The Snowflake workspace for your project. **Do not** include
     the environment name i.e. `_SANDBOX`. This information is used to set up your DBT project
     to connect to your Snowflake workspaces. You can view this in the generated `profiles.yml` file

4. Next, use the installer inside the your new project folder to set up your repo and install
   basic dependencies.

   First, navigate to the project directory that has just been created, using
   `cd`. For example, if your project is called `my-data-product`:

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

5. _(Optional)_ *This step is optional and only needed if you skipped providing the Github URL in step 4*.
   If for some reason you did not provide the URL to your Github repo during step 4, you can still 
   manually connect to your remote repository following the steps to "push an existing repository 
   from the command-line". These steps should look something like:

   ```bash
   git remote add origin <repo-url>
   git branch -M main
   git push -u origin main
   ```

   For example, if my remote repository was
   `https://github.dev.xero.com/Xero/my-data-product`, the command would be:

   ```bash
   git remote add origin https://github.dev.xero.com/Xero/my-data-product
   git branch -M main
   git push -u origin main
   ```

6. Restart your terminal/shell and ensure Poetry is installed
   `poetry --version`.

When inside your `dbt/` folder you can run any dbt command within this virtual
environment by prefixing your command with `poetry run` e.g.
`poetry run dbt run --profiles-dir .`

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) If `poetry --version` does not work:
  - Check that Poetry has been added to your bashrc or zshrc. 
     - You can check if you are using bash or zsh by running `echo $0`
  - e.g. For zsh users run `cat ~/.zshrc` and check if the following line is present:
  `export PATH="$HOME/.poetry/bin:$PATH"`

![#f03c15](https://via.placeholder.com/15/f03c15/000000?text=+) If running
`poetry --version` still fails, run `make install` again

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

The dbt target determines the method of Snowflake connectivity DBT will perform,
along with other global settings such as how schema naming should happen when
models are run. You can set the DBT target in the environment variable
`DBT_TARGET` via `export DBT_TARGET=sandbox_dev`. You can view the dbt profile
config in `dbt/profiles.yml`

- dev
  - This dbt target will enable connectivity via your user account and relies on
    externalbrowser authentication (just click SSO).
  - This target causes all schemas, by default, to be created under your name
    prefixed with DEV*. e.g. if your schema settings inside a model definition
    are set to `FACT`, then these will be created under
    `DEV*<YOURNAME>\_FACT`schema. e.g.`DEV_ADEEB_FACT`
  - Purpose: This is to enable each engineer to do development, run their
    models, have tables created, without impacting the objects the other
    engineers are working on
- sandbox_local
  - This dbt target will enable connectivity via your user account and relies on
    externalbrowser authentication (just click SSO).
  - This target ignores the schema name defined in `profiles.yml` and instead
    only uses the schema specified provided in your model
  - This target is the same as the `sandbox` target below, but is for use
    locally from your laptop to observe the same behaviour
- sandbox / lab / hway
  - These are CICD targets and use the sandbox service account to connect to
    Snowflake
  - These targets are to be used when by an automation tool (e.g. TeamCity)
    deployment
  - These targets ignore the schema name defined in `profiles.yml` and instead
    only uses the schema specified provided in your model

## Integrating with XOS

This template can be used to register `dbt` flows on the XADE Orchestration
Service.

Configuration is set in the `xos-deployments.yml` file. **For details on how to
setup this integration, follow the
[provided User Guide](https://xero.atlassian.net/wiki/spaces/DATATEAM/pages/269755945637/XOS+-+User+Guide+-+Prefect+Deployer)**
