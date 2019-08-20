# Technical Interview - Data Engineer

> This technical evaluation is aimed at senior level data-engineers.

The evaluation is designed to asses if a candidate possesses the essential Tech Skills that are needed for this role such as

* Strong T-SQL knowledge, stored-procedures, OPENJSON
* Strong understanding of Dimensional/Kimball/Snowflake data-models
* Good Understanding of DevOps processes
* Good understanding of Docker specifically able to install and run `docker-compose -f "docker-compose.yml" up -d --build`

The evaluation aims to be as realistic as possible, all tasks are Tickets within the `.\TicketsTask` folder.

> Note: Your evaluation email will outline what tickets need to be completed.

## System Requirements

You will need access to a machine (Windows/Mac/Linux) with the following installed.

* Git (_with a GitHub Account_)
* Git Hub Desktop (or any git tool you use)
* Docker Community Edition ([Download Page](https://hub.docker.com/search/?type=edition&offering=community))
  * [Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)
  * [MacOS](https://hub.docker.com/editions/community/docker-ce-desktop-mac)
* Azure Data Studio ([download](https://docs.microsoft.com/en-us/sql/azure-data-studio/download?view=sql-server-2017))
* SQL Server Management Studio. ([download](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017))

> Important: Docker must be running in `Linux` container mode
> Tip: If you run into any issues with Docker, first step is to restart Docker. (Especially on Windows) 

## _default_ SQL Server Credentials

* **SQL Server Login**: `sa`
* **SQL Server Password**: `P@ssw0rd!` (or value of `SQL_SERVER_PASSWORD` in `.env` file)
* **SQL Server Port**: `14333`

## Getting Started

**Github:**

1. Click on the `Use this template` and create a copy of this repository
1. Optionally and recommended, please set repository to Private

**On your PC:**

1. Clone the copy of the repository you created to your local machine (_not this repo_)
1. Install Docker and required tools if not done already

**Quick Start:**

1. Start `docker-compose -f "docker-compose.yml" up -d --build`
1. wait up-to a minute (_to be safe_)
1. connect to the database
1. if there is no database called `datawarehouse`, restart docker and try again.
1. review execution logs `docker-compose logs -f` for any problems (`-f` is follow)

**Interview Tasks:**

1. The tasks are contained within `.\TicketsTask` folder. (_Please note your email will supersede this step_)
1. Save your OBJECT scripts in `.\db_Datawarehouse\sql\*` appropriately.
    1. Flyway is the build tool used.
    1. Please read more [here](./db_Datawarehouse/about-flyway.md)
    1. You can also review existing files as examples
1. If your solution drifts from TSQL, please include instructions in a markdown file called `instructions.md`

**Submission:**

_If Your email will contain information on submission please use that or else._

1. Invite GitHub User to your repo Under `settings/collaboration`
1. add `@kgeorge314` as a collaborator

**Some Useful Commands:**

* To Stop `docker-compose -f "docker-compose.yml" down`
* To Start `docker-compose -f "docker-compose.yml" up -d --build`
* To see running images `docker ps -a`
* To remove all container (use with caution if you have other containers) `docker ps -a --format '{{ json .}}' | ConvertFrom-Json | %{ docker rm "$($_.id)" -f }^C`
* To remove images
  * Flyway: `docker rmi boxfuse/flyway:5.2.4`
  * InitTools: `docker rmi aletasystemsroledataengineerphase2_inittools`
  * SQL Server `mcr.microsoft.com/mssql/server`
